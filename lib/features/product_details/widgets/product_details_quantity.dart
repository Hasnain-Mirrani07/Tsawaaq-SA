import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/product_details/product_details_manager.dart';
import 'package:tasawaaq/shared/curved_container/curved_container.dart';

class ProductDetailsQuantity extends StatelessWidget {
  final int maxQuantity;
  ProductDetailsQuantity({Key? key, required this.maxQuantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productDetailsManager = context.use<ProductDetailsManager>();
    final toastTemplate = context.use<ToastTemplate>();
    final prefs = context.use<PrefsService>();

    return Container(
      child: ValueListenableBuilder<int>(
          valueListenable: productDetailsManager.quantityNotifier,
          builder: (context, quantitySubjectValue, _) {
            return StreamBuilder<int>(
              initialData: maxQuantity,
              stream: productDetailsManager.maxForSizeSubject.stream,
              builder: (context, maxForSizeSnapshot) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${context.translate(AppStrings.Quantity)}',
                          style: AppFontStyle.greyTextH3,
                        ),
                        maxForSizeSnapshot.data! > 1 ? Text(
                          '${context.translate(AppStrings.In_Stock)}',
                          style: AppFontStyle.greyTextH3,
                        ):Text(
                          '${context.translate(AppStrings.out_of_stock)}',
                          style: AppFontStyle.greyTextH3.merge(TextStyle(
                            color: Colors.redAccent
                          )),
                        ),
                      ],
                    ),
                    if(maxForSizeSnapshot.data! > 1 )   SizedBox(
                      height: 25,
                    ),
         if(maxForSizeSnapshot.data! > 1 ) CurvedContainer(
                      borderRadius: 8,
                      borderColor: AppStyle.introGrey,
                      padding: 10,
                      containerColor: AppStyle.greyWhite,
                      widget: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (productDetailsManager.quantityNotifier.value >
                                  1) {
                                productDetailsManager.quantityNotifier.value =
                                    productDetailsManager.quantityNotifier.value -
                                        1;
                              }
                            },
                            child: Icon(
                              Icons.remove,
                              color: quantitySubjectValue == 1
                                  ? Color(0xffD8D8D8)
                                  : Color(0xff000000),
                              size: 18.w,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "$quantitySubjectValue",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (productDetailsManager.quantityNotifier.value <
                                  int.parse("${maxForSizeSnapshot.data!}")) {
                                productDetailsManager.quantityNotifier.value =
                                    productDetailsManager.quantityNotifier.value +
                                        1;
                              } else {
                                toastTemplate.show(prefs.appLanguage == 'en'
                                    ? "sorry!  reached the maximum quantity"
                                    : "عذرا! وصلت إلى الكمية القصوى");
                              }
                            },
                            child: Icon(
                              Icons.add,
                              color: Color(0xff4C5059),
                              size: 18.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 45,
                    )
                  ],
                );
              }
            );
          }),
    );
  }
}
