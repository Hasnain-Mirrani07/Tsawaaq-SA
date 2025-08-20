import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/cart/cart_actions/cart_actions_response.dart';
import 'package:tasawaaq/shared/convert_to_flutter_hex/convert_to_flutter_hex.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';

class CheckOutItemWidget extends StatelessWidget {
  final String? imgUrl;
  final String? name;
  final String? color;
  final String? size;
  final String? price;

  const CheckOutItemWidget({
    Key? key,
    this.imgUrl,
    this.color,
    this.size,
    this.name,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: NetworkAppImage(
                    width: 80.h,
                    height: 80.h,
                    imageUrl: "$imgUrl",
                  ),
                ),
                SizedBox(
                  width: 25,
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
                      if(color != null) if(color != "") if(color != null)   Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${context.translate(AppStrings.Color)} :   ",
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
                              // child: Text("$color"),
                              decoration: BoxDecoration(
                                  color: Color(preparedColor("${color!}"))
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          if(size != null) if(size != "")  Expanded(
                            child: Text(
                              "${context.translate(AppStrings.Size)} : $size",
                              style: AppFontStyle.greyTextH4,
                              maxLines: 1,
                            ),
                          ),
                          if(size != null) if(size != "") SizedBox(
                            width: 15,
                          ),
                          Text(
                            "$price",
                            style: AppFontStyle.greyTextH4,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
