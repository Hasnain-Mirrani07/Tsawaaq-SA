import 'package:flutter/material.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_style/app_style.dart';




class TabItem extends StatelessWidget {
  final bool? isSelected;
  final String? title;

  TabItem({this.isSelected,this.title});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title',style: isSelected == true ? AppFontStyle.blueTextH3 : AppFontStyle.greyTextH2,),
          SizedBox(
            height: 6,
          ),
          Container(
            width: 70,
            height: 1,
            color: isSelected == true ? AppStyle.yellowButton : Colors.transparent,
          )
        ],
      ),
    );
  }
}