import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/about_mall_and_store/about_mall_store_page.dart';
import 'package:tasawaaq/features/favorite/add_remove_favorite/manager.dart';
import 'package:tasawaaq/features/filter/filter_manager.dart';
import 'package:tasawaaq/features/filter/filter_page.dart';
import 'package:tasawaaq/features/product_details/product_details_page.dart';
import 'package:tasawaaq/features/product_list/product_list_manager.dart';
import 'package:tasawaaq/features/product_list/product_list_response.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/fav_guest_dialog/fav_guest_dialog.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';
import 'package:tasawaaq/shared/not_available_widget/not_available_widget.dart';
import 'package:tasawaaq/shared/pagination_observer/pagination_observer.dart';
import 'package:tasawaaq/shared/product_item/product_item.dart';
import 'package:tasawaaq/shared/title_desc_btn/title_desc_btn.dart';

class ProductsListPageArgs {
  final int id;
  final String logo;
  final String name;
  final String storeId;
  final String cateId;

  ProductsListPageArgs(
      {required this.id,
      required this.logo,
      required this.name,
      required this.storeId,
      required this.cateId});
}

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({Key? key}) : super(key: key);

  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  openMapsSheet(context, Coords latLng, String title) async {
    try {
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: latLng,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    locator<ProductListManager>().resetManager();
    locator<FilterManager>().resetFilter();
    locator<ProductListManager>().reCallManager(
        // storeId: "${locator<ProductListManager>().storeId.value}",
        // categoryId: "${locator<ProductListManager>().cateId.value}",
        );
  }

  @override
  Widget build(BuildContext context) {
    final ProductsListPageArgs args =
        ModalRoute.of(context)!.settings.arguments! as ProductsListPageArgs;

    final addRemoveFavoriteManager = context.use<AddRemoveFavoriteManager>();

    final productListManager = context.use<ProductListManager>();
    final filterManager = context.use<FilterManager>();

    productListManager.storeId.sink.add("${args.storeId}");
    productListManager.cateId.sink.add("${args.cateId}");

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: MainAppBar(
          title: Text('${args.name}'),
          hasInfo: args.storeId.isEmpty ? false : true,
          onInfoClicked: () {
            Navigator.of(context).pushNamed(
              AppRouts.AboutMallsAndStorePage,
              arguments: AboutMallsAndStoreArgs(
                id: args.id,
                imageUrl: args.logo,
                isStore: true,
              ),
            );
          },
        ),
      ),
      body: Observer<ProductListResponse>(
          manager: productListManager,
          onRetryClicked: () {
            productListManager.reCallManager();
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
                    productListManager.reCallManager();
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
                    productListManager.reCallManager();
                  },
                ),
              );
            }
          },
          stream: productListManager.response$,
          onSuccess: (context, productListSnapshot) {
            productListManager.total = productListSnapshot.pagination!.total!;
            productListSnapshot.data?.products?.forEach((element) {
              if (productListManager.data.length < productListManager.total) {
                if (!productListManager.dataIds.contains(element.id!)) {
                  productListManager.data.add(element);
                  productListManager.dataIds.add(element.id!);
                }
              }
            });
            return productListSnapshot.data!.status == 1
                ? Container(
                    padding: EdgeInsets.only(
                        top: 30, right: 15, left: 15, bottom: 15),
                    child: ListView(
                      // padding: EdgeInsets.zero,
                      // primary: true,
                      controller: productListManager.scrollController,
                      children: [
                        if (args.storeId != "")
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (productListSnapshot.data!.store != null)
                                if (productListSnapshot
                                        .data!.store!.mall!.length ==
                                    1)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                            AppRouts.AboutMallsAndStorePage,
                                            arguments: AboutMallsAndStoreArgs(
                                              id: productListSnapshot
                                                  .data!.store!.mall![0].id,
                                              imageUrl: productListSnapshot
                                                  .data!.store!.mall![0].logo,
                                              isStore: false,
                                            ),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          child: NetworkAppImage(
                                            boxFit: BoxFit.fill,
                                            height: 85,
                                            width: 85,
                                            imageUrl:
                                                "${productListSnapshot.data!.store!.mall![0].logo}",
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "${productListSnapshot.data!.store!.mall![0].name}",
                                              style: AppFontStyle.greyTextH3,
                                            ),
                                            Text(
                                              "${productListSnapshot.data!.store!.mall![0].address}",
                                              style: AppFontStyle.blueTextH4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          openMapsSheet(
                                              context,
                                              Coords(
                                                  productListSnapshot.data!
                                                      .store!.mall![0].lat!,
                                                  productListSnapshot.data!
                                                      .store!.mall![0].lng!),
                                              '${productListSnapshot.data!.store!.mall![0].name!}');
                                        },
                                        child: SvgPicture.asset(
                                          AppAssets.direction_svg,
                                          height: 30.h,
                                          matchTextDirection: true,
                                        ),
                                      ),
                                    ],
                                  ),
                              if (productListSnapshot.data!.store != null)
                                if (productListSnapshot
                                        .data!.store!.mall!.length >
                                    1)
                                  Container(
                                    height: 110,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: productListSnapshot
                                            .data!.store!.mall!.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                AppRouts.AboutMallsAndStorePage,
                                                arguments:
                                                    AboutMallsAndStoreArgs(
                                                  id: productListSnapshot.data!
                                                      .store!.mall![index].id,
                                                  imageUrl: productListSnapshot
                                                      .data!
                                                      .store!
                                                      .mall![index]
                                                      .logo,
                                                  isStore: false,
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    child: NetworkAppImage(
                                                      boxFit: BoxFit.fill,
                                                      height: 75,
                                                      width: 75,
                                                      imageUrl:
                                                          "${productListSnapshot.data!.store!.mall![index].logo}",
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                      width: 75,
                                                      child: Text(
                                                        "${productListSnapshot.data!.store!.mall![index].name}",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                            ],
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            TitleDescBtn(
                              title: "${productListSnapshot.data!.title}",
                              desc:
                                  "${productListSnapshot.data!.total} ${context.translate(AppStrings.PRODUCTS)}",
                              isFilter: true,
                              onFilterClickBtn: () {
                                Navigator.of(context).pushNamed(
                                    AppRouts.FILTER_PAGE,
                                    arguments: FilterPageArgs(
                                        categoryId:
                                            productListManager.cateId.value,
                                        storeId: args.storeId,
                                        // max: "${productListSnapshot.data!.max}",
                                        // min: "${productListSnapshot.data!.min}",
                                        routeOfFilterPage:
                                            AppRouts.ProductsListPage));
                              },
                            ),
                            if (productListSnapshot.data!.brands!.isNotEmpty)
                              SizedBox(
                                height: 15,
                              ),
                            if (productListSnapshot.data!.brands!.isNotEmpty)
                              Container(
                                height: 55,
                                // padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: StreamBuilder<List<int>>(
                                      initialData: [],
                                      stream: filterManager
                                          .brandIndexSubject.stream,
                                      builder: (context, brandIndexSnapchat) {
                                        return Container(
                                          height: 50,
                                          child: Center(
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: productListSnapshot
                                                    .data!.brands!.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder:
                                                    (context, brandIndex) {
                                                  return Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                    ),
                                                    child: SizedBox(
                                                      height: 50,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          elevation: 0,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0),
                                                                  side:
                                                                      BorderSide(
                                                                    color: brandIndexSnapchat.data!.contains(productListSnapshot
                                                                            .data!
                                                                            .brands![
                                                                                brandIndex]
                                                                            .id)
                                                                        ? AppStyle
                                                                            .yellowButton
                                                                        : Colors
                                                                            .grey[300]!,
                                                                  )),
                                                          backgroundColor: brandIndexSnapchat
                                                                  .data!
                                                                  .contains(productListSnapshot
                                                                      .data!
                                                                      .brands![
                                                                          brandIndex]
                                                                      .id)
                                                              ? AppStyle
                                                                  .yellowButton
                                                              : Colors
                                                                  .grey[100],

                                                          shadowColor: brandIndexSnapchat
                                                                  .data!
                                                                  .contains(productListSnapshot
                                                                      .data!
                                                                      .brands![
                                                                          brandIndex]
                                                                      .id)
                                                              ? AppStyle
                                                                  .yellowButton
                                                              : Colors
                                                                  .grey[100],
                                                          // fixedSize: width == 0
                                                          //     ? null
                                                          //     : Size.fromWidth(width ?? MediaQuery.of(context).size.width),
                                                          // padding:
                                                          //     const EdgeInsets
                                                          //             .symmetric(
                                                          //         vertical: 12),
                                                        ),
                                                        child: Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: Text(
                                                            '${productListSnapshot.data!.brands![brandIndex].name}',
                                                            style: brandIndexSnapchat
                                                                    .data!
                                                                    .contains(productListSnapshot
                                                                        .data!
                                                                        .brands![
                                                                            brandIndex]
                                                                        .id)
                                                                ? AppFontStyle
                                                                    .blueTextH2
                                                                    .merge(
                                                                    TextStyle(
                                                                      // fontWeight:
                                                                      //     FontWeight
                                                                      //         .bold,
                                                                      fontSize:
                                                                          18.sp,
                                                                    ),
                                                                  )
                                                                : AppFontStyle
                                                                    .blueTextH2
                                                                    .merge(
                                                                    TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          18.sp,
                                                                    ),
                                                                  ),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          if (!filterManager
                                                              .brandsList
                                                              .contains(
                                                                  productListSnapshot
                                                                      .data!
                                                                      .brands![
                                                                          brandIndex]
                                                                      .id)) {
                                                            filterManager
                                                                .brandsList
                                                                .add(productListSnapshot
                                                                    .data!
                                                                    .brands![
                                                                        brandIndex]
                                                                    .id!);
                                                          } else {
                                                            filterManager
                                                                .brandsList
                                                                .remove(productListSnapshot
                                                                    .data!
                                                                    .brands![
                                                                        brandIndex]
                                                                    .id);
                                                          }
                                                          // filterManager.brandIndexSubject.sink.add(filterManager.brandsList);

                                                          filterManager
                                                              .brandIndexSubject
                                                              .sink
                                                              .add(locator<
                                                                      FilterManager>()
                                                                  .brandsList);

                                                          locator<ProductListManager>()
                                                              .resetManager();

                                                          locator<ProductListManager>()
                                                              .reCallManager(
                                                                  // storeId: "${locator<ProductListManager>().storeId.value}",
                                                                  // brandId: "${filterManager.brandIndexSubject.value.toString().replaceAll("[","").replaceAll("]","").replaceAll(" ","")}",
                                                                  );
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            SizedBox(
                              height: 25,
                            ),
                            productListManager.data.isNotEmpty
                                ? Container(
                                    child: GridView.builder(
                                      primary: true,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: productListManager.data.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: .6,
                                              crossAxisSpacing: 8,
                                              mainAxisSpacing: 8),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                AppRouts.ProductDetails,
                                                arguments: ProductDetailsArgs(
                                                    storeId: productListManager
                                                        .data[index].store!.id,
                                                    productId:
                                                        productListManager
                                                            .data[index].id));
                                          },
                                          child: FadeInDown(
                                            child: ProductItem(
                                              storeName: args.cateId == ""
                                                  ? ""
                                                  : productListManager
                                                      .data[index].store!.name,
                                              name: productListManager
                                                  .data[index].name,
                                              price:
                                                  "${productListManager.data[index].price} ${productListManager.data[index].currency}",
                                              isFavorite: productListManager
                                                          .data[index]
                                                          .isLiked ==
                                                      0
                                                  ? false
                                                  : true,
                                              imgUrl: productListManager
                                                  .data[index].image,
                                              dsc:
                                                  "${productListManager.data[index].shortDesc}",
                                              // imageHeight: 100,
                                              itemBorderRadius: 15,
                                              itemElevation: 3,
                                              onClickFavoriteBtn: () {
                                                if (context
                                                        .use<PrefsService>()
                                                        .userObj ==
                                                    null) {
                                                  favGuestDialog(
                                                    context,
                                                  );
                                                } else {
                                                  addRemoveFavoriteManager
                                                      .addRemoveFavorite(
                                                          id: productListManager
                                                              .data[index].id)
                                                      .then((value) {
                                                    if (value ==
                                                        ManagerState.SUCCESS) {
                                                      productListManager
                                                                  .data[index]
                                                                  .isLiked ==
                                                              1
                                                          ? productListManager
                                                              .data[index]
                                                              .isLiked = 0
                                                          : productListManager
                                                              .data[index]
                                                              .isLiked = 1;
                                                      productListManager
                                                          .reCallManager();
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
                                stream: productListManager.paginationState$,
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
                                            await productListManager
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
                        ),
                      ],
                    ),
                  )
                : NotAvailableComponent(
                    view: FaIcon(
                      FontAwesomeIcons.storeAltSlash,
                      color: AppStyle.blueTextButtonOpacity,
                      size: 100,
                    ),
                    title: locator<PrefsService>().appLanguage == "en"
                        ? "Store is unavailable right now"
                        : "المتجر غير متاح الآن");
          }),
    );
  }
}
