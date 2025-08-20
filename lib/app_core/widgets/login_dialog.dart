// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:tasawaaq/app_core/app_core.dart';
// import 'package:tasawaaq/app_routs/app_routs.dart';
// import 'package:tasawaaq/app_strings/app_strings.dart';
//
// void loginDialog(BuildContext context, DialogRequest request) {
//   final toast = context.use<ToastTemplate>();
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (context) {
//       return FadeInUp(
//         child: CustomDialog(
//           titleColor: Colors.black,
//           title: request.title,
//           description: request.description,
//           descriptionColor: Colors.black54,
//           // imageInBodyUrl: AppAssets.DIALOG_CONFIRM,
//           // onCloseBtn: () {
//           //   Navigator.of(context).pop();
//           // },
//           confirmBtnTxt: context.translate(AppStrings.LOGIN),
//           onClickConfirmBtn: () {
//             Navigator.of(context).pushNamedAndRemoveUntil(
//                 AppRouts.SIGN_IN_PAGE, (Route<dynamic> route) => false);
//           },
//           cancelBtnTxt: context.translate(AppStrings.CANCEL),
//           onClickCancelBtn: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       );
//     },
//   );
// }
