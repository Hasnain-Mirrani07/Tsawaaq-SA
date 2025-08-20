import 'package:flutter/material.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/features/setting/pages/page.dart';
import 'package:tasawaaq/features/sign_in_sign_up/sign_in_manager.dart';
import 'package:tasawaaq/app_core/app_core.dart';

class AcceptTerms extends StatefulWidget {


  @override
  _AcceptTermsState createState() => _AcceptTermsState();
}

class _AcceptTermsState extends State<AcceptTerms> {


  @override
  Widget build(BuildContext context) {
    final signInManager= context.use<SignInManager>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 24.0,
            width: 24.0,
            child: Checkbox(

                value: signInManager.acceptTerms,
                onChanged: (v){
                  setState(() {
                    signInManager.acceptTerms = v;
                  });

                }
            ),
          ),
          SizedBox(
            width: 20,
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
          Text('${context.translate(AppStrings.I_ACCEPT_)}' ' ',style: AppFontStyle.greyTextH4,),
                  InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed(AppRouts.ServicesTemplatePage,
                          arguments: PagesArgs(
                            hasDrawer: false,
                            // title: "${settingSnapshot.data![index].title}",
                            id: "terms",
                          ),);
                      },
                      child: Text(' ${context.translate(AppStrings.terms_Conditions)} ',style: AppFontStyle.greyTextH4,)
                  ),
                  Text(' ${context.translate(AppStrings.AND_STR)} ',style: AppFontStyle.greyTextH4,)
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  // Text('${context.translate(AppStrings.i_accept_plocies)}',style: AppFontStyle.greyTextH4,),
                  InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed(AppRouts.ServicesTemplatePage,
                          arguments: PagesArgs(
                            hasDrawer: false,
                            // title: "${settingSnapshot.data![index].title}",
                            id: "policy",
                          ),);
                      },
                      child: Text('${context.translate(AppStrings.i_accept_plocies)}',style: AppFontStyle.greyTextH4,)),
                  Text(' ${context.translate(AppStrings.OF_TASAWAAQ)}',style: AppFontStyle.greyTextH4,)
                ],
              )

            ],
          ),
        ],
      ),
    );
  }
}