import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  final Color dashColor;
  final int dashRatio;
  const DashedLine({Key? key,this.dashColor = Colors.black,this.dashRatio = 5}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(MediaQuery.of(context).size.width~/dashRatio, (index) => Expanded(
          child: Container(
            color: index%2==0?Colors.transparent : dashColor,
            height: 1,
          ),
        )),
      ),
    );
  }
}
