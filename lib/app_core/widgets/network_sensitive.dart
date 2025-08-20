// import 'package:flutter/material.dart';
//
// import '../app_core.dart';
//
// class NetworkSensitive extends StatelessWidget {
//   final Widget child;
//   NetworkSensitive({
//     @required this.child,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // Get our connection status from the provider
//     // Old Method.
//     // var connectionManager = Provider.of(context)<ConnectionCheckerManager>();
//     // New Method.
//     var connectionManager = context.use<ConnectionCheckerManager>();
//     var loadingManager = context.use<LoadingManager>();
//
//     return StreamBuilder(
//       initialData: false,
//       stream: loadingManager.loading$,
//       builder: (context, loadingSnapshot) {
//         return StreamBuilder<InternetStatus>(
//             initialData: InternetStatus.Online,
//             stream: connectionManager.getConnectionStatus$,
//             builder: (context, snapshot) {
//               return snapshot.data == InternetStatus.Online
//                   ? loadingSnapshot.data
//                       ? Stack(
//                           children: [
//                             child,
//                             Container(
//                               width: MediaQuery.of(context).size.width,
//                               height: MediaQuery.of(context).size.height,
//                               color: Colors.black12.withOpacity(0.3),
//                               child: Center(
//                                 child: CircularProgressIndicator(),
//                               ),
//                             ),
//                           ],
//                         )
//                       : child
//                   : WillPopScope(
//                       onWillPop: () async => false,
//                       child: Stack(
//                         fit: StackFit.expand,
//                         children: <Widget>[
//                           child,
//                           loadingSnapshot.data
//                               ? Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   height: MediaQuery.of(context).size.height,
//                                   color: Colors.black12.withOpacity(0.3),
//                                   child: Center(
//                                     child: CircularProgressIndicator(),
//                                   ),
//                                 )
//                               : _internetAlert(context),
//                         ],
//                       ),
//                     );
//             });
//       },
//     );
//   }
// }
//
// /// No Internet Alert with Retry button.
// Widget _internetAlert(BuildContext context) {
//   // var prefs = Provider.of(context)<PrefsService>();
//
//   var prefs = context.use<PrefsService>();
//   var loadingManager = context.use<LoadingManager>();
//
//   return Scaffold(
//     backgroundColor: Colors.black12.withOpacity(0.3),
//     body: AlertDialog(
//       content: Container(
//         decoration: new BoxDecoration(
//           shape: BoxShape.rectangle,
//           color: const Color(0xFFFFFF),
//           borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
//         ),
//         height: prefs.appLanguage == 'en' ? 150 : 160,
//         width: MediaQuery.of(context).size.width * 0.5,
//         child: Column(
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Icon(
//                   Icons.network_check,
//                   size: 30,
//                   color: Colors.blue[900],
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   prefs.appLanguage == 'en'
//                       ? 'No Internet Connection'
//                       : 'لا يوجد إتصال بالشبكة',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 )
//               ],
//             ),
//             Container(
//                 child: Text(
//               prefs.appLanguage == 'en'
//                   ? 'Please check your connection and try again'
//                   : 'من فضلك تأكد من إتصالك بالشبكة وحاول مرة أخرى',
//               textAlign: TextAlign.center,
//               style: TextStyle(height: 1.5),
//             )),
//             SizedBox(
//               height: 15,
//             ),
//             RaisedButton(
//               color: Colors.red,
//               child: Text(
//                 prefs.appLanguage == 'en' ? 'Retry' : 'أعد المحاولة',
//                 style: TextStyle(color: Colors.white),
//               ),
//               onPressed: () async {
//                 loadingManager.inLoading.add(true);
//                 await Future.delayed(Duration(seconds: 7), () {
//                   loadingManager.inLoading.add(false);
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
