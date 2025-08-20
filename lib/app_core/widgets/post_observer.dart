// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:tasawaaq/app_style/app_style.dart';
//
// typedef _OnSuccessFunction<T> = Widget Function(BuildContext context, T data);
// typedef _OnErrorFunction = Widget Function(BuildContext context, Object error);
// typedef _OnWaitingFunction = Widget Function(BuildContext context);
//
// class PostObserver<T> extends StatelessWidget {
//   final Stream<T> stream;
//
//   final _OnSuccessFunction<T> onSuccess;
//   final _OnWaitingFunction? onWaiting;
//   final _OnErrorFunction? onError;
//
//   const PostObserver({
//     Key? key,
//     required this.stream,
//     required this.onSuccess,
//     this.onWaiting,
//     this.onError,
//   }) : super(key: key);
//
//   Function get _defaultOnWaiting =>
//       (context) => Center(child: CircularProgressIndicator());
//   Function get _defaultOnError => (context, error) => Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text('$error'),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16.0),
//                   side: BorderSide(
//                     color: AppStyle.appBarColor,
//                   )),
//               backgroundColor: AppStyle.appBarColor,
//
//               shadowColor: AppStyle.appBarColor,
//               // fixedSize: width == 0
//               //     ? null
//               //     : Size.fromWidth(width ?? MediaQuery.of(context).size.width),
//               padding: const EdgeInsets.symmetric(vertical: 12),
//             ),
//             child: Text(''),
//             onPressed: () {},
//           ),
//         ],
//       );
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: stream,
//       builder: (context, AsyncSnapshot<T>? snapshot) {
//         if (snapshot!.hasError) {
//           return (onError != null)
//               ? onError!(context, snapshot.error!)
//               : _defaultOnError(context, snapshot.error);
//         }
//
//         if (snapshot.hasData) {
//           T data = snapshot.data!;
//           return onSuccess(context, data);
//         } else {
//           return (onWaiting != null)
//               ? onWaiting!(context)
//               : _defaultOnWaiting(context);
//         }
//       },
//     );
//   }
// }
