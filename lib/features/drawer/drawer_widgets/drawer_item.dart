import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_style/app_style.dart';


class DrawerItem extends StatelessWidget {
final String? title;
final String? icon;
final bool isPngIcon;
final VoidCallback? onClickBackBtn;

DrawerItem({this.title,this.icon,this.onClickBackBtn,this.isPngIcon = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40.0),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();
          onClickBackBtn!();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          if(isPngIcon != true)  SvgPicture.asset(
              "$icon",
              height: 20.h,
              color: AppStyle.yellowButton,
            ),

            if(isPngIcon == true) Image.asset(icon!,height: 20.h,width: 20.h,),

            SizedBox(
              width: 18,
            ),
            Text("$title",style: AppFontStyle.whiteTextH3,)
          ],
        ),
      ),
    );
  }
}
