import 'package:flutter/material.dart';

import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/shared/curved_container/curved_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CounterWidget extends StatelessWidget {

  final VoidCallback? onClickCIncrement,onClickDecrement;
  final int? count;


  const CounterWidget({Key? key,this.count,this.onClickCIncrement,this.onClickDecrement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CurvedContainer(
      borderRadius: 8,
      borderColor: AppStyle.introGrey,
      padding: 3,
      containerColor: AppStyle.greyWhite,
      widget: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: onClickDecrement,
            child:Icon(Icons.remove,color:Color(0xff000000),size: 18.w,),
          ),
          SizedBox(
            width: 20,
          ),
          Text("${count}",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w800),),
          SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: onClickCIncrement,
            child:Icon(Icons.add,color: Color(0xff4C5059),size: 18.w,),
          ),

        ],
      ),
    );
  }
}
