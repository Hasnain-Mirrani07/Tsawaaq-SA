import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/product_details/product_details_manager.dart';
import 'package:tasawaaq/features/product_details/product_details_response.dart';

class ProductDetailsSize extends StatelessWidget {
  final List<Sizes>? productSizes;
  final String? currency;
  const ProductDetailsSize({Key? key, this.productSizes,this.currency}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productDetailsManager = context.use<ProductDetailsManager>();

    return productSizes!.isNotEmpty
        ? Container(
            child: ValueListenableBuilder<Sizes?>(
                valueListenable: productDetailsManager.sizeNotifier,
                builder: (context, sizeSubjectValue, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${context.translate(AppStrings.Size)}',
                            style: AppFontStyle.greyTextH3,
                          ),
                          Text(
                            productDetailsManager.sizeNotifier.value != null
                                ? "${productDetailsManager.sizeNotifier.value?.name}"
                                : '${context.translate(AppStrings.Size)}',
                            style: AppFontStyle.yellowTextH3,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        children: productSizes!
                            .map((e) => InkWell(
                                  onTap: () {
                                    if(e.quantity! > 1){
                                      productDetailsManager.sizeNotifier.value = e;
                                      context.use<ProductDetailsManager>().priceSubject.sink.add(PricePbj(price: "${e.price} $currency",originalPrice:"${e.originalPrice} $currency"));
                                      print("this is size");
                                    }else{
                                      context.use<ToastTemplate>().show("${locator<PrefsService>().appLanguage == 'en' ? "sorry.. this size is out of stock":"عفوا.. هذا المقاس غير متاح"}");
                                    }
                                    context.use<ProductDetailsManager>().maxForSizeSubject.sink.add(e.quantity!);
                                    productDetailsManager.quantityNotifier.value =1;

                                  },
                                  child: Container(
                                    height: 45,
                                    width: 85,
                                    margin: EdgeInsets.all(5),
                                    // padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: e.id ==
                                                  productDetailsManager
                                                      .sizeNotifier.value?.id
                                              ? AppStyle.blueTextButton
                                              : AppStyle.introGrey),
                                      color: e.id ==
                                              productDetailsManager
                                                  .sizeNotifier.value?.id
                                          ? AppStyle.blueTextButton
                                          : AppStyle.greyWhite,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        // "${productDetailsManager.maxForSizeSubject.value}",
                                        "${e.name}",
                                        style: TextStyle(
                                          color: e.id ==
                                                  productDetailsManager
                                                      .sizeNotifier.value?.id
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      Divider(
                        height: 45,
                      )
                    ],
                  );
                }),
          )
        : Container();
  }
}
