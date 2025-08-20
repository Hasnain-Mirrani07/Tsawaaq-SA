import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/shared/curved_container/curved_container.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';

class FavoriteItem extends StatelessWidget {
  final String? imgUrl, name, desc;
  final VoidCallback? onClickFav;
  final bool isFavIcon;

  const FavoriteItem(
      {Key? key,
      this.desc,
      this.name,
      this.imgUrl,
      this.onClickFav,
      this.isFavIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CurvedContainer(
        borderRadius: 15,
        widget: Container(
          padding: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * .8,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: NetworkAppImage(
                  boxFit: BoxFit.fill,
                  height: double.infinity,
                  width: 70,
                  imageUrl: '$imgUrl',
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "$name",
                          style: AppFontStyle.blueTextH3,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "$desc",
                          style: AppFontStyle.greyTextH4,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  isFavIcon == true
                      ? Container(
                          child: IconButton(
                            onPressed: onClickFav,
                            icon: Icon(
                              // isFavorite ?? false ?
                              Icons.favorite,
                              // : Icons.favorite_border,
                              color: AppStyle.yellowButton,
                            ),
                          ),
                        )
                      : Container()
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
