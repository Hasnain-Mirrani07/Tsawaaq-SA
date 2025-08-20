// import 'package:afreen/app_core/responsive_ui/device_screen_type.dart';
// import 'package:afreen/app_core/responsive_ui/screen_information.dart';
// import 'package:flutter/material.dart';
//
// class ResponsiveBuilder extends StatelessWidget {
//   final Widget Function(
//       BuildContext context, SizingInformation sizingInformation) builder;
//   const ResponsiveBuilder({Key key, this.builder}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var mediaQuery = MediaQuery.of(context);
//
//     return LayoutBuilder(builder: (context, boxConstraints) {
//       var sizingInformation = SizingInformation(
//         orientation: mediaQuery.orientation,
//         deviceType: getDeviceType(mediaQuery),
//         screenSize: mediaQuery.size,
//         localWidgetSize: Size(
//           boxConstraints.maxWidth,
//           boxConstraints.maxHeight,
//         ),
//       );
//       return builder(context, sizingInformation);
//     });
//   }
// }
