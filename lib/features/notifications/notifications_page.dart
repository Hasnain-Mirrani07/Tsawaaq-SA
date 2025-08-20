import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/notifications/notifications_manager.dart';
import 'package:tasawaaq/features/notifications/notifications_response.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/not_available_widget/not_available_widget.dart';
import 'package:tasawaaq/shared/pagination_observer/pagination_observer.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  void initState() {
    super.initState();
    locator<NotificationsManager>().resetManager();
    locator<NotificationsManager>().reCallManager();
  }

  @override
  Widget build(BuildContext context) {
    final notificationsManager = context.use<NotificationsManager>();
    final prefs = context.use<PrefsService>();



    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: MainAppBar(
          title: Text('${context.translate(AppStrings.NOTIFICATIONS)}'),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Observer<NotificationsResponse>(
            manager: notificationsManager,
            onRetryClicked: () {
              notificationsManager.reCallManager();
            },
            onWaiting: (context) => Container(
                  height: 460.h,
                  child: Center(
                    child: SpinKitWave(
                      color: AppStyle.appBarColor,
                      itemCount: 5,
                      size: 50.0,
                    ),
                  ),
                ),
            onError: (context, dynamic error) {
              String errorMsg;
              if (error.error is SocketException) {
                errorMsg = locator<PrefsService>().appLanguage == 'en'
                    ? 'No Internet Connection'
                    : 'لا يوجد إتصال بالشبكة';
                return Container(
                  height: 460.h,
                  child: MainErrorWidget(
                    icon: Icons.network_check,
                    errorMsg: errorMsg,
                    onRetryClicked: () {
                      notificationsManager.reCallManager();
                    },
                  ),
                );
              } else {
                errorMsg = locator<PrefsService>().appLanguage == 'en'
                    ? 'Something Went Wrong Try Again Later'
                    : 'حدث خطأ ما حاول مرة أخرى لاحقاً';

                return Container(
                  height: 460.h,
                  child: MainErrorWidget(
                    icon: Icons.error_outline_sharp,
                    errorMsg: errorMsg,
                    onRetryClicked: () {
                      notificationsManager.reCallManager();
                    },
                  ),
                );
              }
            },
            stream: notificationsManager.response$,
            onSuccess: (context, notificationsSnapshot) {
              notificationsManager.total = notificationsSnapshot.pagination!.total!;
              notificationsSnapshot.data?.forEach((element) {
                if (notificationsManager.data.length < notificationsManager.total) {
                  if(!notificationsManager.dataIds.contains(element.id!)){
                    notificationsManager.data.add(element);
                    notificationsManager.dataIds.add(element.id!);
                  }
                  // notificationsManager.data.add(element);
                }
              });

              return ListView(
                padding: EdgeInsets.zero,
                controller: notificationsManager.scrollController,
                children: [

                  notificationsManager.data.isNotEmpty
                      ? Container(
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: true,
                              physics: NeverScrollableScrollPhysics(),
                              // padding: EdgeInsets.symmetric(vertical: 30, horizontal: 12),
                              itemCount: notificationsManager.data.length,
                              itemBuilder: (_, index) {
                                return index.isOdd ? FadeInRight(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      elevation: 2,
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [

                                            SvgPicture.asset(
                                              '${AppAssets.ringing}',
                                              color: Color.fromRGBO(1, 62, 106, 0.25),
                                              height: 35,
                                              width: 35,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("${notificationsManager.data[index].title}",style: AppFontStyle.blueTextH3),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text("${notificationsManager.data[index].message}",style: AppFontStyle.greyTextH4),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ):FadeInLeft(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      elevation: 2,
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            SvgPicture.asset(
                                              '${AppAssets.ringing}',
                                              color: Color.fromRGBO(1, 62, 106, 0.25)
                                              ,
                                              height: 35,
                                              width: 35,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("${notificationsManager.data[index].title}",style: AppFontStyle.blueTextH3),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text("${notificationsManager.data[index].message}",style: AppFontStyle.greyTextH4),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })

                        )
                      : Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height *.2,
                          ),
                          NotAvailableComponent(
                              view: FaIcon(
                                FontAwesomeIcons.bellSlash,
                                color: AppStyle.blueTextButtonOpacity,
                                size: 100,
                              ),
                              title:
                                  ('${context.translate(AppStrings.NO_NOTIFICATIONS)}'),
                            ),
                        ],
                      ),
                  StreamBuilder<PaginationState>(
                      initialData: PaginationState.IDLE,
                      stream: notificationsManager.paginationState$,
                      builder: (context, paginationStateSnapshot) {
                        if (paginationStateSnapshot.data ==
                            PaginationState.LOADING) {
                          return ListTile(
                              title: Center(
                            child: SpinKitWave(
                              color: AppStyle.appColor,
                              itemCount: 5,
                              size: 30.0,
                            ),
                          ));
                        }
                        if (paginationStateSnapshot.data ==
                            PaginationState.ERROR) {
                          return Container(
                            color: AppStyle.appBarColor,
                            child: ListTile(
                              leading: Icon(Icons.error),
                              title: Text(
                                '${locator<PrefsService>().appLanguage == 'en' ? 'Something Went Wrong Try Again Later' : 'حدث خطأ ما حاول مرة أخرى لاحقاً'}',
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: ElevatedButton(
                                onPressed: () async {
                                  await notificationsManager
                                      .onErrorLoadMore();
                                },
                                child: Text(
                                    '${locator<PrefsService>().appLanguage == 'en' ? 'Retry' : 'أعد المحاولة'}'),
                              ),
                            ),
                          );
                        }
                        return Container(
                          width: 0,
                          height: 0,
                        );
                      }),
                ],
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
