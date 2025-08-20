import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';

class SocialItem extends StatelessWidget {
final IconData? icon;
final VoidCallback? onClickBtn;

SocialItem({this.icon,this.onClickBtn});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        onTap:onClickBtn,
        child: Container(
          height: 55,
          width: 55,
          color: Colors.black,
          child: Center(
            child: FaIcon(icon,color: Colors.white,),
          ),

        ),
      ),
    );
  }
}

class SocialItemsWidget extends StatelessWidget {
  const SocialItemsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 35,
        ),
        Center(child: Text("${context.translate(AppStrings.LOGIN_WITH)}",style: AppFontStyle.greyTextH3,)),
        SizedBox(
          height: 35,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


            SocialItem(
              icon: FontAwesomeIcons.google,
              onClickBtn: (){
                print("Google");
              },
            ),

            SocialItem(
              icon: FontAwesomeIcons.facebookF,
              onClickBtn: (){
                print("FaceBook");
              },
            ),

            SocialItem(
              icon: FontAwesomeIcons.twitter,
              onClickBtn: (){
                print("twitter");
              },
            ),

            SocialItem(
              icon: FontAwesomeIcons.apple,
              onClickBtn: (){
                print("apple");
              },
            )

          ],
        ),

      ],
    );
  }
}
