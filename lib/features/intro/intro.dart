import 'package:animate_do/animate_do.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/intro/intor_manager.dart';
import 'package:tasawaaq/features/intro/intro_response.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';

class OnBoarding {
  String? image;
  String? description;

  OnBoarding({this.image, this.description});
}

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late PageController _pageController;
  late int _length;
  final ValueNotifier<int> pageIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();

    locator<IntroManager>().execute();

    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prefs = context.use<PrefsService>();
    final introManager = context.use<IntroManager>();

    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(0), child: AppBar()),
      body: Observer<IntroResponse>(
          onRetryClicked: () {
            introManager.execute();
          },
          manager: introManager,
          stream: introManager.intro$,
          onSuccess: (context, introSnapshot) {
            return Container(
              // physics: BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewPadding.top,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: prefs.appLanguage == 'en'
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 30),
                        child: TextButton(
                          onPressed: () {
                            prefs.hasWelcomeSeen = true;
                            Navigator.of(context)
                                .pushReplacementNamed(AppRouts.SignInPage);
                          },
                          child: Text(
                            '${context.translate(AppStrings.SKIP)}',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        allowImplicitScrolling: true,
                        reverse: false,
                        onPageChanged: (index) {
                          pageIndex.value = index;
                        },
                        // physics: NeverScrollableScrollPhysics(),
                        physics: BouncingScrollPhysics(),
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        itemCount: introSnapshot.data?.length ??
                            0, // SingleChildScrollView(
                        itemBuilder: (BuildContext context, int index) {
                          _length = introSnapshot.data?.length ?? 0;
                          return Container(
                              // color: Colors.red,
                              padding: const EdgeInsets.all(8),
                              child: NetworkAppImage(
                                imageUrl: '${introSnapshot.data?[index].image}',
                              ));
                        },
                      ),
                    ),
                    Container(
                      // width: 100.w,
                      child: ValueListenableBuilder<int>(
                          valueListenable: pageIndex,
                          builder: (context, value, _) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                  introSnapshot.data?.length ?? 0, (index) {
                                return Container(
                                  width: index == value ? 20 : 10.0,
                                  height: 10.0,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 2.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                    color: index == value
                                        ? AppStyle.yellowButton
                                        : AppStyle.introGrey,
                                  ),
                                );
                              }),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ValueListenableBuilder<int>(
                          valueListenable: pageIndex,
                          builder: (context, value, _) {
                            return FadeIn(
                              duration: Duration(milliseconds: 3000),
                              key: Key('$value'),
                              child: Text(
                                '${introSnapshot.data?[value].desc}',
                                textAlign: TextAlign.center,
                              ),
                            );
                          }),
                    ),
                    SafeArea(
                      child: Container(
                          // width: 100.w,
                          padding: const EdgeInsets.symmetric(
                              vertical: 50, horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 55,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          side: BorderSide(
                                              color: AppStyle.introGrey)),
                                      backgroundColor: AppStyle.introGrey,

                                      shadowColor: AppStyle.introGrey,
                                      // fixedSize: width == 0
                                      //     ? null
                                      //     : Size.fromWidth(width ?? MediaQuery.of(context).size.width),
                                      // padding: const EdgeInsets.symmetric(
                                      //     vertical: 12),
                                    ),
                                    child: Text(
                                        '${context.translate(AppStrings.BACK)}',
                                        style: AppFontStyle.whiteTextH2),
                                    onPressed: () {
                                      if (pageIndex.value > 0) {
                                        _pageController.animateToPage(
                                            pageIndex.value - 1,
                                            duration:
                                                Duration(milliseconds: 1000),
                                            curve: Curves.easeOut);
                                      } else {}
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 55,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          side: BorderSide(
                                              color: AppStyle.yellowButton)),
                                      backgroundColor: AppStyle.yellowButton,

                                      shadowColor: AppStyle.yellowButton,
                                      // fixedSize: width == 0
                                      //     ? null
                                      //     : Size.fromWidth(width ?? MediaQuery.of(context).size.width),
                                      // padding: const EdgeInsets.symmetric(
                                      //     vertical: 12),
                                    ),
                                    child: Text(
                                        '${context.translate(AppStrings.NEXT)}',
                                        style: AppFontStyle.blueTextH2),
                                    onPressed: () {
                                      prefs.hasWelcomeSeen = true;

                                      if (pageIndex.value < _length - 1) {
                                        _pageController.animateToPage(
                                            pageIndex.value + 1,
                                            duration:
                                                Duration(milliseconds: 1000),
                                            curve: Curves.easeOut);
                                      } else {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                AppRouts.SignInPage);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
