import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_core/localizations/app_localizations.dart';
import 'package:tasawaaq/app_core/services/prefs_service.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/shared/dialog/tasawaaq_dialog.dart';


void favGuestDialog(BuildContext context,
    // registeredOnClick
    ) {

  showDialog(
      context: context,
      builder: (_) {
        return TasawaaqDialog(
          titleTextAlign: TextAlign.start,
          contentTextAlign: TextAlign.start,
          confirmBtnTxt: '${context.translate(AppStrings.LOG_In)}',
          columnCrossAxisAlignment: CrossAxisAlignment.start,
          onClickConfirmBtn: (){
            Navigator.of(context).pushNamed(AppRouts.SignInPage);
          },
          title: '${context.translate(AppStrings.Login_First)}',
          description:
          '${context.translate(AppStrings.need_register)}',
          onCloseBtn: (){
            Navigator.of(context).pop();
          },
        );
      });

  // if(context.use<PrefsService>().userObj == null){
  //   showDialog(
  //       context: context,
  //       builder: (_) {
  //         return TasawaaqDialog(
  //           titleTextAlign: TextAlign.start,
  //           contentTextAlign: TextAlign.start,
  //           confirmBtnTxt: '${context.translate(AppStrings.LOG_In)}',
  //           columnCrossAxisAlignment: CrossAxisAlignment.center,
  //           onClickConfirmBtn: (){
  //             Navigator.of(context).pushNamed(AppRouts.SignInPage);
  //           },
  //           title: '${context.translate(AppStrings.Login_First)}',
  //           description:
  //           '${context.translate(AppStrings.need_register)}',
  //           onCloseBtn: (){
  //             Navigator.of(context).pop();
  //           },
  //         );
  //       });
  // }else{
  //   // registeredOnClick();
  // }


}