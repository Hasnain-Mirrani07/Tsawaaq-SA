import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_style/app_style.dart';

///////////////////////////////////////////////////////////////////////////////
/// Custom alert dialog.
/// ///////////////////////////////////////////////////////////////////////////
class TasawaaqFormContainer extends StatelessWidget {
  final String? confirmBtnTxt;
  final VoidCallback? onClickConfirmBtn;
  final Widget child;

  const TasawaaqFormContainer({
    this.confirmBtnTxt = 'Ok',
    this.onClickConfirmBtn,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            // height: 300.h,
          ),
          Positioned(
            bottom: 0,
            right: 100.w,
            left: 100.w,
            child: Container(
              height: 50,
              padding: EdgeInsets.all(
                8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(17),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    // spreadRadius: 0.1,
                    offset: Offset(0.0, 5.0),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 5.0),
                    ),
                  ],
                ),
                child: child),
          ),
          Positioned(
            bottom: 0,
            right: 100.w,
            left: 100.w,
            child: Container(
              padding: EdgeInsets.all(
                8,
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(17),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black26,
                //     blurRadius: 10.0,
                //     // spreadRadius: 0.1,
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
                    disabledBackgroundColor:
                        AppStyle.yellowButton.withOpacity(0.5),
                    shadowColor: AppStyle.yellowButton,
                    // fixedSize: width == 0
                    //     ? null
                    //     : Size.fromWidth(width ?? MediaQuery.of(context).size.width),
                    // padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    '$confirmBtnTxt',
                    style: onClickConfirmBtn != null
                        ? AppFontStyle.blueTextH2
                        : AppFontStyle.blueTextH2.merge(
                            TextStyle(
                              color: AppStyle.appBarColor.withOpacity(0.5),
                            ),
                          ),
                  ),
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
