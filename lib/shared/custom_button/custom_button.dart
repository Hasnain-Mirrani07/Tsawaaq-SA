import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_style/app_style.dart';

class CustomButton extends StatelessWidget {
  final String? txt;
  final Color? btnColor;
  final Widget? btnWidget;
  final double? btnWidth;
  final VoidCallback? onClickBtn;

  CustomButton(
      {this.txt,
      this.onClickBtn,
      this.btnWidget,
      this.btnColor = AppStyle.yellowButton,
      this.btnWidth = double.infinity});

  @override
  Widget build(BuildContext context) {
    final prefs = context.use<PrefsService>();

    return InkWell(
      onTap: onClickBtn,
      child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            width: btnWidth,
            decoration: BoxDecoration(
              color: btnColor,
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.all(5.0),
            padding: EdgeInsets.symmetric(
                horizontal: prefs.appLanguage == 'en' ? 25 : 5, vertical: 15),
            child: txt != null
                ? Text(
                    "$txt",
                    style: AppFontStyle.blueTextH2,
                    textAlign: TextAlign.center,
                  )
                : btnWidget,
          )),
    );
  }
}
