import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/checkout/managers/checkout_info_manager.dart';
import 'package:tasawaaq/features/checkout/managers/payment_manager.dart';
import 'package:tasawaaq/features/checkout/promo_code/coupon_manager.dart';
import 'package:tasawaaq/features/checkout/requests/checkout_request.dart';
import 'package:tasawaaq/features/checkout/responses/checkout_info_response.dart';
import 'package:tasawaaq/features/checkout/widgets/check_out_Shipping%20Address_widget.dart';
import 'package:tasawaaq/features/checkout/widgets/checkout_StatisticsItem.dart';
import 'package:tasawaaq/features/checkout/widgets/checkout_products.dart';
import 'package:tasawaaq/features/checkout/widgets/coupon_widget.dart';
import 'package:tasawaaq/features/checkout/widgets/payment_method.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/check_box/check_box.dart';
import 'package:tasawaaq/shared/custom_button/custom_button.dart';
import 'package:tasawaaq/shared/remove_focus/remove_focus.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  void initState() {
    super.initState();
    locator<CheckoutInfoManager>().inPaymentMethod = PaymentMethod();
    locator<CheckoutInfoManager>().selectAddressSubject.value = null;
    locator<CheckoutInfoManager>().couponData = null;
    locator<PaymentManager>().inState.add(ManagerState.IDLE);
    locator<PaymentManager>().managerState = ManagerState.IDLE;
    locator<CouponManager>()
        .promoCodeMsg
        .sink
        .add(PromoObject(id: "", title: ""));

    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.use<CheckoutInfoManager>().execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final checkoutInfoManager = context.use<CheckoutInfoManager>();
    final toast = context.use<ToastTemplate>();
    final paymentManager = context.use<PaymentManager>();
    final couponManager = context.use<CouponManager>();
    final prefs = context.use<PrefsService>();

    return GestureDetector(
      onTap: () {
        removeFocus(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        persistentFooterButtons: [
          Observer<CheckoutInfoResponse>(
              onRetryClicked: () {
                checkoutInfoManager.execute();
              },
              manager: checkoutInfoManager,
              stream: checkoutInfoManager.checkoutInfo$,
              onWaiting: (c) => Container(),
              onSuccess: (context, checkoutInfoSnapshot) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if ("${checkoutInfoSnapshot.data!.returnStatus}" == "yes")
                      Column(
                        children: [
                          ValueListenableBuilder<bool?>(
                              valueListenable:
                                  checkoutInfoManager.switchReturnNotifier,
                              builder: (_, value, __) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (checkoutInfoManager
                                                .switchReturnNotifier.value ==
                                            true) {
                                          checkoutInfoManager
                                              .switchReturnNotifier
                                              .value = false;
                                        } else {
                                          checkoutInfoManager
                                              .switchReturnNotifier
                                              .value = true;
                                        }
                                      },
                                      child: checkoutInfoManager
                                                  .switchReturnNotifier.value ==
                                              true
                                          ? BoxChecked()
                                          : BoxNotChecked(),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                        child: Text(
                                      '${context.translate(AppStrings.return_conditions)}',
                                    ))
                                  ],
                                );
                              }),
                          const SizedBox(
                            height: 7,
                          ),
                        ],
                      ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      child: CustomButton(
                        onClickBtn: () {
                          if ("${checkoutInfoSnapshot.data!.returnStatus}" ==
                                  "yes" &&
                              checkoutInfoManager.switchReturnNotifier.value !=
                                  true) {
                            return;
                          }
                          print('@@@ ${paymentManager.managerState}');
                          if (paymentManager.managerState ==
                              ManagerState.IDLE) {
                            if (checkoutInfoManager
                                    .selectAddressSubject.value ==
                                null) {
                              toast.show(prefs.userObj != null
                                  ? '${context.translate(AppStrings.Select_Address)}'
                                  : '${context.translate(AppStrings.ENTER_ADDRESS)}');
                              return;
                            }
                            if (checkoutInfoManager
                                    .getSelectedPaymentMethod()
                                    .id ==
                                null) {
                              toast.show(
                                  '${context.translate(AppStrings.Select_Payment_method)}');
                              return;
                            }

                            if (checkoutInfoManager
                                        .getSelectedPaymentMethod()
                                        .id ==
                                    0 ||
                                checkoutInfoManager
                                        .getSelectedPaymentMethod()
                                        .id ==
                                    1) {
                              paymentManager.payment(
                                  request: PaymentRequest(
                                      offerId: checkoutInfoManager.couponData ==
                                              null
                                          ? ''
                                          : '${checkoutInfoManager.couponData?.coponId}',
                                      addressId:
                                          '${checkoutInfoManager.selectAddressSubject.value?.id}',
                                      paymentMethod:
                                          '${checkoutInfoManager.getSelectedPaymentMethod().title}'),
                                  isCash: false);
                            } else {
                              paymentManager.payment(
                                  request: PaymentRequest(
                                      offerId: checkoutInfoManager.couponData ==
                                              null
                                          ? ''
                                          : '${checkoutInfoManager.couponData?.coponId}',
                                      addressId:
                                          '${checkoutInfoManager.selectAddressSubject.value?.id}',
                                      paymentMethod:
                                          '${checkoutInfoManager.getSelectedPaymentMethod().title}'),
                                  isCash: true);
                            }
                          }

                          // continueGuestRegister(context, () {
                          //   locator<NavigationService>()
                          //       .pushNamedTo(AppRouts.PaymentStatusPage,
                          //           arguments: PaymentStatusPageArgs(
                          //             isSuccess: true,
                          //             itemCount: "2",
                          //             orderId: "#2345555",
                          //             total: "45",
                          //           ));
                          // });
                        },
                        txt: '${context.translate(AppStrings.Submit_Order)}',
                        btnWidth: double.infinity,
                        btnColor: AppStyle.yellowButton,
                      ),
                    ),
                  ],
                );
              })
        ],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: MainAppBar(
            title: Text('${context.translate(AppStrings.CHECKOUT)}'),
            hasCart: false,
          ),
        ),
        body: Observer<CheckoutInfoResponse>(
            onRetryClicked: () {
              checkoutInfoManager.execute();
            },
            manager: checkoutInfoManager,
            stream: checkoutInfoManager.checkoutInfo$,
            onSuccess: (context, checkoutInfoSnapshot) {
              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: ListView(
                      children: [
                        CheckOutShippingAddressesWidget(
                          addresses: checkoutInfoSnapshot.data?.addresses,
                        ),
                        Divider(
                          height: 50,
                        ),
                        CouponWidget(),
                        Divider(
                          height: 50,
                        ),
                        PaymentMethodWidget(),
                        Divider(
                          height: 50,
                        ),
                        CheckOutProducts(
                          cartProducts: checkoutInfoSnapshot.data?.cart,
                        ),
                        Divider(
                          height: 45,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // ValueListenableBuilder<CouponData?>(
                        //     valueListenable: checkoutInfoManager.couponNotifier,
                        //     builder: (context, value, _) {
                        //       return StatisticsWidget(
                        //         subTotal:
                        //             '${checkoutInfoSnapshot.data?.subtotal} ${checkoutInfoSnapshot.data?.currency}',
                        //         delivery:
                        //             '${checkoutInfoSnapshot.data?.delivery} ${checkoutInfoSnapshot.data?.currency}',
                        //         discount:
                        //             '${ checkoutInfoSnapshot.data?.discount} ${checkoutInfoSnapshot.data?.currency}',
                        //         total:
                        //             '${checkoutInfoSnapshot.data?.total } ${checkoutInfoSnapshot.data?.currency}',
                        //       );
                        //     })

                        StatisticsWidget(
                          subTotal:
                              '${checkoutInfoSnapshot.data?.subtotal} ${checkoutInfoSnapshot.data?.currency}',
                          delivery:
                              '${checkoutInfoSnapshot.data?.delivery} ${checkoutInfoSnapshot.data?.currency}',
                          discount:
                              '${checkoutInfoSnapshot.data?.discount} ${checkoutInfoSnapshot.data?.currency}',
                          total:
                              '${checkoutInfoSnapshot.data?.total} ${checkoutInfoSnapshot.data?.currency}',
                        )
                      ],
                    ),
                  ),
                  StreamBuilder<ManagerState>(
                      initialData: ManagerState.IDLE,
                      stream: couponManager.state$,
                      builder:
                          (context, AsyncSnapshot<ManagerState> stateSnapshot) {
                        return FormsStateHandling(
                          managerState: stateSnapshot.data,
                          errorMsg: couponManager.errorDescription,
                          onClickCloseErrorBtn: () {
                            couponManager.inState.add(ManagerState.IDLE);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: StreamBuilder<ManagerState>(
                                initialData: ManagerState.IDLE,
                                stream: paymentManager.state$,
                                builder: (context,
                                    AsyncSnapshot<ManagerState> stateSnapshot) {
                                  return FormsStateHandling(
                                    managerState: stateSnapshot.data,
                                    errorMsg: paymentManager.errorDescription,
                                    onClickCloseErrorBtn: () {
                                      paymentManager.inState
                                          .add(ManagerState.IDLE);
                                      paymentManager.managerState =
                                          ManagerState.IDLE;
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  );
                                }),
                          ),
                        );
                      })
                ],
              );
            }),
      ),
    );
  }
}
