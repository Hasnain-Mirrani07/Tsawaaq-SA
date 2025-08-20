import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';

class ProductItem extends StatelessWidget {
  final String? keyId;
  final double? itemWidth;
  final double? itemElevation;
  final double itemBorderRadius;
  final String? imgUrl;
  final String? name;
  final String? dsc;
  final String? storeName;
  final String? price;
  final double? imageHeight;
  final double? imageWidth;
  final bool? isFavorite;
  final VoidCallback? onClickFavoriteBtn;

  ProductItem(
      {this.itemWidth,
        this.keyId,
      this.itemElevation = 5.0,
      this.itemBorderRadius = 15.0,
      this.imgUrl,
      this.imageWidth = double.infinity,
      this.name,
      this.storeName,
      this.imageHeight,
      this.dsc,
      this.price,
      this.isFavorite,
      this.onClickFavoriteBtn});

  @override
  Widget build(BuildContext context) {
    final prefs = context.use<PrefsService>();
    return Container(
      key: Key("$keyId"),
      width: itemWidth,
      child: Card(
        elevation: itemElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(itemBorderRadius),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(itemBorderRadius),
                        child: NetworkAppImage(
                          boxFit: BoxFit.fill,
                          imageUrl: "$imgUrl",
                          height: imageHeight,
                          width: imageWidth,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "$name",
                    style: AppFontStyle.blueTextH3,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "$dsc",
                    style: AppFontStyle.greyTextH4,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 10,
                  ),
               if(storeName != null) if(storeName != "")  Text(
                    "$storeName",
                    style: AppFontStyle.blueTextH4,
                    maxLines: 11,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "$price",
                          style: AppFontStyle.greyTextH4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 45,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                right: prefs.appLanguage == "en" ? 0 : null,
                left: prefs.appLanguage == "en" ? null : 0,
                child: InkWell(
                  onTap: onClickFavoriteBtn,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppStyle.yellowButton,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                            prefs.appLanguage == "en" ? itemBorderRadius : 0.0),
                        bottomRight: Radius.circular(
                            prefs.appLanguage == "en" ? itemBorderRadius : 0.0),
                        bottomLeft: Radius.circular(
                            prefs.appLanguage == "en" ? 0.0 : itemBorderRadius),
                        topRight: Radius.circular(
                            prefs.appLanguage == "en" ? 0.0 : itemBorderRadius),
                      ),
                    ),
                    height: 45,
                    width: 45,
                    child: Icon(
                      isFavorite ?? false
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
