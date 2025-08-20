import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/features/ads/ads_repo.dart';
import 'package:tasawaaq/features/ads/ads_response.dart';

class AdsManager extends Manager<AdsResponse> {
  final PublishSubject<AdsResponse> _subject = PublishSubject<AdsResponse>();
  final prefs = locator<PrefsService>();

  int adsSeen = 0;

  Stream<AdsResponse> get ads$ => _subject.stream;

  execute() async {
    await AdsRepo.getAds().then((result) {
      adsSeen++;
      if (adsSeen == 1) {
        if (result.error == null) {
          if (result.data?.image == null ||
              result.data?.image == 'null' ||
              result.data?.image == '') {
            if (!prefs.hasWelcomeSeen) {
              locator<NavigationService>()
                  .pushReplacementNamedTo(AppRouts.IntroPage);
              return;
            }
            if (!prefs.hasSignInSeen) {
              locator<NavigationService>()
                  .pushReplacementNamedTo(AppRouts.SignInPage);
              return;
            }
            locator<NavigationService>()
                .pushReplacementNamedTo(AppRouts.TABS_WIDGET);
            return;
          }
          _subject.add(result);
        } else {
          if (!prefs.hasWelcomeSeen) {
            locator<NavigationService>()
                .pushReplacementNamedTo(AppRouts.IntroPage);
            return;
          }
          if (!prefs.hasSignInSeen) {
            locator<NavigationService>()
                .pushReplacementNamedTo(AppRouts.SignInPage);
            return;
          }
          locator<NavigationService>()
              .pushReplacementNamedTo(AppRouts.TABS_WIDGET);
          return;

          // _subject.addError(result.error);
        }
      }
    });
  }



  @override
  void dispose() {}

  @override
  void clearSubject() {}
}
