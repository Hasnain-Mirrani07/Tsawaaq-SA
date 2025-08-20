import 'package:flutter/material.dart';
import 'package:tasawaaq/features/cart/widgets/statistics_item_widget.dart';

import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_core/app_core.dart';

class StatisticsWidget extends StatelessWidget {
  final String? subTotal, delivery, discount, total;
  const StatisticsWidget(
      {Key? key, this.subTotal, this.delivery, this.discount, this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatisticsItem(
            title: "${context.translate(AppStrings.SUB_TOTAL)}",
            value: "$subTotal",
          ),
          SizedBox(
            height: 20,
          ),
          StatisticsItem(
            title: "${context.translate(AppStrings.DELIVERY)}",
            value: "$delivery",
          ),
          SizedBox(
            height: 20,
          ),
          StatisticsItem(
            title: "${context.translate(AppStrings.DISCOUNT)}",
            value: "$discount",
          ),
          SizedBox(
            height: 20,
          ),
          StatisticsItem(
            isTotal: true,
            title: "${context.translate(AppStrings.TOTAL)}",
            value: "$total",
          ),
        ],
      ),
    );
  }
}
