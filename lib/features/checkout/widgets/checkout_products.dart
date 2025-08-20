import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/features/checkout/responses/checkout_info_response.dart';
import 'package:tasawaaq/features/checkout/widgets/checkout_item_widget.dart';
import 'package:tasawaaq/shared/convert_to_flutter_hex/convert_to_flutter_hex.dart';

class CheckOutProducts extends StatelessWidget {
  final List<CheckoutInfoCartProduct>? cartProducts;
  const CheckOutProducts({Key? key, this.cartProducts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${context.translate(AppStrings.YOUR_ORDER_SUMMARY)}',
            style: AppFontStyle.blueTextH3,
          ),
          SizedBox(
            height: 15,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: cartProducts?.length ?? 0,
            itemBuilder: (_, index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 7),
                child: CheckOutItemWidget(
                  price:
                      '${cartProducts?[index].totalPrice} ${cartProducts?[index].product?.currency}',
                  imgUrl: cartProducts?[index].product?.image,
                  size: cartProducts?[index].size?.name,
                  name: cartProducts?[index].product?.name,
                  color: cartProducts![index].color!.hexa != null ? "${cartProducts![index].color!.hexa!}":null,
                  // color: cartProducts?[index].color?.name,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

