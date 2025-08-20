import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_style/app_style.dart';


class TitleDescBtn extends StatelessWidget {
  final String? title,desc;
  final VoidCallback? onFilterClickBtn;
  final double paddingBetween;
  final CrossAxisAlignment rowCrossAxisAlignment;
  Widget? icon;
  final bool isFilter;

   TitleDescBtn({
    Key? key,
    this.title,
    this.desc,
    this.isFilter = true,
    this.onFilterClickBtn,
     this.rowCrossAxisAlignment = CrossAxisAlignment.center,
    this.paddingBetween = 2,
    this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(isFilter == true){
      icon = null;
    }
    return Container(
     child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: rowCrossAxisAlignment,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(title != null)   Text("$title",style: AppFontStyle.blueTextH2,),
                if(desc != null)  SizedBox(
                  height: paddingBetween,
                ),
                if(desc != null)  Text("$desc",style: AppFontStyle.greyTextH4,),
              ],
            ),
          ),
          if(icon != null) InkWell(
            onTap: onFilterClickBtn,
              child: icon,
              //
          ),
          if(isFilter != false)
            InkWell(
              onTap: onFilterClickBtn,
              child: Container(
                // color: Colors.red,
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  '${AppAssets.FILTER_SVG}',
                  color: AppStyle.yellowButton,
                ),
              ),
            )

        ],
      )
    );
  }
}
