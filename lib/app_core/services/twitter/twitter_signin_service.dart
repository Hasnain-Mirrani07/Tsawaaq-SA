// import 'dart:convert' as JSON;

// import 'package:afreen/app_core/services/twitter/twitter_api_response.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_twitter_login/flutter_twitter_login.dart';
// import 'package:twitter_api/twitter_api.dart';

// class TwitterSignInService {
//   TwitterLogin _twitterLogin = new TwitterLogin(
//     consumerKey: '3Eyf6hLqQuCE4igbJsTauHGJp',
//     consumerSecret: 'fCamiuFA2AqOYeKAi8qAmAng89ggQ1ZL6oN0hK0IWvxcgeuZwK',
//   );
//   TwitterSession _session;

//   TwitterSession get session => _session;

//   void clearTwitterSession() {
//     _session = null;
//   }

//   Future<void> signInTwitter() async {
//     final TwitterLoginResult result = await _twitterLogin.authorize();

//     switch (result.status) {
//       case TwitterLoginStatus.loggedIn:
//         _session = result.session;
//         // _sendTokenAndSecretToServer(session.token, session.secret);
//         print(_session.username);
//         break;
//       case TwitterLoginStatus.cancelledByUser:
//         // _showCancelMessage();
//         print('Cancelled by user');
//         break;
//       case TwitterLoginStatus.error:
//         print(result.errorMessage);
//         break;
//     }
//   }

//   Future<TwitterApiResponse> twitterRequestDetails(
//       {@required String token, @required String tokenSecret}) async {
//     final _twitterOauth = new twitterApi(
//       consumerKey: '3Eyf6hLqQuCE4igbJsTauHGJp',
//       consumerSecret: 'fCamiuFA2AqOYeKAi8qAmAng89ggQ1ZL6oN0hK0IWvxcgeuZwK',
//       token: token,
//       tokenSecret: tokenSecret,
//     );
//     var res = await _twitterOauth
//         .getTwitterRequest("GET", "account/verify_credentials.json", options: {
//       "user_id": "19025957",
//       "name": "TTCnotices",
//       "screen_name": "TTCnotices",
//       "include_email": "true",
//     });
//     final data = JSON.jsonDecode(res.body);

//     return TwitterApiResponse.fromJson(data);
//   }
// }
