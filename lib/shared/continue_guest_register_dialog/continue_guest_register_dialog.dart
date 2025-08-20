import 'package:flutter/material.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_core/app_core.dart';



class Button extends StatelessWidget {

  final VoidCallback? onClickBtn;
  final String? title;
  final Color? btnColor;
  final TextStyle? titleTextStyle;

  const Button({
    Key? key,
    this.onClickBtn,
    this.title,this.btnColor = AppStyle.yellowButton,
    this.titleTextStyle = const TextStyle(color: AppStyle.blueTextButton, fontSize: 18, height: 1.3)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
          onTap: onClickBtn,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: btnColor,
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Text(
              "$title",
              style: titleTextStyle,
              textAlign: TextAlign.center,
            ),
          )
      ),
    );
  }
}


void continueGuestRegister(BuildContext context,onClickContinueGuest) {
  showDialog(
    context: context,
    builder: (context) {
      return BounceInDown(
        // width: MediaQuery.of(context).size.width,

        child: ElasticIn(
          child: Theme(
            data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.white),
            child: new SimpleDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 7,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 35,
                      ),
                      Button(
                        title: "${context.translate(AppStrings.CONTINUE_AS_GUEST)}",
                        onClickBtn: onClickContinueGuest,
                        btnColor: AppStyle.blueTextButton,
                        titleTextStyle: TextStyle(
                            color: AppStyle.yellowButton,
                            fontSize: 16
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Button(
                        title: "${context.translate(AppStrings.BTN_REGISTER)}",
                        onClickBtn: (){
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRouts.SignInPage, (Route<dynamic> route) => false);
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal:25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: Container(height: 1,
                              color: Colors.black,)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8 ),
                              child: Text("${context.translate(AppStrings.OR)}"),
                            ),
                            Expanded(child: Container(height: 1,
                              color: Colors.black,))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Button(
                        title: "${context.translate(AppStrings.LOG_In)}",
                        onClickBtn: (){
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRouts.SignInPage, (Route<dynamic> route) => false);
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

