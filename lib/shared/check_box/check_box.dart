import 'package:flutter/material.dart';
import 'package:tasawaaq/app_style/app_style.dart';


class BoxNotChecked extends StatelessWidget {
  const BoxNotChecked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xffDADADA),
      ),
    );
  }
}

class BoxChecked extends StatelessWidget {
  const BoxChecked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppStyle.blueTextButton,
      ),
      child: Center(child: Icon(Icons.check,color: Colors.white,size: 16,),),
    );
  }
}
