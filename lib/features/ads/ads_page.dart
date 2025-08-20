import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/ads/ads_manager.dart';
import 'package:tasawaaq/features/ads/ads_response.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';

class AdsPage extends StatefulWidget {
  AdsPage({Key? key}) : super(key: key);

  @override
  State<AdsPage> createState() => _AdsPageState();
}

class _AdsPageState extends State<AdsPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.use<AdsManager>().execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final adsManager = context.use<AdsManager>();
    final prefs = context.use<PrefsService>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(5),
        child: MainAppBar(
          hasRoundedEdge: false,
        ),
      ),
      body: Container(
        child: Observer<AdsResponse>(
            onRetryClicked: adsManager.execute,
            manager: adsManager,
            onWaiting: (context) => Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: AppStyle.blueTextButtonMoreOpacity,
                  child: Center(
                    child: Bounce(
                      child: Container(
                        width: 150,
                        child: Image.asset(
                          AppAssets.APP_BAR_LOGO,
                        ),
                      ),
                      // child:SvgPicture.asset(
                      //   AppAssets.APP_BAR_LOGO,
                      //   semanticsLabel: 'tasawaaq Logo',
                      //   color: Colors.white,
                      //   // fit: BoxFit.contain,
                      // ),
                    ),
                  ),
                ),
            stream: adsManager.ads$,
            onSuccess: (context, adsSnapshot) {
              return Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: NetworkAppImage(
                      boxFit: BoxFit.fill,
                      imageUrl: "${adsSnapshot.data?.image}",
                    ),
                  ),
                  Positioned(
                    bottom: 35,
                    right: 25,
                    left: 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              if (!prefs.hasWelcomeSeen) {
                                Navigator.of(context)
                                    .pushReplacementNamed(AppRouts.IntroPage);
                                return;
                              }
                              if (!prefs.hasSignInSeen) {
                                Navigator.of(context)
                                    .pushReplacementNamed(AppRouts.SignInPage);
                                return;
                              }
                              Navigator.of(context)
                                  .pushReplacementNamed(AppRouts.TABS_WIDGET);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: AppStyle.appBarColor.withOpacity(0.4),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                    color:
                                        AppStyle.appBarColor.withOpacity(0.5),
                                    width: 2),
                              ),
                              child: Text(
                                  '${context.translate(AppStrings.SKIP)}',
                                  style: AppFontStyle.whiteTextH3),
                            )),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adsManager = context.use<AdsManager>();
    final prefs = context.use<PrefsService>();
    bool hasImage = true;
    return Container(
      child: Observer<AdsResponse>(
          onRetryClicked: adsManager.execute,
          manager: adsManager,
          stream: adsManager.ads$,
          onSuccess: (context, adsSnapshot) {
            hasImage = adsSnapshot.data?.image != null;
            print('hasImage $hasImage');
            return Container();
          }),
    );
  }
}
