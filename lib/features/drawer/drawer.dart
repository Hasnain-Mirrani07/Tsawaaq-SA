import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/drawer/drawer_widgets/drawer_items.dart';
import 'package:tasawaaq/features/drawer/drawer_widgets/drawer_logo_back_button.dart';
import 'package:tasawaaq/features/drawer/drawer_widgets/profile_info.dart';
import 'package:tasawaaq/features/home/home_manager.dart';
import 'package:tasawaaq/features/home/home_response.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = context.use<PrefsService>();
    final homeManager = context.use<HomeManager>();



    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Theme(
        data: Theme.of(context).copyWith(
          // Set the transparency here
          canvasColor: Colors
              .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
        ),
        child: Drawer(
          elevation: 0,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              Container(
                color: AppStyle.blueTextButton,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * .75,
              ),
              Positioned(
                  top: 100,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DrawerLogoBackButton(),
                      ProfileInfo(),
                      SizedBox(
                        height: 25,
                      ),
                      Expanded(
                        child: DrawerItems(),
                      ),
                    ],
                  )),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .75,
                          color: AppStyle.blueTextButton,
                          height: 55,
                          child: Container(
                            // color: Colors.red,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                // Center(
                                //     child: Text(
                                //       "${context.translate(AppStrings.POWERED_BY_LINE)}",
                                //       style: AppFontStyle.whiteTextH5,
                                //     )),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: homeManager.homeSocial.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () async {
                                          await launch(
                                              '${homeManager.homeSocial[index].link}');
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 15.h,
                                          width: 20.w,
                                          child: NetworkAppImage(
                                            imageColor: Colors.white,
                                            imageUrl: '${homeManager.homeSocial[index].image}',
                                            height: 15.h,
                                            width: 20.w,
                                          ),
                                        ),
                                      );
                                    },
                                  )

                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}