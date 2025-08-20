// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:tasawaaq/app_assets/app_assets.dart';
// import 'package:tasawaaq/app_core/app_core.dart';
//
// class ChooseLanguage extends StatefulWidget {
//   @override
//   _ChooseLanguageState createState() => _ChooseLanguageState();
// }
//
// class _ChooseLanguageState extends State<ChooseLanguage> {
//   bool _showPassword = false;
//
//   Widget build(BuildContext context) {
//     final langManager = context.use<AppLanguageManager>();
//     final prefs = context.use<PrefsService>();
//     return Scaffold(
//       backgroundColor: Colors.lightGreen,
//       body: SingleChildScrollView(
//         child: Container(
//           width: double.infinity,
//           padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
//           margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: Theme.of(context).primaryColor,
//               boxShadow: [
//                 BoxShadow(
//                     color: Theme.of(context).hintColor.withOpacity(0.2),
//                     offset: Offset(0, 10),
//                     blurRadius: 20)
//               ]),
//           child: Column(
//             children: <Widget>[
//               // SizedBox(height: 25),
//               FadeInDown(
//                 duration: Duration(seconds: 2),
//                 child: BounceInDown(
//                   // infinite: true,
//                   // delay: Duration(seconds: 2),
//                   duration: Duration(seconds: 4),
//                   child: Container(
//                     height: 280.w,
//                     width: 280.w,
//                     child: ClipRRect(
//                         // borderRadius: BorderRadius.circular(200),
//                         child: SvgPicture.asset(
//                       AppAssets.APP_BAR_LOGO,
//                       fit: BoxFit.fill,
//                     )),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 15),
//
//               FadeInDownBig(
//                 duration: Duration(seconds: 2),
//                 child: Pulse(
//                   // delay: Duration(seconds: 2),
//                   duration: Duration(seconds: 2),
//                   child: Text('SELECT LANGUAGE',
//                       style: Theme.of(context).textTheme.headline4),
//                 ),
//               ),
//
//               SizedBox(height: 30),
//               FadeInLeft(
//                 duration: Duration(seconds: 2),
//                 child: SizedBox(
//                   width: 200.w,
//                   height: 45.h,
//                   child: RaisedButton(
//                     // padding: EdgeInsets.symmetric(
//                     //     vertical: 12, horizontal: 70),
//                     onPressed: () {
//                       // 2 number refer the index of Home page
//                       // Navigator.of(context)
//                       //     .pushNamed('/Tabs', arguments: 2);
//                       langManager.changeLanguage(Locale('en'));
//
//                       prefs.hasChosenLanguage = true;
//                       Navigator.of(context).pushReplacementNamed('/Welcome');
//                     },
//                     child: Text(
//                       'English',
//                       style: TextStyle(
//                         height: 1,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//
//                     color: Colors.lightGreen,
//                     shape: StadiumBorder(),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30),
//               FadeInRight(
//                 duration: Duration(seconds: 2),
//                 child: SizedBox(
//                   width: 200.w,
//                   height: 45.h,
//                   child: RaisedButton(
//                     // padding: EdgeInsets.symmetric(
//                     //     vertical: 12, horizontal: 70),
//                     onPressed: () {
//                       // 2 number refer the index of Home page
//                       // Navigator.of(context)
//                       //     .pushNamed('/Tabs', arguments: 2);
//                       langManager.changeLanguage(Locale('ar'));
//                       prefs.hasChosenLanguage = true;
//                       Navigator.of(context).pushReplacementNamed('/Welcome');
//                     },
//                     child: Text(
//                       'العربية',
//                       style: TextStyle(
//                         height: 1,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     color: Colors.lightGreen,
//                     shape: StadiumBorder(),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
