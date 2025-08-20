import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/checkout/managers/payment_manager.dart';
import 'package:tasawaaq/features/checkout/responses/payment_response.dart';
import 'package:tasawaaq/features/payment_status/payment_call_url/paymentResponse.dart';
import 'package:tasawaaq/features/payment_status/payment_status_page.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPageArgs {
  final PaymentResponse? response;

  PaymentPageArgs({
    this.response,
  });
}

class PaymentWebPage extends StatefulWidget {
  PaymentWebPage({Key? key}) : super(key: key);

  @override
  _PaymentWebPageState createState() => _PaymentWebPageState();
}

class _PaymentWebPageState extends State<PaymentWebPage> {
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  // Completer<WebViewController> _controller = Completer<WebViewController>();
  late WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    final prefs = context.use<PrefsService>();
    final PaymentPageArgs args =
        ModalRoute.of(context)!.settings.arguments as PaymentPageArgs;

    return WillPopScope(
      onWillPop: () async {
        locator<PaymentManager>().inState.add(ManagerState.IDLE);
        locator<PaymentManager>().managerState = ManagerState.IDLE;
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: MainAppBar(
            hasCart: false,
            title: Text('${context.translate(AppStrings.CHECKOUT)}'),
            onBackClicked: () {
              locator<PaymentManager>().inState.add(ManagerState.IDLE);
              locator<PaymentManager>().managerState = ManagerState.IDLE;
              Navigator.of(context).pop();
            },
          ),
        ),
        body:
            // SingleChildScrollView(
            //   child:
            ValueListenableBuilder<bool>(
                valueListenable: isLoading,
                builder: (context, value, __) {
                  return value
                      ? Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: SpinKitWave(
                              color: AppStyle.appBarColor,
                              itemCount: 5,
                              size: 50.0,
                            ),
                          ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          child: WebView(
                            onWebViewCreated: (controller) async {
                              // _controller.complete(controller);
                              _controller = controller;
                              print('XXxXX${await _controller.currentUrl()}');
                            },
                            navigationDelegate:
                                (NavigationRequest navigation) async {
                              // print('XXxXX${await _controller.currentUrl()}');
                              NavigationDecision _n = NavigationDecision.navigate;print('XXxXX${navigation.url}');
                              // success
                              // payment_fail
                              if (navigation.url.contains('success')) {

                                PaymentResponseMethod.paymentResponseMethod(navigation.url).then((value) {
                                  Navigator.of(context).pushReplacementNamed(
                                      AppRouts.PaymentStatusPage,
                                      arguments: PaymentStatusPageArgs(
                                          isSuccess: true,
                                          orderId:
                                          '${args.response?.data?.orderId}',
                                          itemCount:
                                          '${args.response?.data?.items}',
                                          total:
                                          '${args.response?.data?.total} ${args.response?.data?.currency}'));
                                });



                              } else if (navigation.url.contains('fail')) {
                                Navigator.of(context).pushReplacementNamed(
                                    AppRouts.PaymentStatusPage,
                                    arguments: PaymentStatusPageArgs(
                                        isSuccess: false,
                                        orderId:
                                            '${args.response?.data?.orderId}',
                                        itemCount:
                                            '${args.response?.data?.items}',
                                        total:
                                            '${args.response?.data?.total} ${args.response?.data?.currency}'));
                              }

                              // if (navigation.url.contains('payment_result_api')) {
                              // if (await _controller.canGoForward() == false) {
                              //   _n = NavigationDecision.prevent;
                              // }

                              return _n;
                            },
                            initialUrl: '${args.response?.data?.paymentUrl}',
                            javascriptMode: JavascriptMode.unrestricted,
                            // onPageFinished: (url) async {
                            //   print('OOoOO $url');
                            //   if (url.contains('payment_result')) {
                            //     isLoading.value = true;
                            //     await PaymentResponse.paymentResponse(url)
                            //         .then((value) {
                            //       if (value?.status == 1) {
                            //         Navigator.of(context).pushReplacementNamed(
                            //             AppRouts.PAYMENT_SUCCESS,
                            //             arguments: PaymentSuccessPageArgs(
                            //               orderId: args.response?.data?.orderId,
                            //               total: args.response?.data?.total,
                            //             ));
                            //       } else {
                            //         Navigator.of(context).pushReplacement(
                            //           MaterialPageRoute(
                            //             builder: (_) => PaymentFail(),
                            //           ),
                            //         );
                            //       }
                            //     });
                            //   }
                            // },
                          ),
                        );
                }),
        // ),
      ),
    );
  }
}
