import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/shared/form/form_container.dart';

class PaymentContainerDetails extends StatelessWidget {
  final bool? isSuccess;
  final String? itemCount, total, orderId;
  const PaymentContainerDetails(
      {Key? key, this.isSuccess, this.total, this.itemCount, this.orderId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = context.use<PrefsService>();

    return Container(
      child: TasawaaqFormContainer(
        confirmBtnTxt: isSuccess == true
            ? prefs.userObj != null
                ? "${context.translate(AppStrings.MY_ORDERS)}"
                : "${context.translate(AppStrings.HOME)}"
            : "${context.translate(AppStrings.TRY_AGAIN)}",
        onClickConfirmBtn: () {
          if (isSuccess ?? false) {
            if (prefs.userObj != null) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRouts.MyOrdersPage,
                  ModalRoute.withName(AppRouts.TABS_WIDGET));
            } else {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRouts.TABS_WIDGET, (Route<dynamic> route) => false);
            }
          } else {
            // Navigator.of(context).pop();
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouts.CartPage,
                ModalRoute.withName(AppRouts.TABS_WIDGET));
          }
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: isSuccess == true ? 25 : 50,
              ),

              Text(isSuccess == true
                  ? "${context.translate(AppStrings.Thank_you_for_your_Order)}"
                  : "${context.translate(AppStrings.PLEASE_TRY_AGAIN)}"),
              // Text("$msg"),
              isSuccess == true
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "${context.translate(AppStrings.Order_Id_str)}"),
                              Row(
                                children: [
                                  Text(
                                    "#",
                                    style: AppFontStyle.blueTextH4,
                                  ),
                                  Text(
                                    "$orderId",
                                    style: AppFontStyle.blueTextH4,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${context.translate(AppStrings.ITEMS)}"),
                              Text(
                                "$itemCount",
                                style: AppFontStyle.blueTextH4,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${context.translate(AppStrings.TOTAL)}"),
                              Text(
                                "$total",
                                style: AppFontStyle.blueTextH4,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    )
                  : Container(
                      height: 50,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
