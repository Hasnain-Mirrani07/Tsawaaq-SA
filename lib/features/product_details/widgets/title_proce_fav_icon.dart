import 'package:flutter/material.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/shared/title_desc_btn/title_desc_btn.dart';

class TitlePriceFavIcon extends StatelessWidget {
  final String? name;
  final String? price;
  final VoidCallback? onFavoriteClickBtn;
  final bool isFavorite;

  const TitlePriceFavIcon(
      {Key? key,
      this.name,
      this.price,
      this.onFavoriteClickBtn,
      required this.isFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleDescBtn(
      title: "$name",
      desc: "$price",
      isFilter: false,
      rowCrossAxisAlignment: CrossAxisAlignment.start,
      icon: InkWell(
        onTap: onFavoriteClickBtn,
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? AppStyle.yellowButton : Colors.grey,
        ),
      ),
    );
  }
}
