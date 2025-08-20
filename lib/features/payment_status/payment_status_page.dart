import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/checkout/managers/payment_manager.dart';
import 'package:tasawaaq/features/payment_status/widgets/payment_container_details.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/forms_header/forms_header.dart';

class PaymentStatusPageArgs {
  final bool? isSuccess;
  final String? itemCount, orderId, total;

  PaymentStatusPageArgs({
    this.isSuccess,
    this.total,
    this.itemCount,
    this.orderId,
  });
}

class PaymentStatusPage extends StatelessWidget {
  const PaymentStatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaymentStatusPageArgs args =
        ModalRoute.of(context)!.settings.arguments as PaymentStatusPageArgs;
    return WillPopScope(
      onWillPop: () async {
        locator<PaymentManager>().inState.add(ManagerState.IDLE);
        locator<PaymentManager>().managerState = ManagerState.IDLE;
        return true;
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(20.0), //
            child: MainAppBar(
              hasRoundedEdge: false,
              hasLeading: false,
              hasDrawer: false,
              hasCart: false,
              hasInfo: false,
              elevation: 0.0,
              onBackClicked: () {
                locator<PaymentManager>().inState.add(ManagerState.IDLE);
                locator<PaymentManager>().managerState = ManagerState.IDLE;
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Container(
            child: Stack(
              children: [
                BounceInDown(
                  child: FormsHeader(
                    hasSkipBtn: false,
                    title: args.isSuccess == true
                        ? "${context.translate(AppStrings.ORDER_SUCCESSFULLY)}"
                        : "${context.translate(AppStrings.ERROR)}",
                    firstDesc: args.isSuccess == true
                        ? "${context.translate(AppStrings.ORDER_SUBMITTED)}"
                        : "${context.translate(AppStrings.ORDER_NOT_SUBMITTED)}",
                    bottomCenterIconPadding: 30,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    upperCenterIconPadding: 75,
                    centerIcon: Container(
                      child: args.isSuccess == true
                          ? BounceInDown(
                              child: Dance(
                                child: SvgPicture.asset(
                                  '${AppAssets.correct}',
                                  color: Colors.white,
                                  // matchTextDirection: true,
                                  height: 75.h,
                                ),
                              ),
                            )
                          : SlideInDown(
                              child: SvgPicture.asset(
                                '${AppAssets.error}',
                                color: Colors.white,
                                // matchTextDirection: true,
                                height: 75.h,
                              ),
                            ),
                    ),
                  ),
                ),
                ListView(
                  children: [
                    SizedBox(
                      height: 270,
                    ),
                    SlideInLeft(
                      child: PaymentContainerDetails(
                        isSuccess: args.isSuccess,
                        itemCount: "${args.itemCount}",
                        orderId: "${args.orderId}",
                        total: "${args.total}",
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 25,
                  left: 10,
                  right: 10,
                  child: FadeInUp(
                    child: Column(
                      children: [
                        Container(
                          width: 150,
                          child: Image.asset(
                            AppAssets.APP_BAR_LOGO,
                            // color: AppStyle.blueTextButton,
                          ),
                        ),
                        // Text(
                        //   locator<PrefsService>().appLanguage == 'en' ? 'ALWAYS IN STYLE !':'! ALWAYS IN STYLE',
                        //   style: TextStyle(
                        //     fontSize: 8,
                        //     color: AppStyle.yellowButton,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
