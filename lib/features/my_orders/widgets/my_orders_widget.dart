import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/my_orders/my_orders_response.dart';
import 'package:tasawaaq/features/order_details/order_details_page.dart';
import 'package:tasawaaq/features/re_order/re_order_manager.dart';
import 'package:tasawaaq/shared/dialog/tasawaaq_dialog.dart';
import 'package:tasawaaq/shared/not_available_widget/not_available_widget.dart';

class MyOrdersWidget extends StatelessWidget {
  final int? id;
  final List<Pending>? ordersItems;
  MyOrdersWidget({Key? key, this.ordersItems, this.id = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reOrderManager = context.use<ReOrderManager>();

    final prefs = context.use<PrefsService>();
    return ordersItems!.isNotEmpty
        ? ListView.builder(
            primary: false,
            reverse: false,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemCount: ordersItems!.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // Navigator.of(context).pushNamed(
                  //     AppRouts.ProductDetails,
                  //     );
                  Navigator.of(context).pushNamed(AppRouts.OrderDetailsPage,
                      arguments: OrderDetailsPageArgs(
                        orderId: ordersItems![index].id,
                        // orderStatus: ordersItems![index].status
                      ));
                },
                child: Stack(
                  children: [
                    if (id != 0)
                      Positioned(
                        bottom: 0,
                        right: 110.w,
                        left: 110.w,
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.all(
                            8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(17),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10.0,
                                // spreadRadius: 0.1,
                                offset: Offset(0.0, 5.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 5),
                      padding: EdgeInsets.only(bottom: id != 0 ? 13 : 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(21),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width,
                            // height: 160.h,
                            // height: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 35,
                                      vertical: 35,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          // margin: EdgeInsets.only(top: 0),
                                          child: Text(
                                            // '${context.translate(AppStrings.ORDER_ID)} #${items[index].id}',
                                            '${context.translate(AppStrings.ORDER_ID)} #${ordersItems![index].id}',
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                height: 1.3,
                                                color: AppStyle.appBarColor,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            // '${context.translate(AppStrings.ITEMS)} : ${items[index].items}',
                                            '${context.translate(AppStrings.ITEMS)} : ${ordersItems![index].items}',
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              height: 1.3,
                                              // color: Colors.black54,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            // textWidthBasis: TextWidthBasis.longestLine,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 9),
                                          child: Text(
                                            '${ordersItems![index].total} ${ordersItems![index].currency}',
                                            // '${items[index].total}',
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              height: 1.3,
                                              color: AppStyle.yellowButton,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            // textWidthBasis: TextWidthBasis.longestLine,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 35, horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${ordersItems![index].createdAt}',
                                        // '${items[index].date}',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          height: 1.3,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        '${ordersItems![index].createdTime}',
                                        // '${items[index].time}',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          height: 1.3,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      if (id == 0)
                                        Text(
                                          // '${context.translate(AppStrings.ORDER_ID)} #${items[index].id}',
                                          // '${context.translate(AppStrings.INPROCESS)}',
                                          '${ordersItems![index].status}',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              height: 1.3,
                                              color: AppStyle.appBarColor,
                                              fontWeight: FontWeight.w800),
                                        ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (ordersItems![index].canReorder != 0)
                      Positioned(
                        bottom: 0,
                        right: 110.w,
                        left: 110.w,
                        child: Container(
                          padding: EdgeInsets.all(
                            8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                    side: BorderSide(
                                        color: AppStyle.yellowButton)),
                                backgroundColor: AppStyle.yellowButton,

                                shadowColor: AppStyle.yellowButton,
                                // fixedSize: width == 0
                                //     ? null
                                //     : Size.fromWidth(width ?? MediaQuery.of(context).size.width),
                                // padding:
                                //     const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: Text(
                                  '${context.translate(AppStrings.Reorder)}',
                                  style: AppFontStyle.blueTextH4),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return TasawaaqDialog(
                                        onCloseBtn: () {
                                          Navigator.of(context).pop();
                                        },
                                        titleTextAlign: TextAlign.center,
                                        contentTextAlign: TextAlign.center,
                                        confirmBtnTxt:
                                            '${context.translate(AppStrings.Reorder)}',
                                        columnCrossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        onClickConfirmBtn: () {
                                          reOrderManager.execute(
                                            id: ordersItems![index].id!,
                                          );
                                          Navigator.of(context).pop();
                                        },
                                        title:
                                            '${context.translate(AppStrings.alert)}',
                                        description:
                                            '${context.translate(AppStrings.products_cart_deleted)}',
                                      );
                                    });
                              },
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            })
        : NotAvailableComponent(
            view: FaIcon(
              FontAwesomeIcons.boxOpen,
              color: AppStyle.blueTextButtonOpacity,
              size: 100,
            ),
            title: ('${context.translate(AppStrings.EMPTY_ORDER_STATUS)}'),
          );
  }
}
