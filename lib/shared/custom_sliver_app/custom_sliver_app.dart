import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSliverApp extends StatefulWidget {
  final double? expandedHeight;
  final Widget? body;
  final bool? isBackButton;
  CustomSliverApp({this.expandedHeight,this.body,this.isBackButton = false});

  // const CustomSliverApp({Key? key}) : super(key: key);

  @override
  _CustomSliverAppState createState() => _CustomSliverAppState();
}

class _CustomSliverAppState extends State<CustomSliverApp> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: widget.isBackButton! ? Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios,),
            ),
          ):Container(),
          expandedHeight: widget.expandedHeight,
          flexibleSpace:  FlexibleSpaceBar(
            background: Container(
              color: AppStyle.mainLightGreenBackGround,
              padding: EdgeInsets.all(15),
              height: widget.expandedHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35,
                  ),
Directionality(
  textDirection: TextDirection.ltr,
  child:   Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          SvgPicture.asset(
            AppAssets.APP_BAR_LOGO,
            semanticsLabel: 'tasawaaq Logo',
            height: 40.h,

            // fit: BoxFit.contain,
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        'My',
        style: TextStyle(
            color: AppStyle.appBarColor,
            fontSize: 25.sp,
            fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 5,
      ),
      Text(
        'tasawaaqcy',
        style: TextStyle(
            color: AppStyle.appBarColor,
            fontSize: 25.sp,
            fontWeight: FontWeight.bold),
      ),
    ],
  ),
)
                ],
              ),
            ),
          ),

        ),
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              widget.body!,
            ],
          ),
        ),
      ],
    );
  }
}