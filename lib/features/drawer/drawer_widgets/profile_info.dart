import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = context.use<PrefsService>();
    final langManager = context.use<AppLanguageManager>();
    return Row(
      children: [
        SizedBox(
          width: 15,
        ),
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width * .75 - 15,
          decoration: BoxDecoration(
            color: AppStyle.yellowButton,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(prefs.appLanguage == "en" ? 500 : 0),
              bottomLeft: Radius.circular(prefs.appLanguage == "en" ? 500 : 0),
              bottomRight: Radius.circular(prefs.appLanguage == "en" ? 0 : 500),
              topRight: Radius.circular(prefs.appLanguage == "en" ? 0 : 500),
            ),
          ),
          child: prefs.userObj != null
              ? InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(AppRouts.PROFILE_PAGE);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 25,
                ),
                SvgPicture.asset(
                  AppAssets.USER,
                  height: 40.h,
                ),
                SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${prefs.userObj!.name}",
                        style: AppFontStyle.blueTextH3,
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        "${prefs.userObj!.email}",
                        style: AppFontStyle.blueTextH4,
                        maxLines: 1,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
              : InkWell(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouts.SignInPage,
                    (r) => false,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 25,
                ),
                SvgPicture.asset(
                  AppAssets.LOGIN_ICON,
                  height: 40.h,
                ),
                SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${context.translate(AppStrings.LOGIN)}",
                        style: AppFontStyle.blueTextH3,
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        "${context.translate(AppStrings.LOGIN_INTO)}",
                        style: AppFontStyle.blueTextH4,
                        maxLines: 1,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}