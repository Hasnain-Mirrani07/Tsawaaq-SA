import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/product_details/product_details_manager.dart';
import 'package:tasawaaq/shared/custom_button/custom_button.dart';

class ProductDetailsBottomButton extends StatelessWidget {
  final String? price;
  final String discountPrice;
  final String? currency;
  final VoidCallback? onClickBtn;

  const ProductDetailsBottomButton(
      {Key? key, this.price, this.discountPrice = '', this.onClickBtn,this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: StreamBuilder<PricePbj>(
              initialData: PricePbj(originalPrice:price ,price: discountPrice),
              stream: context.use<ProductDetailsManager>().priceSubject.stream,
              builder: (context, priceSnapshot) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (priceSnapshot.data!.price != null)
                      Text(
                        "${priceSnapshot.data!.price} ",
                        style: AppFontStyle.greyTextH2,
                      ),
                    if (priceSnapshot.data!.originalPrice.isNotEmpty) if( priceSnapshot.data!.originalPrice != priceSnapshot.data!.price)
                      Text(
                        "${priceSnapshot.data!.originalPrice} ",
                        style: AppFontStyle.lightGreyTextThrowLineH4,
                      ),
                  ],
                );
              }
            ),
          ),
          CustomButton(
            onClickBtn: onClickBtn,
            btnWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  '${AppAssets.BAG_ICON}',
                  color: AppStyle.blueTextButton,
                  height: 18,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  '${context.translate(AppStrings.ADD_TO_CART)}',
                  style: AppFontStyle.blueTextH4,
                ),
              ],
            ),
            btnWidth: 175,
            btnColor: AppStyle.yellowButton,
          )
        ],
      ),
    );
  }
}
