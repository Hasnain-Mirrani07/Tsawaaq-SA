import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_style/app_style.dart';

///////////////////////////////////////////////////////////////////////////////
/// Custom alert dialog.
/// ///////////////////////////////////////////////////////////////////////////
class TasawaaqDialog extends StatelessWidget {
  final String? title, description, confirmBtnTxt;
  final VoidCallback? onClickConfirmBtn, onCloseBtn;
  final TextAlign titleTextAlign, contentTextAlign;
  final CrossAxisAlignment columnCrossAxisAlignment;
  final TextStyle? descriptionStyle, titleStyle;

  const TasawaaqDialog({
    this.title,
    this.description,
    this.confirmBtnTxt = 'Ok',
    this.onClickConfirmBtn,
    this.onCloseBtn,
    this.titleTextAlign = TextAlign.center,
    this.contentTextAlign = TextAlign.center,
    this.columnCrossAxisAlignment = CrossAxisAlignment.center,
    this.descriptionStyle,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    final prefs = context.use<PrefsService>();

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            // height: 300.h,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 300.w,
              // height: 270.h,
              padding: EdgeInsets.only(
                bottom: 40,
                top: 16,
                left: 16,
                right: 16,
              ),
              margin: EdgeInsets.only(top: 16, bottom: 33),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(17),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black26,
                //     blurRadius: 10.0,
                //     offset: Offset(0.0, 10.0),
                //   ),
                // ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: columnCrossAxisAlignment,
                children: [
                  onCloseBtn != null
                      ? Align(
                          alignment: prefs.appLanguage == 'en'
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: InkWell(
                            child: Icon(
                              Icons.close,
                              color: AppStyle.appBarColor,
                            ),
                            onTap: onCloseBtn,
                          ),
                        )
                      : Container(),
                  title != null
                      ? Container(
                          margin: EdgeInsets.only(
                              top: onCloseBtn != null ? 5 : 25.0),
                          child: Text(title!,
                              textAlign: titleTextAlign,
                              style: titleStyle != null
                                  ? AppFontStyle.blueTextH3.merge(titleStyle)
                                  : AppFontStyle.blueTextH2),
                        )
                      : Container(),
                  SizedBox(
                    height: title != null ? 20 : 0,
                  ),
                  description != null
                      ? Text(description!,
                          textAlign: contentTextAlign,
                          style: descriptionStyle != null
                              ? AppFontStyle.greyTextH3.merge(descriptionStyle)
                              : AppFontStyle.greyTextH3)
                      : Container(),
                  SizedBox(
                    height: description != null ? 30 : 0,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 70.w,
            left: 70.w,
            child: Container(
              padding: EdgeInsets.all(
                8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(17),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black26,
                //     blurRadius: 10.0,
                //     offset: Offset(0.0, 10.0),
                //   ),
                // ],
              ),
              child: SizedBox(
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: BorderSide(color: AppStyle.yellowButton)),
                    backgroundColor: AppStyle.yellowButton,

                    shadowColor: AppStyle.yellowButton,
                    // fixedSize: width == 0
                    //     ? null
                    //     : Size.fromWidth(width ?? MediaQuery.of(context).size.width),
                    // padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('$confirmBtnTxt', style: AppFontStyle.blueTextH3),
                  onPressed: onClickConfirmBtn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
