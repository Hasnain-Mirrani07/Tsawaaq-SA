import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/cart/cart_actions/cart_actions_response.dart';
import 'package:tasawaaq/features/cart/widgets/counter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawaaq/features/cart/widgets/remove_add_Fav_widget.dart';
import 'package:tasawaaq/shared/convert_to_flutter_hex/convert_to_flutter_hex.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';

class CartItemWidget extends StatelessWidget {
  final String? imgUrl;
  final String? name;
  final ProductColor? color;
  final String? size;
  final int? count;
  final bool? isFav;
  final String? price;
  final VoidCallback? onClickCIncrement,
      onClickDecrement,
      onClickFav,
      onClickRemove;

  const CartItemWidget(
      {Key? key,
      this.imgUrl,
      this.color,
      this.size,
      this.name,
      this.count,
      this.isFav,
      this.price,
      this.onClickCIncrement,
      this.onClickDecrement,
      this.onClickFav,
      this.onClickRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppStyle.topLightGrey),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 15, top: 15, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: NetworkAppImage(
                    boxFit: BoxFit.fill,
                    width: 130.h,
                    height: 130.h,
                    imageUrl: "$imgUrl",
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$name",
                        style: AppFontStyle.blueTextH2.merge(
                          TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                   if(color != null) if(color != "") if(color!.hexa != null) Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Text(
                            "${context.translate(AppStrings.Color)} : ",
                            style: AppFontStyle.greyTextH4,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                       Card(
                         elevation: 3,
                         color: Colors.transparent,
                         child: Container(
                           height: 18,
                           width: 18,
                           decoration: BoxDecoration(
                               color: Color(preparedColor(color!.hexa!))
                           ),
                         ),
                       ),
                     ],
                   ),

                       if(color!.hexa == null)
                        SizedBox(
                          height: 15,
                        ),

                      SizedBox(
                        height: 5,
                      ),
                      if(size != null) if(size != "")  Text(
                        "${context.translate(AppStrings.Size)} : $size",
                        style: AppFontStyle.greyTextH4,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if(size == null)  SizedBox(
                        height: 1,
                      ),


                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "$price",
                        style: AppFontStyle.greyTextH4,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CounterWidget(
                        count: count,
                        onClickCIncrement: onClickCIncrement,
                        onClickDecrement: onClickDecrement,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 25,
          ),
          RemoveAddFavBottomWidget(
            isFav: isFav,
            onClickFav: onClickFav,
            onClickRemove: onClickRemove,
          )
        ],
      ),
    );
  }
}
