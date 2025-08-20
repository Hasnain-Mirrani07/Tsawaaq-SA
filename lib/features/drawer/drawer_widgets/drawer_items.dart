import 'package:flutter/material.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/features/drawer/drawer_widgets/drawer_item.dart';
import 'package:tasawaaq/features/setting/pages/page.dart';

class DrawerItems extends StatelessWidget {
  const DrawerItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = context.use<PrefsService>();
    return Container(
      width: MediaQuery.of(context).size.width * .75 + 40,
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Container(
        // color: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // DrawerItem(
            //   title: "${context.translate(AppStrings.HOME)}",
            //   icon: AppAssets.home,
            //   onClickBackBtn: (){
            //     print("Home");
            //
            //     if (ModalRoute.of(context)!.settings.name != AppRouts.TABS_WIDGET) {
            //       Navigator.of(context)
            //       .pushNamedAndRemoveUntil(AppRouts.TABS_WIDGET, (Route<dynamic> route) => false);
            //     }
            //     // Navigator.of(context).pushNamed(AppRouts.PROFILE_PAGE);
            //
            //   },
            // ),


            DrawerItem(
              title: "${context.translate(AppStrings.HOME)}",
              icon: AppAssets.HOME_ICON,
              onClickBackBtn: () {
                print("HOME");

                if (ModalRoute.of(context)!.settings.name != AppRouts.TABS_WIDGET) {
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRouts.TABS_WIDGET, (Route<dynamic> route) => false);
                }
              },
            ),

            prefs.userObj != null
                ? DrawerItem(
              title: "${context.translate(AppStrings.MY_PROFILE)}",
              icon: AppAssets.USER,
              onClickBackBtn: () {
                print("PROFILE");

                if (ModalRoute.of(context)!.settings.name !=
                    AppRouts.PROFILE_PAGE) {
                  if (ModalRoute.of(context)!.settings.name !=
                      AppRouts.TABS_WIDGET) {
                    Navigator.of(context)
                        .pushReplacementNamed(AppRouts.PROFILE_PAGE);
                  } else {
                    Navigator.of(context)
                        .pushNamed(AppRouts.PROFILE_PAGE);
                  }
                }

              },
            )
                : Container(),
            prefs.userObj != null
                ? DrawerItem(
              title: "${context.translate(AppStrings.MY_ORDERS)}",
              icon: AppAssets.BAGPNG,
              isPngIcon: true,
              // icon: AppAssets.BAG_OUTLINE_ICON,
              onClickBackBtn: () {
                print("MY_ORDERS");
                if (ModalRoute.of(context)!.settings.name !=
                    AppRouts.MyOrdersPage) {
                  if (ModalRoute.of(context)!.settings.name !=
                      AppRouts.TABS_WIDGET) {
                    Navigator.of(context)
                        .pushReplacementNamed(AppRouts.MyOrdersPage);
                  } else {
                    Navigator.of(context)
                        .pushNamed(AppRouts.MyOrdersPage);
                  }
                }
              },
            )
                : Container(),
            DrawerItem(
              title: "${context.translate(AppStrings.OFFERS)}",
              icon: AppAssets.OFFERS_ICON,
              onClickBackBtn: () {
                print("OFFERS");
                if (ModalRoute.of(context)!.settings.name !=
                    AppRouts.OffersPage) {
                  if (ModalRoute.of(context)!.settings.name !=
                      AppRouts.TABS_WIDGET) {
                    Navigator.of(context)
                        .pushReplacementNamed(AppRouts.OffersPage);
                  } else {
                    Navigator.of(context).pushNamed(AppRouts.OffersPage);
                  }
                }
              },
            ),
            DrawerItem(
              title: "${context.translate(AppStrings.ABOUT)}",
              icon: AppAssets.ABOUT_ICON,
              onClickBackBtn: () {
                print("ABOUT");
                if (ModalRoute.of(context)!.settings.name !=
                    AppRouts.ServicesTemplatePage) {
                  if (ModalRoute.of(context)!.settings.name !=
                      AppRouts.TABS_WIDGET) {
                    Navigator.of(context).pushReplacementNamed(
                      AppRouts.ServicesTemplatePage,
                      arguments: PagesArgs(
                        hasDrawer: true,
                        // title: "${settingSnapshot.data![index].title}",
                        id: "about",
                      ),
                    );
                  } else {
                    Navigator.of(context).pushNamed(
                      AppRouts.ServicesTemplatePage,
                      arguments: PagesArgs(
                        hasDrawer: true,
                        // title: "${settingSnapshot.data![index].title}",
                        id: "about",
                      ),
                    );
                  }
                }
                // Navigator.of(context).pushNamed(
                //   AppRouts.ServicesTemplatePage,
                //   arguments: PagesArgs(
                //     // title: "${settingSnapshot.data![index].title}",
                //       id: "about",
                //   ),
                // );
              },
            ),
            DrawerItem(
              title: "${context.translate(AppStrings.CONTACT_US)}",
              icon: AppAssets.SUPPORT_ICON,
              onClickBackBtn: () {
                if (ModalRoute.of(context)!.settings.name !=
                    AppRouts.ContactUsPage) {
                  if (ModalRoute.of(context)!.settings.name !=
                      AppRouts.TABS_WIDGET) {
                    Navigator.of(context)
                        .pushReplacementNamed(AppRouts.ContactUsPage);
                  } else {
                    Navigator.of(context).pushNamed(AppRouts.ContactUsPage);
                  }
                }
                // Navigator.of(context).pushNamed(AppRouts.ContactUsPage);
                // print("ABOUT");
              },
            ),
            SizedBox(
              height: 75,
            ),
          ],
        ),
      ),
    );
  }
}