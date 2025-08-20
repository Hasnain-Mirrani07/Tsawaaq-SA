import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_style/app_style.dart';

class MainErrorWidget extends StatelessWidget {
  final VoidCallback onRetryClicked;
  final String errorMsg;
  final IconData icon;

  MainErrorWidget({
    Key? key,
    required this.onRetryClicked,
    this.errorMsg = '',
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInDown(
                duration: Duration(seconds: 2),
                child: Flash(
                  infinite: true,
                  duration: Duration(seconds: 5),
                  child: Icon(
                    icon,
                    color: AppStyle.appBarColor,
                    size: 300.w,
                  ),
                ),
              ),
              FadeInDown(
                duration: Duration(seconds: 2),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$errorMsg',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.3,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Spacer(),
              FadeInUp(
                duration: Duration(seconds: 2),
                child: SizedBox(
                  height: 55,
                  width: 225.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: AppStyle.appBarColor)),
                      backgroundColor: AppStyle.appBarColor,
                      shadowColor: AppStyle.appBarColor,
                      // fixedSize: width == 0
                      //     ? null
                      //     : Size.fromWidth(width ?? MediaQuery.of(context).size.width),
                      // padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      locator<PrefsService>().appLanguage == 'en'
                          ? 'Retry'
                          : 'أعد المحاولة',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: onRetryClicked,
                  ),
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
