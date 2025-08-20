import 'package:flutter/material.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/app_core/app_core.dart';

class DrawerLogoBackButton extends StatelessWidget {
  const DrawerLogoBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = context.use<PrefsService>();

    return  Container(
      height: 90,
      width: MediaQuery.of(context).size.width - 15,
      decoration: BoxDecoration(
        color: AppStyle.blueTextButton,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(prefs.appLanguage == "en" ? 0.0 : 500),
          bottomLeft: Radius.circular(prefs.appLanguage == "en" ? 0.0 : 500),
          bottomRight: Radius.circular(prefs.appLanguage == "en" ? 500 : 0),
          topRight: Radius.circular(prefs.appLanguage == "en" ? 500 : 0),
        ),
      ),
      child: Center(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .2,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 110,
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
            Spacer(),
            InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                padding: EdgeInsets.all(30),
                  child: Icon(Icons.arrow_back,color: Colors.white,size: 30,)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .085 - 30,
            ),
          ],
        ),
      ),
    );
  }
}
