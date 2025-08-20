// // ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
// import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
// import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform, kIsWeb;
//
// /// Default FirebaseOptions for use with your Firebase apps.
// ///
// /// Example:
// /// ```dart
// /// import 'firebase_options.dart';
// /// // ...
// /// await Firebase.initializeApp(
// ///   options: DefaultFirebaseOptions.currentPlatform,
// /// );
// /// ```
// class DefaultFirebaseOptions {
//   static FirebaseOptions get currentPlatform {
//     if (kIsWeb) {
//       throw UnsupportedError(
//         'DefaultFirebaseOptions have not been configured for web - '
//         'you can reconfigure this by running the FlutterFire CLI again.',
//       );
//     }
//     switch (defaultTargetPlatform) {
//       case TargetPlatform.android:
//         return android;
//       case TargetPlatform.iOS:
//         return ios;
//       case TargetPlatform.macOS:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for macos - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       case TargetPlatform.windows:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for windows - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       case TargetPlatform.linux:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for linux - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       default:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions are not supported for this platform.',
//         );
//     }
//   }
//
//   /// ✅ Android values from google-services.json
//   static const FirebaseOptions android = FirebaseOptions(
//     apiKey: "AIzaSyDhoU3hOg3HCT-OQc0rmk3_S-ID4RvLnlM",
//     appId: "1:92894532835:android:f5a8dff90d9ec16edfa1d6",
//     messagingSenderId: "92894532835",
//     projectId: "tasawaaq-f482f",
//     storageBucket: "tasawaaq-f482f.appspot.com",
//   );
//
//   /// ✅ iOS values from your google-services.json (ios_info)
//   static const FirebaseOptions ios = FirebaseOptions(
//     apiKey: "AIzaSyDhoU3hOg3HCT-OQc0rmk3_S-ID4RvLnlM", // iOS may have different API key, double-check in Firebase console if needed
//     appId: "1:92894532835:ios:82dvv44gj1vg3d7j1l52h1gm5bj5d1mr", // from ios_info in your file
//     messagingSenderId: "92894532835",
//     projectId: "tasawaaq-f482f",
//     storageBucket: "tasawaaq-f482f.appspot.com",
//     iosClientId: "92894532835-82dvv44gj1vg3d7j1l52h1gm5bj5d1mr.apps.googleusercontent.com",
//     iosBundleId: "com.app.tasawaaq",
//   );
// }
