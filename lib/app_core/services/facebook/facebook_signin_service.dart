// import 'package:afreen/app_core/services/facebook/facebook_response.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'dart:convert' as JSON;

// class FacebookSignInService {
//   final _facebookLogin = FacebookLogin();
//   Map _userProfile;

//   Map get userProfile => _userProfile;

//   Future<FacebookResponse> loginWithFB() async {
//     // final result = await facebookLogin.logInWithReadPermissions(['email']);
//     final result = await _facebookLogin.logIn(['email']);

//     switch (result.status) {
//       case FacebookLoginStatus.loggedIn:
//         final token = result.accessToken.token;
//         final Response graphResponse = await Dio().get(
//             'https://graph.facebook.com/v2.12/me?fields=name,picture,email,id&access_token=${token}');
//         final profile = JSON.jsonDecode(graphResponse.data);
//         print(profile);
//         // _userProfile = profile;
//         return FacebookResponse.fromJson(profile);
//         break;

//       case FacebookLoginStatus.cancelledByUser:
//         return null;
//         break;
//       case FacebookLoginStatus.error:
//         print('${result.errorMessage}');
//         return null;
//         break;
//       default:
//         return null;
//     }
//   }

//   Future<void> logout() async {
//     _facebookLogin.logOut();
//   }
// }
