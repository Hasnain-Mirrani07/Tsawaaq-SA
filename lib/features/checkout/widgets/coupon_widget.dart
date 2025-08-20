import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/checkout/promo_code/CouponRequest.dart';
import 'package:tasawaaq/features/checkout/promo_code/coupon_manager.dart';
import 'package:tasawaaq/shared/custom_text_field/custom_text_field.dart';

class CouponWidget extends StatefulWidget {
  @override
  _CouponWidgetState createState() => _CouponWidgetState();
}

class _CouponWidgetState extends State<CouponWidget> {
  String _promo = "";

  @override
  Widget build(BuildContext context) {
    final couponManager = context.use<CouponManager>();
    final prefs = context.use<PrefsService>();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${context.translate(AppStrings.PROMO_CODE)}',
            style: AppFontStyle.blueTextH3,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${AppLocalizations.of(context)!.translate(AppStrings.HAVE_PROMO)}',
            style: AppFontStyle.greyTextH4,
          ),
          SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: prefs.appLanguage == 'en' ? 100 : 0,
                  left: prefs.appLanguage == 'en' ? 0 : 100,
                ),
                child: CustomTextFiled(
                  obscureText: false,
                  maxLines: 1,
                  onFieldSubmitted: (v) {},
                  // labelText: "block_rq_str",
                  hintText:
                      '${AppLocalizations.of(context)!.translate(AppStrings.Enter_Promo_Here)}',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "${AppLocalizations.of(context)!.translate('*required_str')}";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _promo = value;
                    } else {
                      _promo = '';
                    }
                  },
                  // keyboardType: TextInputType.emailAddress,
                ),
              ),
              Positioned(
                  left: prefs.appLanguage == 'en' ? 100 : 0,
                  right: prefs.appLanguage == 'en' ? 0 : 100,
                  top: 0,
                  bottom: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          if (_promo.isEmpty) {
                            context.use<ToastTemplate>().show(
                                '${context.translate(AppStrings.ENTER_PROMO_CODE)}');
                            return;
                          }

                          couponManager.coupon(
                              request: CouponRequest(code: _promo));
                        },
                        child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                            color: AppStyle.yellowButton,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(
                                  prefs.appLanguage == 'en' ? 15.0 : 0),
                              bottomRight: Radius.circular(
                                  prefs.appLanguage == 'en' ? 15.0 : 0),
                              bottomLeft: Radius.circular(
                                  prefs.appLanguage == 'en' ? 0 : 15.0),
                              topLeft: Radius.circular(
                                  prefs.appLanguage == 'en' ? 0 : 15.0),
                            ),
                          ),
                          child: Center(
                              child: Text(
                            '${context.translate(AppStrings.APPLY)}',
                            style: TextStyle(
                                color: AppStyle.blueTextButton,
                                fontSize: 18,
                                height: 1.3),
                          )),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
          StreamBuilder<PromoObject>(
            // initialData: "cccccccccc",
            stream: locator<CouponManager>().promoCodeMsg.stream,
            builder: (context, promoCodeMsgSnapshot) {
              return promoCodeMsgSnapshot.hasData ? Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text("${promoCodeMsgSnapshot.data!.title}",
                  style: TextStyle(color: promoCodeMsgSnapshot.data!.title == locator<CouponManager>().inValidPromoCodeMsg? Colors.redAccent:Colors.green),),
                ),
              ):Container();
            }
          ),
        ],
      ),
    );
  }
}
