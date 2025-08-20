import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/home/home_page.dart';
import 'package:tasawaaq/features/product_details/product_details_manager.dart';
import 'package:tasawaaq/features/product_details/widgets/product_details_size.dart';
import 'package:tasawaaq/shared/convert_to_flutter_hex/convert_to_flutter_hex.dart';

import '../product_details_response.dart';

class ProductDetailsColor extends StatelessWidget {
  final List<Options>? productColors;
  final String? price,originalPrice,currency;
  final int? stock;
  const ProductDetailsColor({Key? key, this.productColors,this.originalPrice,this.price,this.currency,this.stock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productDetailsManager = context.use<ProductDetailsManager>();

    return productColors!.isNotEmpty
        ? Container(
            child: ValueListenableBuilder<Options?>(
                valueListenable: productDetailsManager.colorNotifier,
                builder: (context, colorSubjectValue, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${context.translate(AppStrings.Color)}',
                            style: AppFontStyle.greyTextH3,
                          ),
                          Text(
                            productDetailsManager.colorNotifier.value != null
                                ? "${productDetailsManager.colorNotifier.value?.name}"
                                : '${context.translate(AppStrings.Color)}',
                            style: AppFontStyle.yellowTextH3,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        children: productColors!
                            .map((e) => InkWell(
                                  onTap: () {
                                    productDetailsManager.colorNotifier.value = e;
                                    productDetailsManager.sizeNotifier.value = null;
                                    context.use<ProductDetailsManager>().priceSubject.sink.add(PricePbj(price: "$price $currency",originalPrice:"$originalPrice $currency" ));
                                    context.use<ProductDetailsManager>().maxForSizeSubject.sink.add(stock!);
                                    productDetailsManager.quantityNotifier.value = 1;
                                    print("this is color");


                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: e.id ==
                                              productDetailsManager
                                                  .colorNotifier.value?.id
                                          ? AppStyle.blueTextButton
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        color: Color(preparedColor(e.hexa!)),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      Divider(
                        height: 45,
                      ),
                      if (productDetailsManager.colorNotifier.value != null)
                        ProductDetailsSize(
                          currency: currency,
                          productSizes:
                              productDetailsManager.colorNotifier.value?.sizes,
                        ),
                    ],
                  );
                }),
          )
        : Container();
  }
}

