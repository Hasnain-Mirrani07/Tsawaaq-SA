import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/favorite/add_remove_favorite/manager.dart';
import 'package:tasawaaq/features/featured_products/featured_products_manager.dart';
import 'package:tasawaaq/features/featured_products/featured_products_response.dart';
import 'package:tasawaaq/features/filter/filter_manager.dart';
import 'package:tasawaaq/features/filter/filter_page.dart';
import 'package:tasawaaq/features/product_details/product_details_page.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/fav_guest_dialog/fav_guest_dialog.dart';
import 'package:tasawaaq/shared/not_available_widget/not_available_widget.dart';
import 'package:tasawaaq/shared/pagination_observer/pagination_observer.dart';
import 'package:tasawaaq/shared/product_item/product_item.dart';
import 'package:tasawaaq/shared/title_desc_btn/title_desc_btn.dart';
final filterManager = locator<FilterManager>();

class FeaturedProductsPage extends StatefulWidget {
  const FeaturedProductsPage({Key? key}) : super(key: key);

  @override
  _FeaturedProductsPageState createState() => _FeaturedProductsPageState();
}

class _FeaturedProductsPageState extends State<FeaturedProductsPage> {
  void initState() {
    locator<FeaturedProductsManager>().resetManager();
    locator<FilterManager>().resetFilter();
    locator<FeaturedProductsManager>().reCallManager();
    print("locator<FeaturedProductsManager>().data.${locator<FeaturedProductsManager>().data.length}");
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final featuredProductsManager = context.use<FeaturedProductsManager>();
    final prefs = context.use<PrefsService>();
    final addRemoveFavoriteManager = context.use<AddRemoveFavoriteManager>();


    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: MainAppBar(
          title: Text('${context.translate(AppStrings.Featured_Products)}'),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Observer<FeaturedProductsResponse>(
            manager: featuredProductsManager,
            onRetryClicked: () {
              featuredProductsManager.reCallManager();
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

                      featuredProductsManager.reCallManager();
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


                      featuredProductsManager.reCallManager();
                    },
                  ),
                );
              }
            },
            stream: featuredProductsManager.response$,
            onSuccess: (context, featuredProductsSnapshot) {
              featuredProductsManager.total = featuredProductsSnapshot.pagination!.total!;
              featuredProductsSnapshot.data?.products?.forEach((element) {
                if (featuredProductsManager.data.length < featuredProductsManager.total) {
                  if(!featuredProductsManager.dataIds.contains(element.id!)){
                    featuredProductsManager.data.add(element);
                    featuredProductsManager.dataIds.add(element.id!);
                  }
                }
              });
              return ListView(
                controller: featuredProductsManager.scrollController,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TitleDescBtn(
                    title: "${featuredProductsSnapshot.data!.title}",
                    desc:
                        "${featuredProductsSnapshot.data!.total} ${context.translate(AppStrings.PRODUCTS)}",
                    onFilterClickBtn: () {
                      Navigator.of(context).pushNamed(AppRouts.FILTER_PAGE,
                          arguments: FilterPageArgs(
                              categoryId: "",
                              storeId: "",
                              routeOfFilterPage: AppRouts.FeaturedProductsPage));
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  featuredProductsManager.data.isNotEmpty
                      ? Container(
                          child: GridView.builder(
                            shrinkWrap: true,
                            primary: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: featuredProductsManager.data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: .6,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {


                                  Navigator.of(context).pushNamed(
                                      AppRouts.ProductDetails,
                                      arguments: ProductDetailsArgs(
                                          storeId: featuredProductsManager.data[index].store!.id,
                                          productId: featuredProductsManager.data[index].id));
                                },
                                child: FadeInDown(
                                  key: Key("${featuredProductsManager.data[index].store!.id}"),
                                  child: ProductItem(
                                    keyId: "${featuredProductsManager.data[index].store!.id}",
                                    storeName: featuredProductsManager.data[index].store!.name,
                                    name: featuredProductsManager.data[index].name,
                                    price: "${featuredProductsManager.data[index].price} ${featuredProductsManager.data[index].currency}",
                                    isFavorite: featuredProductsManager.data[index].isLiked == 1,
                                    imgUrl: featuredProductsManager.data[index].image,
                                    dsc: "${featuredProductsManager.data[index].shortDesc}",
                                    // imageHeight: 100,
                                    itemBorderRadius: 15,
                                    itemElevation: 3,
                                    onClickFavoriteBtn: () {
                                      if(context.use<PrefsService>().userObj == null){
                                        favGuestDialog(context,);
                                      }else{

                                        addRemoveFavoriteManager
                                            .addRemoveFavorite(
                                            id: featuredProductsManager
                                                .data[index].id)
                                            .then((value) {
                                          if (value == ManagerState.SUCCESS) {
                                            featuredProductsManager
                                                .data[index].isLiked ==
                                                1
                                                ? featuredProductsManager
                                                .data[index].isLiked = 0
                                                : featuredProductsManager
                                                .data[index].isLiked = 1;
                                            featuredProductsManager.reCallManager();
                                          }
                                        });
                                      }

                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : NotAvailableComponent(
                          view: FaIcon(
                            FontAwesomeIcons.boxOpen,
                            color: AppStyle.blueTextButtonOpacity,
                            size: 100,
                          ),
                          title:
                              ('${context.translate(AppStrings.there_are_no_products)}'),
                        ),
                  StreamBuilder<PaginationState>(
                      initialData: PaginationState.IDLE,
                      stream: featuredProductsManager.paginationState$,
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
                                  await featuredProductsManager
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
