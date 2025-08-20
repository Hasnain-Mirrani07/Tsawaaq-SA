import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/checkout/widgets/checkout_StatisticsItem.dart';
import 'package:tasawaaq/features/checkout/widgets/checkout_item_widget.dart';
import 'package:tasawaaq/features/order_details/order_details_manager.dart';
import 'package:tasawaaq/features/order_details/order_details_response.dart';
import 'package:tasawaaq/features/re_order/re_order_manager.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/convert_to_flutter_hex/convert_to_flutter_hex.dart';
import 'package:tasawaaq/shared/custom_button/custom_button.dart';
import 'package:tasawaaq/shared/dialog/tasawaaq_dialog.dart';

class OrderDetailsPageArgs {
  final dynamic orderId;
  // final dynamic orderStatus;

  OrderDetailsPageArgs({
    this.orderId,
    // this.orderStatus,
  });
}

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);


  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {


  OrderDetailsPageArgs? args;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      args = ModalRoute.of(context)!.settings.arguments as OrderDetailsPageArgs;

      if(args != null){
        context.use<ReOrderManager>().execute(id: args!.orderId!);
      }


    });
  }

  @override
  Widget build(BuildContext context) {
    final orderDetailsManager = context.use<OrderDetailsManager>();
    final reOrderManager = context.use<ReOrderManager>();

    // final OrderDetailsPageArgs args =
    //     ModalRoute.of(context)!.settings.arguments as OrderDetailsPageArgs;

    // args =
    // ModalRoute.of(context)!.settings.arguments as OrderDetailsPageArgs;
    if(args==null){
      args =
      ModalRoute.of(context)!.settings.arguments as OrderDetailsPageArgs;
      context.use<ReOrderManager>().execute(id: args!.orderId!);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      persistentFooterButtons: [
        Observer<OrderDetailsResponse>(
            onWaiting: (context) => Container(),
            onError: (context, error) => Container(),
            onRetryClicked: () {
              context.use<ReOrderManager>().execute(id: args!.orderId!);
            },
            manager: orderDetailsManager,
            stream: orderDetailsManager.orderDetails$,
            onSuccess: (context, orderDetailsSnapshot) {
              return orderDetailsSnapshot.data!.canReorder != 0
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      child: CustomButton(
                        onClickBtn: () {
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
                                      id: args!.orderId,
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  title:
                                      '${context.translate(AppStrings.alert)}',
                                  description:
                                      '${context.translate(AppStrings.products_cart_deleted)}',
                                );
                              });
                          // _deleteCartDialog(context,
                          //     );
                        },
                        txt: '${context.translate(AppStrings.Reorder)}',
                        // txt: '${context.translate(AppStrings.PROCEED_TO_CHECKOUT)}',
                        btnWidth: double.infinity,
                        btnColor: AppStyle.yellowButton,
                      ),
                    )
                  : const SizedBox(
                      width: 0,
                      height: 0,
                    );
            }),
      ],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: MainAppBar(
          title: Text('${context.translate(AppStrings.ORDER_DETAILS)}'),
          hasCart: false,
        ),
      ),
      body: Observer<OrderDetailsResponse>(
          onRetryClicked: () {
            orderDetailsManager.execute(orderId: args!.orderId);
          },
          manager: orderDetailsManager,
          stream: orderDetailsManager.orderDetails$,
          onSuccess: (context, orderDetailsSnapshot) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${orderDetailsSnapshot.data!.user}',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    height: 1.3,
                                    color: AppStyle.appBarColor,
                                    fontWeight: FontWeight.w800),
                              ),
                              Text(
                                '${context.translate(AppStrings.ORDER_ID)} # ${orderDetailsSnapshot.data!.id}',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    height: 1.3,
                                    color: AppStyle.appBarColor,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  '${orderDetailsSnapshot.data!.address}',
                                  style: AppFontStyle.greyTextH4,

                                  maxLines: 2,
                                  // textWidthBasis: TextWidthBasis.longestLine,
                                ),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${orderDetailsSnapshot.data!.createdAt}',
                                    style: AppFontStyle.greyTextH4,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${orderDetailsSnapshot.data!.createdTime}',
                                    style: AppFontStyle.greyTextH4,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          btnWidget: Center(
                              child: Text(
                            "${orderDetailsSnapshot.data!.status}",
                            style: TextStyle(
                                color: AppStyle.appBarColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 15.sp),
                          )),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 45,
                  ),
                  Text(
                    '${context.translate(AppStrings.YOUR_ORDER_SUMMARY)}',
                    style: AppFontStyle.blueTextH3,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: orderDetailsSnapshot.data!.items!.length,
                    itemBuilder: (_, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 7),
                        child: CheckOutItemWidget(
                          price:
                              "${orderDetailsSnapshot.data!.items![index].price} ${orderDetailsSnapshot.data!.currency}",
                          imgUrl:
                              "${orderDetailsSnapshot.data!.items![index].image}",
                          size:
                              "${orderDetailsSnapshot.data!.items![index].size}",
                          name:
                              "${orderDetailsSnapshot.data!.items![index].name}",
                          color: orderDetailsSnapshot.data!.items![index].colorHexa != null ? "${orderDetailsSnapshot.data!.items![index].colorHexa}":null,
                        ),
                      );
                    },
                  ),
                  Divider(
                    height: 45,
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Text(
                    '${context.translate(AppStrings.PAYMENT_METHOD)}',
                    style: AppFontStyle.blueTextH3,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "${orderDetailsSnapshot.data!.payment!.paymentMethod}",
                    style: AppFontStyle.greyTextH4,
                    maxLines: 1,
                  ),
                  Divider(
                    height: 45,
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Text(
                    '${context.translate(AppStrings.PAYMENT_DETAILS)}',
                    style: AppFontStyle.blueTextH3,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  StatisticsWidget(
                    delivery:
                        "${orderDetailsSnapshot.data!.payment!.delivery} ${orderDetailsSnapshot.data!.currency}",
                    discount:
                        "${orderDetailsSnapshot.data!.payment!.discount} ${orderDetailsSnapshot.data!.currency}",
                    subTotal:
                        "${orderDetailsSnapshot.data!.payment!.subtotal} ${orderDetailsSnapshot.data!.currency}",
                    total:
                        "${orderDetailsSnapshot.data!.payment!.total} ${orderDetailsSnapshot.data!.currency}",
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            );
          }),
    );
  }
}

// void _deleteCartDialog(BuildContext context,onClick) {
//
// }
