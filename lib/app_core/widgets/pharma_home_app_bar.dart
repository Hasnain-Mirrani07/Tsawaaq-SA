import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_style/app_style.dart';

class tasawaaqHomeAppBar extends StatelessWidget {
  const tasawaaqHomeAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final drawerManager = context.use<HiddenDrawerManager>();
    return AppBar(
      elevation: 0,
      title: Row(
        children: [
          SvgPicture.asset(
            AppAssets.APP_BAR_LOGO,
            semanticsLabel: 'tasawaaq Logo',

            // fit: BoxFit.contain,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            'My tasawaaqcy',
            style: TextStyle(
                color: AppStyle.appBarColor,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [],
    );
  }
}
