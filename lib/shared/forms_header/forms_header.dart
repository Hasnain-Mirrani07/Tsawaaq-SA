import 'package:flutter/material.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/app_core/app_core.dart';

class FormsHeader extends StatelessWidget {
  final VoidCallback? onSkipClickBtn;
  final bool hasSkipBtn;
  final double upperCenterIconPadding;
  final double bottomCenterIconPadding;
  final double bottomPadding;
  final Widget? centerIcon;
  final String? title, firstDesc, secDesc, yellowSecDesc;
  final CrossAxisAlignment crossAxisAlignment;

  FormsHeader(
      {this.onSkipClickBtn,
      this.hasSkipBtn = false,
      this.upperCenterIconPadding = 40,
      this.bottomCenterIconPadding = 40,
      this.bottomPadding = 100,
      this.centerIcon,
      this.title,
      this.firstDesc,
      this.secDesc,
      this.yellowSecDesc,
      this.crossAxisAlignment = CrossAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
          decoration: BoxDecoration(
            color: AppStyle.blueTextButton,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              hasSkipBtn
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              onSkipClickBtn ?? Navigator.of(context).pop();
                            },
                            child: Text(
                              '${context.translate(AppStrings.SKIP)}',
                              style: AppFontStyle.whiteTextH3,
                            )),
                      ],
                    )
                  : Container(),
              SizedBox(
                height: upperCenterIconPadding,
              ),
              centerIcon ??
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 140,
                        child: Image.asset(
                          AppAssets.APP_BAR_LOGO,
                        ),
                      ),
                      // Text(
                      //   locator<PrefsService>().appLanguage == 'en' ? 'ALWAYS IN STYLE !':'! ALWAYS IN STYLE',
                      //   style: TextStyle(
                      //     fontSize: 8,
                      //     color: AppStyle.yellowButton,
                      //   ),
                      // )
                    ],
                  ),
              SizedBox(
                height: bottomCenterIconPadding,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: crossAxisAlignment,
                  children: [
                    title != null
                        ? Container(
                            padding: EdgeInsets.only(bottom: 12),
                            child: Text(
                              '$title',
                              style: AppFontStyle.whiteTextH1,
                            ))
                        : Container(),
                    firstDesc != null
                        ? Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              '$firstDesc',
                              style: AppFontStyle.whiteTextH4,
                            ))
                        : Container(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        secDesc != null
                            ? Text(
                                '$secDesc',
                                style: AppFontStyle.whiteTextH4,
                                maxLines: 1,
                              )
                            : Container(),
                        secDesc != null
                            ? SizedBox(
                                width: 10,
                              )
                            : Container(),
                        yellowSecDesc != null
                            ? Text(
                                '$yellowSecDesc',
                                style: AppFontStyle.yellowTextH4,
                              )
                            : Container(),
                      ],
                    ),
                    SizedBox(
                      height: bottomPadding,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
