import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/all_stores/all_stores_manager.dart';
import 'package:tasawaaq/features/all_stores/all_stores_response.dart';
import 'package:tasawaaq/features/filter/filter_manager.dart';
import 'package:tasawaaq/features/product_list/product_list_manager.dart';
import 'package:tasawaaq/features/product_list/product_list_page.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';
import 'package:tasawaaq/shared/not_available_widget/not_available_widget.dart';

// ignore: must_be_immutable
class AllStoresPage extends StatefulWidget {
  AllStoresPage({Key? key}) : super(key: key);

  @override
  _AllStoresPageState createState() => _AllStoresPageState();
}

class _AllStoresPageState extends State<AllStoresPage> {
  @override
  void initState() {
    super.initState();
    locator<AllStoresManager>().selectedIndex.value = 0;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.use<AllStoresManager>().execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final allStoresManager = context.use<AllStoresManager>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: MainAppBar(
          title: Text('${context.translate(AppStrings.all_stores)}'),
        ),
      ),
      body: Observer<StoresResponse>(
          onRetryClicked: () {
            allStoresManager.selectedIndex.value = 0;
            allStoresManager.execute();
          },
          manager: allStoresManager,
          stream: allStoresManager.stores$,
          onSuccess: (context, storesSnapshot) {
            return Column(
              children: [
                const SizedBox(
                  height: 35,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ValueListenableBuilder<int>(
                      valueListenable: allStoresManager.selectedIndex,
                      builder: (context, value, _) {
                        return Center(
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  storesSnapshot.data?.categories?.length ?? 0,
                              itemBuilder: (_, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            side: BorderSide(
                                              color: value == index
                                                  ? AppStyle.yellowButton
                                                  : Colors.grey[300]!,
                                            )),
                                        backgroundColor: value == index
                                            ? AppStyle.yellowButton
                                            : Colors.grey[100],

                                        shadowColor: value == index
                                            ? AppStyle.yellowButton
                                            : Colors.grey[100],
                                        // fixedSize: width == 0
                                        //     ? null
                                        //     : Size.fromWidth(width ?? MediaQuery.of(context).size.width),
                                        // padding: const EdgeInsets.symmetric(vertical: 12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Text(
                                          '${storesSnapshot.data?.categories?[index].name}',
                                          style: value == index
                                              ? AppFontStyle.blueTextH2.merge(
                                                  TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 18.sp,
                                                  ),
                                                )
                                              : AppFontStyle.blueTextH2.merge(
                                                  TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.sp,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      onPressed: () {
                                        allStoresManager.selectedIndex.value =
                                            index;
                                        allStoresManager.execute(
                                            id: storesSnapshot
                                                .data!.categories![index].id!);
                                      },
                                    ),
                                  ),
                                );
                              }),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 10,
                  child: storesSnapshot.data!.stores!.isNotEmpty
                      ? ListView.builder(
                          itemCount: storesSnapshot.data?.stores?.length ?? 0,
                          itemExtent: 180,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              width: double.infinity,
                              child: InkWell(
                                onTap: () {
                                  context
                                      .use<ProductListManager>()
                                      .storeId
                                      .sink
                                      .add(
                                          "${storesSnapshot.data!.stores![index].id!}");
                                  context
                                      .use<ProductListManager>()
                                      .cateId
                                      .sink
                                      .add("");
                                  locator<FilterManager>()
                                      .cateIndexSubject
                                      .sink
                                      .add([]);
                                  Navigator.of(context).pushNamed(
                                    AppRouts.ProductsListPage,
                                    arguments: ProductsListPageArgs(
                                        id: storesSnapshot
                                            .data!.stores![index].id!,
                                        logo: storesSnapshot
                                            .data!.stores![index].logo!,
                                        name: storesSnapshot
                                            .data!.stores![index].name!,
                                        cateId: "",
                                        storeId:
                                            "${storesSnapshot.data!.stores![index].id!}"),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        child: Card(
                                          // color: Colors.transparent,

                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: NetworkAppImage(
                                              imageUrl:
                                                  "${storesSnapshot.data?.stores?[index].logo}",
                                              boxFit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 8, right: 8),
                                      child: Text(
                                          "${storesSnapshot.data?.stores?[index].name}",
                                          style: AppFontStyle.greyTextH3),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : NotAvailableComponent(
                          view: FaIcon(
                            FontAwesomeIcons.boxOpen,
                            color: AppStyle.blueTextButtonOpacity,
                            size: 100,
                          ),
                          title:
                              ('${context.translate(AppStrings.no_avilable_stores)}'),
                        ),
                ),
              ],
            );
          }),
    );
  }
}
