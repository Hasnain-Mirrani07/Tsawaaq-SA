import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawaaq/app_style/app_style.dart';

abstract class AppFontStyle {
  static TextStyle blueTextH2 = TextStyle(
      color: AppStyle.blueTextButton,
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      height: 1.3);
  static TextStyle whiteTextH2 = TextStyle(
      color: Colors.white,
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      height: 1.3);

  static TextStyle blueTextH3 =
      TextStyle(color: AppStyle.blueTextButton, fontSize: 18.sp, height: 1.3);

  static TextStyle blueTextH4 =
      TextStyle(color: AppStyle.blueTextButton, fontSize: 14.sp, height: 1.3);

  static TextStyle greyTextH4 =
      TextStyle(color: AppStyle.topDarkGrey, fontSize: 14.sp, height: 1.3);

  static TextStyle greyTextH3 =
      TextStyle(color: AppStyle.topDarkGrey, fontSize: 16.sp, height: 1.3);

  static TextStyle greyTextH2 =
      TextStyle(color: AppStyle.topDarkGrey, fontSize: 18.sp, height: 1.3);

  static TextStyle greyTextH1 =
      TextStyle(color: AppStyle.topDarkGrey, fontSize: 21.sp, height: 1.3);

  static TextStyle lightGreyTextThrowLineH4 =
      TextStyle(color: AppStyle.introGrey, fontSize: 14.sp, height: 1.3,decoration: TextDecoration.lineThrough);

  static TextStyle whiteTextBigHeader =
      TextStyle(color: Colors.white, fontSize: 32.sp, height: 1.3);

  static TextStyle whiteTextH1 =
      TextStyle(color: Colors.white, fontSize: 26.sp, height: 1.3);

  static TextStyle whiteTextH3 =
      TextStyle(color: Colors.white, fontSize: 16.sp, height: 1.3);
  static TextStyle whiteTextH4 =
      TextStyle(color: Colors.white, fontSize: 14.sp, height: 1.3);

  static TextStyle whiteTextH5 =
      TextStyle(color: Colors.white, fontSize: 12.sp, height: 1.3);

  static TextStyle yellowTextH4 = TextStyle(
    fontSize: 14.sp,
    height: 1.3,
    color: AppStyle.yellowButton,
  );

  static TextStyle yellowTextH3 = TextStyle(
    fontSize: 16.sp,
    height: 1.3,
    color: AppStyle.yellowButton,
  );

  ////////////////// below are old

  static TextStyle bigHeaderText = TextStyle(
      color: Colors.black,
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      height: 1.3);

  static TextStyle bigHeaderTextGreen = TextStyle(
      color: AppStyle.lightGreen,
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      height: 1.3);

  static TextStyle hugeHeaderText = TextStyle(
      color: Colors.black,
      fontSize: 26.sp,
      fontWeight: FontWeight.w600,
      height: 1.3);

  static TextStyle bigHeaderTextMedium = TextStyle(
      color: Colors.black,
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      height: 1.3);

  static TextStyle bigHeaderTextUnderLine = TextStyle(
      color: Colors.black,
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.underline,
      height: 1.3);

  static TextStyle bigHeaderTextWhite = TextStyle(
      color: Colors.white,
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      height: 1.3);

  static TextStyle smallDescText = TextStyle(
      color: Colors.black,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      height: 1.3);

  static TextStyle smallDescTextLightGreenUnderLine = TextStyle(
      color: AppStyle.lightGreen,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.underline,
      height: 1.3);

  static TextStyle sideTitleText = TextStyle(
      color: AppStyle.sideTitle,
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
      height: 1.3);

  static TextStyle sideMediumGreenTitleText = TextStyle(
      color: AppStyle.lightGreen,
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
      height: 1.3);

  static TextStyle medRegularFont = TextStyle(fontSize: 16.sp, height: 1.3);

  static TextStyle sideMediumTitleText =
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, height: 1.3);

  static TextStyle smallDescTextUnderLine = TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.underline,
      height: 1.3);

  static TextStyle sideMenuTitleTextRegular = TextStyle(
      color: Colors.black,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      height: 1.3);

  static TextStyle sideMenuTitleTextBoldGreen = TextStyle(
      color: AppStyle.lightGreen,
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      height: 1.3);

  static TextStyle sideMenuTitleTextBold = TextStyle(
      color: Colors.black,
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      height: 1.3);

  static TextStyle sideMenuTitleTextBoldRed = TextStyle(
      color: AppStyle.lightRed,
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      height: 1.3);

  static TextStyle greyMedTitleBold = TextStyle(
      color: AppStyle.sideTitle,
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      height: 1.3);

  static TextStyle greySmallTitleBold =
      TextStyle(color: AppStyle.sideTitle, fontSize: 14.sp, height: 1.3);
}
