import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';

class ProductDetailsOverview extends StatelessWidget {
  final String desc;
  ProductDetailsOverview({Key? key, this.desc = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${context.translate(AppStrings.OverView)}',
              style: AppFontStyle.greyTextH3,
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Html(
         data:  '$desc',
          // style: AppFontStyle.greyTextH4,
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
