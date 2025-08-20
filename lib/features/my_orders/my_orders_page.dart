import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/drawer/drawer.dart';
import 'package:tasawaaq/features/my_orders/my_orders_manager.dart';
import 'package:tasawaaq/features/my_orders/my_orders_response.dart';
import 'package:tasawaaq/features/my_orders/widgets/my_orders_widget.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  void initState() {
    super.initState();
    locator<MyOrderManager>().switchIndex = 0;
    locator<MyOrderManager>().execute();

  }

  @override
  Widget build(BuildContext context) {
    final prefs = context.use<PrefsService>();
    final myOrderManager = context.use<MyOrderManager>();

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: MainAppBar(
            title: Text('${context.translate(AppStrings.MY_ORDERS)}'),
            hasDrawer: true,
          ),
        ),
        body: Observer<MyOrdersResponse>(
            onRetryClicked: () {
              myOrderManager.execute();
            },
            manager: myOrderManager,
            stream: myOrderManager.myOrders$,
            onSuccess: (context, myOrdersSnapshot) {
              // if(myOrdersSnapshot.data != null){
              //   myOrderManager.ordersSubject.sink.add(myOrdersSnapshot.data!.pending!);
              // }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ValueListenableBuilder<int>(
                    valueListenable: myOrderManager.switchIndexNotifier(),
                    builder: (context, value, _) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              3,
                              (index) {
                                String title;
                                switch (index) {
                                  case 0:
                                    title =
                                        '${context.translate(AppStrings.INPROCESS)}';
                                    break;
                                  case 1:
                                    title =
                                        '${context.translate(AppStrings.COMPLETED)}';
                                    break;
                                  case 2:
                                    title =
                                        '${context.translate(AppStrings.CANCELLED)}';
                                    break;
                                  default:
                                    title = '';
                                }
                                return Expanded(
                                  child: Container(
                                    height: 50,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    // width: double.infinity,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          // elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              side: BorderSide(
                                                  color: Colors.transparent)),
                                          backgroundColor: value == index
                                              ? AppStyle.yellowButton
                                              : Colors.grey[200],

                                          shadowColor: value == index
                                              ? AppStyle.yellowButton
                                              : Colors.grey[200],
                                          // fixedSize: width == 0
                                          //     ? null
                                          //     : Size.fromWidth(width ?? MediaQuery.of(context).size.width),
                                          // padding: const EdgeInsets.symmetric(
                                          //     vertical: 12),
                                        ),
                                        child: Container(
                                          // margin: EdgeInsets.symmetric(
                                          //     horizontal:
                                          //         prefs.appLanguage == 'en'
                                          //             ? 5
                                          //             : 10),
                                          child: Center(
                                            child: Text(
                                              title,
                                              style: TextStyle(
                                                  color: value == index
                                                      ? AppStyle.appBarColor
                                                      : Colors.black54,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          myOrderManager.switchIndex = index;
                                          if (index == 0) {
                                            myOrderManager.ordersSubject.sink
                                                .add(myOrdersSnapshot
                                                    .data!.pending!);
                                          } else if (index == 1) {
                                            myOrderManager.ordersSubject.sink
                                                .add(myOrdersSnapshot
                                                    .data!.completed!);
                                          } else if (index == 2) {
                                            myOrderManager.ordersSubject.sink
                                                .add(myOrdersSnapshot
                                                    .data!.cancelled!);
                                          }
                                        }),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: StreamBuilder<List<Pending>>(
                                stream: myOrderManager.ordersSubject.stream,
                                builder: (context, ordersSubjectSnapshot) {
                                  return ordersSubjectSnapshot.hasData
                                      ? AnimatedSwitcher(
                                          duration: Duration(seconds: 1),
                                          child: Container(
                                            key: Key('$value'),
                                            child: MyOrdersWidget(
                                              id: value,
                                              ordersItems:
                                                  ordersSubjectSnapshot.data,
                                            ),
                                          ),
                                        )
                                      : Container();
                                }),
                          ),
                        ],
                      );
                    }),
              );
            }),
      ),
    );
  }
}
