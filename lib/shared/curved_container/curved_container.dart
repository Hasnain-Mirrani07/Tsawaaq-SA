import 'package:flutter/material.dart';
import 'package:tasawaaq/app_style/app_style.dart';

class CurvedContainer extends StatelessWidget {
  final Widget? widget;
  final double borderRadius;
  final double padding;
  final Color containerColor;
  final Color borderColor;



  CurvedContainer({
    this.widget,
    this.padding = 5.0,
    this.borderRadius = 5.0,
    this.borderColor = AppStyle.lightGrey,
    this.containerColor = AppStyle.topLightGrey

  });



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        color: containerColor,
        borderRadius: BorderRadius.circular(borderRadius),),
      child: widget,
    );
  }
}
