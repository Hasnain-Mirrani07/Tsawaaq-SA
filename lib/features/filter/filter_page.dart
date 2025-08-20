import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/featured_products/featured_products_manager.dart';
import 'package:tasawaaq/features/filter/CopyOfAnimatedTile.dart';
import 'package:tasawaaq/features/filter/filter_manager.dart';
import 'package:tasawaaq/features/filter/filter_response.dart';
import 'package:tasawaaq/features/product_list/product_list_manager.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/convert_to_flutter_hex/convert_to_flutter_hex.dart';
import 'package:tasawaaq/shared/curved_container/curved_container.dart';
import 'package:tasawaaq/shared/custom_button/custom_button.dart';

class FilterPageArgs {
  final String? storeId, categoryId;
  final String? routeOfFilterPage;
  // final String min,max;
  FilterPageArgs({
    this.storeId = "",
    this.categoryId = "",
    @required this.routeOfFilterPage,
    // required this.max,
    // required this.min
  });
}

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  FilterPageArgs? args;

  @override
  void initState() {
    super.initState();
    locator<FilterManager>().resetFilter();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      args = ModalRoute.of(context)!.settings.arguments as FilterPageArgs;

      if (args != null) {
        context
            .use<FilterManager>()
            .execute(storeId: args!.storeId, categoryId: args!.categoryId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filterManager = context.use<FilterManager>();
    final featuredProductsManager = context.use<FeaturedProductsManager>();
    final productListManager = context.use<ProductListManager>();

    if (args == null) {
      args = ModalRoute.of(context)!.settings.arguments as FilterPageArgs;
      filterManager.execute(
          storeId: args!.storeId, categoryId: args!.categoryId);
    }

    // print("double.parse(${double.parse(args.min)})${double.parse("${args.max}")}");

    List<Sort> sorts = [
      Sort(sortId: "newest", sortName: context.translate(AppStrings.NEWEST)),
      Sort(sortId: "oldest", sortName: context.translate(AppStrings.OLDEST)),
      Sort(
          sortId: "price_high",
          sortName: context.translate(AppStrings.HIGH_TO_LOW)),
      Sort(
          sortId: "price_low",
          sortName: context.translate(AppStrings.LOW_TO_HIGH)),
    ];

    return WillPopScope(
      onWillPop: () async {
        locator<FilterManager>().resetFilter();
        Navigator.of(context).pop();
        print("filter cleared");

        return true;
      },
      child: Scaffold(
        persistentFooterButtons: [
          CustomButton(
            txt: "${context.translate(AppStrings.Show_Results)}",
            onClickBtn: () {
              // String sort = filterManager.sortIndexNotifier().value;
              // String typeId = filterManager.typeIndexSubject.value.toString().replaceAll("[","").replaceAll("]","");
              // String brandId = filterManager.brandIndexSubject.value.toString().replaceAll("[","").replaceAll("]","");
              // String cateId = filterManager.cateIndexSubject.value.toString().replaceAll("[","").replaceAll("]","");
              // String sizeId = filterManager.sizeIndexSubject.value.toString().replaceAll("[","").replaceAll("]","");
              // String colorId = filterManager.colorIndexSubject.value.toString().replaceAll("[","").replaceAll("]","");
              // String priceFrom = filterManager.priceRangeSubject.hasValue ? filterManager.priceRangeSubject.value.start.round().toString() : "";
              // String priceTo = filterManager.priceRangeSubject.hasValue ? filterManager.priceRangeSubject.value.end.round().toString():"";

              if (args!.routeOfFilterPage == AppRouts.FeaturedProductsPage) {
                featuredProductsManager.resetManager();
                featuredProductsManager.reCallManager();
              } else {
                productListManager.resetManager();
                productListManager.reCallManager();
              }
              Navigator.of(context).pop();
            },
          )
        ],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: MainAppBar(
            hasCart: false,
            title: Text("${context.translate(AppStrings.FILTER)}"),
            onBackClicked: () {
              locator<FilterManager>().resetFilter();
              Navigator.of(context).pop();
              print("filter cleared");
            },
          ),
        ),
        body: Observer<FilterResponse>(
            onRetryClicked: () {
              filterManager.execute(
                  storeId: args!.storeId, categoryId: args!.categoryId);
            },
            manager: filterManager,
            stream: filterManager.filter$,
            onSuccess: (context, filterSnapshot) {
              filterManager.startPriceSubject.sink
                  .add("${filterSnapshot.data!.min}");
              filterManager.endPriceSubject.sink
                  .add("${filterSnapshot.data!.max}");

              double min = double.parse("${filterSnapshot.data!.min}");
              double max = double.parse("${filterSnapshot.data!.max}");
              filterManager.priceRangeSubject.sink.add(RangeValues(min, max));

              return ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  ValueListenableBuilder<String>(
                      valueListenable: filterManager.sortIndexNotifier(),
                      builder: (context, value, _) {
                        return CopyOfAnimatedTile(
                            headerText:
                                "${context.translate(AppStrings.SORT_BY)}",
                            body: sorts
                                .map((e) => InkWell(
                                      onTap: () {
                                        if (filterManager.sortIndex ==
                                            "${e.sortId}") {
                                          filterManager.sortIndex = "";
                                        } else {
                                          filterManager.sortIndex =
                                              "${e.sortId}";
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${e.sortName}",
                                              style: TextStyle(
                                                color: e.sortId == value
                                                    ? AppStyle.appBarColor
                                                    : Colors.black,
                                              ),
                                            ),
                                            Container(
                                                height: 20,
                                                width: 20,
                                                padding:
                                                    const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  // color: AppStyle.appBarColor,
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: e.sortId == value
                                                          ? AppStyle.appBarColor
                                                          : Colors.black26,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(90),
                                                  ),
                                                ),
                                                child: Container(
                                                    height: 2,
                                                    width: 2,
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                        color: e.sortId == value
                                                            ? AppStyle
                                                                .appBarColor
                                                            : Colors
                                                                .transparent,
                                                        border: Border.all(
                                                          color: e
                                                                      .sortId ==
                                                                  value
                                                              ? AppStyle
                                                                  .lightGrey
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(100),
                                                        )))),
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList());
                      }),
                  if (filterSnapshot.data!.brands!.isNotEmpty)
                    Column(
                      children: [
                        Divider(
                          indent: 15,
                          endIndent: 15,
                        ),
                        CopyOfAnimatedTile(
                            headerText:
                                "${context.translate(AppStrings.BRAND)}",
                            isColumn: false,
                            body: [
                              Container(
                                  height: 60,
                                  child: StreamBuilder<List<int>>(
                                      initialData: [],
                                      stream: filterManager
                                          .brandIndexSubject.stream,
                                      builder: (context, brandIndexSnapshot) {
                                        return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: filterSnapshot
                                                .data!.brands!.length,
                                            itemBuilder: (context, brandIndex) {
                                              return Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 4),
                                                child: SizedBox(
                                                  height: 50,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16.0),
                                                              side: BorderSide(
                                                                color: brandIndexSnapshot
                                                                        .data!
                                                                        .contains(filterSnapshot
                                                                            .data!
                                                                            .brands![
                                                                                brandIndex]
                                                                            .id)
                                                                    ? AppStyle
                                                                        .blueTextButton
                                                                    : Colors.grey[
                                                                        300]!,
                                                              )),
                                                      backgroundColor: brandIndexSnapshot
                                                              .data!
                                                              .contains(
                                                                  filterSnapshot
                                                                      .data!
                                                                      .brands![
                                                                          brandIndex]
                                                                      .id)
                                                          ? AppStyle
                                                              .blueTextButton
                                                          : Colors.grey[100],

                                                      shadowColor: brandIndexSnapshot
                                                              .data!
                                                              .contains(
                                                                  filterSnapshot
                                                                      .data!
                                                                      .brands![
                                                                          brandIndex]
                                                                      .id)
                                                          ? AppStyle
                                                              .blueTextButton
                                                          : Colors.grey[100],
                                                      // fixedSize: width == 0
                                                      //     ? null
                                                      //     : Size.fromWidth(width ?? MediaQuery.of(context).size.width),
                                                      // padding: const EdgeInsets
                                                      //         .symmetric(
                                                      //     vertical: 12),
                                                    ),
                                                    onPressed: () {
                                                      if (!filterManager
                                                          .brandsList
                                                          .contains(
                                                              filterSnapshot
                                                                  .data!
                                                                  .brands![
                                                                      brandIndex]
                                                                  .id)) {
                                                        filterManager.brandsList
                                                            .add(filterSnapshot
                                                                .data!
                                                                .brands![
                                                                    brandIndex]
                                                                .id!);
                                                      } else {
                                                        filterManager.brandsList
                                                            .remove(filterSnapshot
                                                                .data!
                                                                .brands![
                                                                    brandIndex]
                                                                .id);
                                                      }

                                                      filterManager
                                                          .brandIndexSubject
                                                          .sink
                                                          .add(filterManager
                                                              .brandsList);
                                                    },
                                                    child: Text(
                                                      '${filterSnapshot.data!.brands![brandIndex].name}',
                                                      style: brandIndexSnapshot
                                                              .data!
                                                              .contains(
                                                                  filterSnapshot
                                                                      .data!
                                                                      .brands![
                                                                          brandIndex]
                                                                      .id)
                                                          ? AppFontStyle
                                                              .blueTextH2
                                                              .merge(
                                                              TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      16.sp,
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          : AppFontStyle
                                                              .blueTextH2
                                                              .merge(
                                                              TextStyle(
                                                                color: AppStyle
                                                                    .blueTextButton,
                                                                fontSize: 16.sp,
                                                              ),
                                                            ),
                                                    ),
                                                    // onPressed: onClick,
                                                  ),
                                                ),
                                              );
                                            });
                                      })),
                            ]),
                      ],
                    ),
                  if (filterSnapshot.data!.categories!.isNotEmpty)
                    Column(
                      children: [
                        Divider(
                          indent: 15,
                          endIndent: 15,
                        ),
                        CopyOfAnimatedTile(
                            headerText:
                                "${context.translate(AppStrings.Category)}",
                            isColumn: false,
                            body: [
                              Container(
                                  height: 60,
                                  child: StreamBuilder<List<int>>(
                                      initialData: [],
                                      stream:
                                          filterManager.cateIndexSubject.stream,
                                      builder: (context, cateIndexSnapshot) {
                                        return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: filterSnapshot
                                                .data!.categories!.length,
                                            itemBuilder: (context, catIndex) {
                                              return Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 4),
                                                child: SizedBox(
                                                  height: 50,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      // elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16.0),
                                                              side: BorderSide(
                                                                color: cateIndexSnapshot
                                                                        .data!
                                                                        .contains(filterSnapshot
                                                                            .data!
                                                                            .categories![
                                                                                catIndex]
                                                                            .id)
                                                                    ? AppStyle
                                                                        .blueTextButton
                                                                    : Colors.grey[
                                                                        300]!,
                                                              )),
                                                      backgroundColor: cateIndexSnapshot
                                                              .data!
                                                              .contains(filterSnapshot
                                                                  .data!
                                                                  .categories![
                                                                      catIndex]
                                                                  .id)
                                                          ? AppStyle
                                                              .blueTextButton
                                                          : Colors.grey[100],

                                                      shadowColor: cateIndexSnapshot
                                                              .data!
                                                              .contains(filterSnapshot
                                                                  .data!
                                                                  .categories![
                                                                      catIndex]
                                                                  .id)
                                                          ? AppStyle
                                                              .blueTextButton
                                                          : Colors.grey[100],
                                                      // fixedSize: width == 0
                                                      //     ? null
                                                      //     : Size.fromWidth(width ?? MediaQuery.of(context).size.width),
                                                      // padding: const EdgeInsets
                                                      //         .symmetric(
                                                      //     vertical: 12),
                                                    ),
                                                    onPressed: () {
                                                      if (!filterManager
                                                          .cateList
                                                          .contains(
                                                              filterSnapshot
                                                                  .data!
                                                                  .categories![
                                                                      catIndex]
                                                                  .id)) {
                                                        filterManager.cateList
                                                            .add(filterSnapshot
                                                                .data!
                                                                .categories![
                                                                    catIndex]
                                                                .id!);
                                                      } else {
                                                        filterManager.cateList
                                                            .remove(filterSnapshot
                                                                .data!
                                                                .categories![
                                                                    catIndex]
                                                                .id);
                                                      }

                                                      filterManager
                                                          .cateIndexSubject.sink
                                                          .add(filterManager
                                                              .cateList);
                                                    },
                                                    child: Text(
                                                      '${filterSnapshot.data!.categories![catIndex].name}',
                                                      style: cateIndexSnapshot
                                                              .data!
                                                              .contains(filterSnapshot
                                                                  .data!
                                                                  .categories![
                                                                      catIndex]
                                                                  .id)
                                                          ? AppFontStyle
                                                              .blueTextH2
                                                              .merge(
                                                              TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      16.sp,
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          : AppFontStyle
                                                              .blueTextH2
                                                              .merge(
                                                              TextStyle(
                                                                color: AppStyle
                                                                    .blueTextButton,
                                                                fontSize: 16.sp,
                                                              ),
                                                            ),
                                                    ),
                                                    // onPressed: onClick,
                                                  ),
                                                ),
                                              );
                                            });
                                      })),
                            ]),
                      ],
                    ),
                  if (filterSnapshot.data!.types!.isNotEmpty)
                    Column(
                      children: [
                        Divider(
                          indent: 15,
                          endIndent: 15,
                        ),
                        CopyOfAnimatedTile(
                            headerText: "${context.translate(AppStrings.Type)}",
                            isColumn: false,
                            body: [
                              Container(
                                  height: 60,
                                  child: StreamBuilder<List<int>>(
                                      initialData: [],
                                      stream:
                                          filterManager.typeIndexSubject.stream,
                                      builder: (context, typeIndexSnapshot) {
                                        return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: filterSnapshot
                                                .data!.types!.length,
                                            itemBuilder: (context, typeIndex) {
                                              Types type = filterSnapshot
                                                  .data!.types![typeIndex];
                                              return Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 4),
                                                child: SizedBox(
                                                  height: 50,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      // elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16.0),
                                                              side: BorderSide(
                                                                color: typeIndexSnapshot
                                                                        .data!
                                                                        .contains(type
                                                                            .id)
                                                                    ? AppStyle
                                                                        .blueTextButton
                                                                    : Colors.grey[
                                                                        300]!,
                                                              )),
                                                      backgroundColor:
                                                          typeIndexSnapshot
                                                                  .data!
                                                                  .contains(
                                                                      type.id)
                                                              ? AppStyle
                                                                  .blueTextButton
                                                              : Colors
                                                                  .grey[100],

                                                      shadowColor:
                                                          typeIndexSnapshot
                                                                  .data!
                                                                  .contains(
                                                                      type.id)
                                                              ? AppStyle
                                                                  .blueTextButton
                                                              : Colors
                                                                  .grey[100],
                                                      // fixedSize: width == 0
                                                      //     ? null
                                                      //     : Size.fromWidth(width ?? MediaQuery.of(context).size.width),
                                                      // padding: const EdgeInsets
                                                      //         .symmetric(
                                                      //     vertical: 12),
                                                    ),
                                                    onPressed: () {
                                                      if (!filterManager
                                                          .typeList
                                                          .contains(type.id)) {
                                                        filterManager.typeList
                                                            .add(type.id!);
                                                      } else {
                                                        filterManager.typeList
                                                            .remove(type.id);
                                                      }

                                                      filterManager
                                                          .typeIndexSubject.sink
                                                          .add(filterManager
                                                              .typeList);
                                                    },
                                                    child: Text(
                                                      '${type.name}',
                                                      style: typeIndexSnapshot
                                                              .data!
                                                              .contains(type.id)
                                                          ? AppFontStyle
                                                              .blueTextH2
                                                              .merge(
                                                              TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      16.sp,
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          : AppFontStyle
                                                              .blueTextH2
                                                              .merge(
                                                              TextStyle(
                                                                color: AppStyle
                                                                    .blueTextButton,
                                                                fontSize: 16.sp,
                                                              ),
                                                            ),
                                                    ),
                                                    // onPressed: onClick,
                                                  ),
                                                ),
                                              );
                                            });
                                      })),
                            ]),
                      ],
                    ),
                  if (filterSnapshot.data!.sizes!.isNotEmpty)
                    Column(
                      children: [
                        Divider(
                          indent: 15,
                          endIndent: 15,
                        ),
                        CopyOfAnimatedTile(
                            headerText: "${context.translate(AppStrings.Size)}",
                            isColumn: false,
                            body: [
                              Container(
                                  height: 60,
                                  child: StreamBuilder<List<int>>(
                                      initialData: [],
                                      stream:
                                          filterManager.sizeIndexSubject.stream,
                                      builder: (context, sizeIndexSnapshot) {
                                        return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: filterSnapshot
                                                .data!.sizes!.length,
                                            itemBuilder: (context, typeIndex) {
                                              Sizes size = filterSnapshot
                                                  .data!.sizes![typeIndex];
                                              return Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 4),
                                                child: SizedBox(
                                                  height: 50,
                                                  child: InkWell(
                                                    // color:sizeIndexSnapshot.data!.contains(size.id)
                                                    //     ? AppStyle.blueTextButton
                                                    //     : Colors.grey[100],
                                                    // shape: RoundedRectangleBorder(
                                                    //   borderRadius: BorderRadius.circular(10.0),
                                                    //   side: BorderSide(
                                                    //     color: sizeIndexSnapshot.data!.contains(size.id)
                                                    //         ? AppStyle.blueTextButton
                                                    //         : Colors.grey[300]!,
                                                    //   ),
                                                    // ),
                                                    onTap: () {
                                                      if (!filterManager
                                                          .sizeList
                                                          .contains(size.id)) {
                                                        filterManager.sizeList
                                                            .add(size.id!);
                                                      } else {
                                                        filterManager.sizeList
                                                            .remove(size.id);
                                                      }

                                                      filterManager
                                                          .sizeIndexSubject.sink
                                                          .add(filterManager
                                                              .sizeList);
                                                    },
                                                    child: CurvedContainer(
                                                      borderRadius: 10,
                                                      containerColor:
                                                          sizeIndexSnapshot
                                                                  .data!
                                                                  .contains(
                                                                      size.id)
                                                              ? AppStyle
                                                                  .blueTextButton
                                                              : Colors
                                                                  .grey[100]!,
                                                      widget: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Text(
                                                            '${size.name}',
                                                            style: sizeIndexSnapshot
                                                                    .data!
                                                                    .contains(
                                                                        size.id)
                                                                ? AppFontStyle
                                                                    .blueTextH2
                                                                    .merge(
                                                                    TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize: 16
                                                                            .sp,
                                                                        color: Colors
                                                                            .white),
                                                                  )
                                                                : AppFontStyle
                                                                    .blueTextH2
                                                                    .merge(
                                                                    TextStyle(
                                                                      color: AppStyle
                                                                          .blueTextButton,
                                                                      fontSize:
                                                                          16.sp,
                                                                    ),
                                                                  ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // onPressed: onClick,
                                                  ),
                                                ),
                                              );
                                            });
                                      })),
                            ]),
                      ],
                    ),
                  Divider(
                    indent: 15,
                    endIndent: 15,
                  ),
                  CopyOfAnimatedTile(
                      headerText:
                          '${context.translate(AppStrings.Price_Range)}',
                      body: <Widget>[
                        StreamBuilder<RangeValues>(
                            initialData: RangeValues(min, max),
                            stream: filterManager.priceRangeSubject.stream,
                            builder: (context, priceRangeSnapshot) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${priceRangeSnapshot.data!.start.round()} ${filterManager.currency} ${context.translate('to_str')} ${priceRangeSnapshot.data!.end.round()} ${filterManager.currency}',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    child: SliderTheme(
                                      data: SliderThemeData(
                                        showValueIndicator:
                                            ShowValueIndicator.always,
                                      ),
                                      child: RangeSlider(
                                          // divisions: 500,
                                          activeColor: Colors.grey[300],
                                          inactiveColor: Colors.grey[200],
                                          min: min,
                                          max: max,
                                          labels: RangeLabels(
                                              '${priceRangeSnapshot.data!.start.round()}',
                                              '${priceRangeSnapshot.data!.end.round()}'),
                                          values: priceRangeSnapshot.data!,
                                          onChanged: (value) {
                                            filterManager.priceRangeSubject.sink
                                                .add(value);
                                            filterManager.startPriceSubject.sink
                                                .add("${value.start.round()}");
                                            filterManager.endPriceSubject.sink
                                                .add("${value.end.round()}");
                                          }),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ]),
                  if (filterSnapshot.data!.productColors!.isNotEmpty)
                    Column(
                      children: [
                        Divider(
                          indent: 15,
                          endIndent: 15,
                        ),
                        CopyOfAnimatedTile(
                            headerText:
                                "${context.translate(AppStrings.Color)}",
                            isColumn: false,
                            body: [
                              Container(
                                  height: 70,
                                  child: StreamBuilder<List<int>>(
                                      initialData: [],
                                      stream: filterManager
                                          .colorIndexSubject.stream,
                                      builder: (context, colorIndexSnapshot) {
                                        return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: filterSnapshot
                                                .data!.productColors!.length,
                                            itemBuilder: (context, typeIndex) {
                                              ProductColors productColor =
                                                  filterSnapshot
                                                          .data!.productColors![
                                                      typeIndex];
                                              return Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 4),
                                                child: SizedBox(
                                                  height: 50,
                                                  child: InkWell(
                                                    onTap: () {
                                                      if (!filterManager
                                                          .colorList
                                                          .contains(productColor
                                                              .id)) {
                                                        filterManager.colorList
                                                            .add(productColor
                                                                .id!);
                                                      } else {
                                                        filterManager.colorList
                                                            .remove(productColor
                                                                .id);
                                                      }

                                                      filterManager
                                                          .colorIndexSubject
                                                          .sink
                                                          .add(filterManager
                                                              .colorList);
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 50,
                                                          width: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                preparedColor(
                                                                    "${productColor.hexa}")),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            border: Border.all(
                                                              width: 10,
                                                              color: colorIndexSnapshot
                                                                      .data!
                                                                      .contains(
                                                                          productColor
                                                                              .id)
                                                                  ? AppStyle
                                                                      .appColor
                                                                  : Color(preparedColor(
                                                                      "${productColor.hexa}")),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          height: 3,
                                                          width: 30,
                                                          color: colorIndexSnapshot
                                                                  .data!
                                                                  .contains(
                                                                      productColor
                                                                          .id)
                                                              ? Color(preparedColor(
                                                                  "${productColor.hexa}"))
                                                              : Colors
                                                                  .transparent,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                      })),
                            ]),
                      ],
                    ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              );
            }),
      ),
    );
  }
}

class Sort {
  String? sortId, sortName;
  Sort({this.sortId, this.sortName});
}
