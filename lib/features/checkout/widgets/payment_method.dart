import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/features/checkout/managers/checkout_info_manager.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checkOutManager = context.use<CheckoutInfoManager>();
    final prefs = locator<PrefsService>();

    /// cash , knet , credit
    List<PaymentMethod> paymentMethods = [
      PaymentMethod(
          id: 0,
          title: '${context.translate(AppStrings.knet)}',
          // title: "knet",
          activeIcon: AppAssets.knet1,
          disableIcon: AppAssets.knet0),
      PaymentMethod(
          id: 1,
          title: '${context.translate(AppStrings.credit_card)}',
          // title: "credit",
          activeIcon: AppAssets.credit1,
          disableIcon: AppAssets.credit0),
      PaymentMethod(
          id: 2,
          // title: "cash",
          title: '${context.translate(AppStrings.cash)}',
          activeIcon: AppAssets.cash1,
          disableIcon: AppAssets.cash0),
    ];

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${context.translate(AppStrings.PAYMENT_METHOD)}',
            style: AppFontStyle.blueTextH3,
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 90,
            child: StreamBuilder<PaymentMethod>(
                initialData: PaymentMethod(),
                stream: checkOutManager.paymentMethod$,
                builder: (context, value) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: paymentMethods.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Tooltip(
                          preferBelow: false,
                          message: "${paymentMethods[index].title}",
                          key: Key("${paymentMethods[index].id}"),
                          child: InkWell(
                            onTap: () {
                              checkOutManager.inPaymentMethod =
                                  paymentMethods[index];
                              print(paymentMethods[index].title);
                            },
                            child: Column(
                              children: [
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                Expanded(
                                  child: Container(
                                    width: 90,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SvgPicture.asset(
                                      value.data!.id == paymentMethods[index].id
                                          ? '${paymentMethods[index].activeIcon}'
                                          : '${paymentMethods[index].disableIcon}',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Text("${paymentMethods[index].title}",style: TextStyle(height: 1,fontSize: 12),),

                              ],
                            ),
                          ),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}



class PaymentMethod {
  int? id;
  String? title;
  String? activeIcon;
  String? disableIcon;

  PaymentMethod({
    this.id,
    this.title,
    this.activeIcon,
    this.disableIcon,
  });
}
