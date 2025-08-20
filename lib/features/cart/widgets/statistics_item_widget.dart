import 'package:flutter/material.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/shared/dashed_line/dashed_line.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatisticsItem extends StatelessWidget {

  final String? value;
  final String? title;
  final bool? isTotal;
  const StatisticsItem({Key? key,this.value,this.title,this.isTotal = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Text('$title',style: isTotal == true ? AppFontStyle.greyTextH3.merge(
          TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w800
          ),
        ) : AppFontStyle.greyTextH3,),
// DashedLine(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: DashedLine(
              dashColor: Colors.black45,
              dashRatio: 10,
            ),
          ),
        ),
        Text("$value",style: AppFontStyle.greyTextH3,),
      ],
    );
  }
}
