import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tasawaaq/app_style/app_style.dart';

class NotAvailableComponent extends StatelessWidget {
  final String? title;
  final String? desc;
  final Widget? view;
  final TextStyle? titleTextStyle;
  final TextStyle? descTextStyle;

  const NotAvailableComponent({
    Key? key,
    this.title,
    this.desc,
    this.view,
    this.titleTextStyle = const TextStyle(
        color: AppStyle.blueTextButtonOpacity, fontSize: 24, fontWeight: FontWeight.w600),
    this.descTextStyle = const TextStyle(
        color: AppStyle.sideTitle, fontSize: 16, fontWeight: FontWeight.w600),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: new ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 25),
            children: [
          Center(
            child: FadeInDown(
              child: ZoomIn(child: view == null ? Container() : view!),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          title == null
              ? Container()
              : FadeInRightBig(
                  child: Center(
                      child: new Text(
                  '$title',
                  style: titleTextStyle,
                  textAlign: TextAlign.center,
                ))),
          SizedBox(
            height: 15,
          ),
          desc == null
              ? Container()
              : FadeInLeftBig(
                  child: Center(
                      child: new Text(
                  '$desc',
                  style: descTextStyle,
                  textAlign: TextAlign.center,
                ))),
        ]));
  }
}
