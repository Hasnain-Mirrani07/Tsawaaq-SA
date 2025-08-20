import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawaaq/app_style/app_style.dart';

Widget unSelectedRadio(){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5),
    height: 12,
    width: 12,
    decoration: BoxDecoration(
      border: Border.all(
          color: AppStyle.appBarColor, width: 1.5),
      borderRadius: BorderRadius.all(
        Radius.circular(50.0),
      ),
//      color: Colors.white,
    ),
  );
}

Widget selectedRadio(){
  return Container(
    height: 12,
    width: 12,
    decoration: BoxDecoration(
      border: Border.all(
          color: AppStyle.appBarColor, width: 1),
      borderRadius: BorderRadius.all(
        Radius.circular(50.0),
      ),
    ),
    child: Container(
      margin: EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        color: AppStyle.appBarColor,
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
    ),
  );
}



Widget unSelectedBigRadio(){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5),
    height: 20.h,
    width: 20.h,
    decoration: BoxDecoration(
      border: Border.all(
          color: AppStyle.appBarColor, width: 1.5),
      borderRadius: BorderRadius.all(
        Radius.circular(50.0),
      ),
//      color: Colors.white,
    ),
  );
}

Widget selectedBigRadio(){
  return Container(
    height: 20.h,
    width: 20.h,
    decoration: BoxDecoration(
      border: Border.all(
          color: AppStyle.appBarColor, width: 1),
      borderRadius: BorderRadius.all(
        Radius.circular(50.0),
      ),
    ),
    child: Container(
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppStyle.appBarColor,
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
    ),
  );
}

Widget unSelectedBigCheckBox(){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5),
    height: 60.h,
    width: 60.h,
    decoration: BoxDecoration(
      border: Border.all(
          color: AppStyle.appBarColor, width: 1.5),
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
//      color: Colors.white,
    ),
  );
}

Widget selectedBigCheckBox(){
  return Container(
    height: 60.h,
    width: 60.h,
    decoration: BoxDecoration(
      border: Border.all(
          color: AppStyle.appBarColor, width: 1),
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
    ),
    child: Container(
//      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppStyle.appBarColor,
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Center(child: Icon(Icons.check,color: Colors.white,size: 50.sp,),),

    ),
  );
}