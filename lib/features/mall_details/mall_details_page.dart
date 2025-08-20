import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/about_mall_and_store/about_mall_store_page.dart';
import 'package:tasawaaq/features/filter/filter_manager.dart';
import 'package:tasawaaq/features/mall_details/mall_details_manager.dart';
import 'package:tasawaaq/features/mall_details/mall_details_response.dart';
import 'package:tasawaaq/features/product_list/product_list_manager.dart';
import 'package:tasawaaq/features/product_list/product_list_page.dart';
import 'package:tasawaaq/shared/appbar/appbar_logo.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';
import 'package:tasawaaq/shared/not_available_widget/not_available_widget.dart';

class MallDetailsArgs {
  final mallId;
  final mallImg;

  MallDetailsArgs({
    required this.mallId,
    required this.mallImg,
  });
}

// ignore: must_be_immutable
class MallDetailsPage extends StatefulWidget {
  MallDetailsPage({Key? key}) : super(key: key);

  @override
  _MallDetailsPageState createState() => _MallDetailsPageState();
}

class _MallDetailsPageState extends State<MallDetailsPage> {

  MallDetailsArgs? args;


  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      args = ModalRoute.of(context)!.settings.arguments as MallDetailsArgs;


      locator<MallDetailsManager>().selectedIndex.value = 0;
      if(args != null){
        context.use<MallDetailsManager>().execute(mallId: args!.mallId);
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    final mallDetailsManager = context.use<MallDetailsManager>();

    // final MallDetailsArgs args =
    //     ModalRoute.of(context)!.settings.arguments as MallDetailsArgs;

    if(args==null){
      final MallDetailsArgs args =
      ModalRoute.of(context)!.settings.arguments as MallDetailsArgs;
      context.use<MallDetailsManager>().execute(mallId: args!.mallId);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140),
        child: LogoAppBar(
          hasInfo: true,
          imageUrl: "${args!.mallImg}",
          onInfoClicked: () {
            Navigator.of(context).pushNamed(
              AppRouts.AboutMallsAndStorePage,
              arguments: AboutMallsAndStoreArgs(
                id: args!.mallId,
                imageUrl: args!.mallImg,
                isStore: false,
              ),
            );
          },
        ),
      ),
      body: Observer<MallResponse>(
          onRetryClicked: () {
            mallDetailsManager.selectedIndex.value = 0;
            mallDetailsManager.execute(mallId: args!.mallId);
          },
          manager: mallDetailsManager,
          stream: mallDetailsManager.mallDetails$,
          onSuccess: (context, mallSnapshot) {
            return mallSnapshot.data?.info!.status == 1
                ? Container(
                    padding: const EdgeInsets.only(top: 7),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                              // padding: EdgeInsets.only(top: 10),
                              width: MediaQuery.of(context).size.width,
                              child: ValueListenableBuilder<int>(
                                  valueListenable:
                                      mallDetailsManager.selectedIndex,
                                  builder: (context, value, _) {
                                    return Center(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: mallSnapshot
                                                  .data?.categories?.length ??
                                              0,
                                          itemBuilder: (_, index) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              child: SizedBox(
                                                height: 50,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                            side: BorderSide(
                                                              color: value ==
                                                                      index
                                                                  ? AppStyle
                                                                      .yellowButton
                                                                  : Colors.grey[
                                                                      300]!,
                                                            )),
                                                    backgroundColor: value ==
                                                            index
                                                        ? AppStyle.yellowButton
                                                        : Colors.grey[100],

                                                    shadowColor: value == index
                                                        ? AppStyle.yellowButton
                                                        : Colors.grey[100],
                                                    // fixedSize: width == 0
                                                    //     ? null
                                                    //     : Size.fromWidth(width ?? MediaQuery.of(context).size.width),
                                                    // padding: const EdgeInsets
                                                    //         .symmetric(
                                                    //     vertical: 12),
                                                  ),
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 12),
                                                    child: Text(
                                                      '${mallSnapshot.data?.categories?[index].name}',
                                                      style: value == index
                                                          ? AppFontStyle
                                                              .blueTextH2
                                                              .merge(
                                                              TextStyle(
                                                                // fontWeight: FontWeight.normal,
                                                                fontSize: 18.sp,
                                                              ),
                                                            )
                                                          : AppFontStyle
                                                              .blueTextH2
                                                              .merge(
                                                              TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18.sp,
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    mallDetailsManager
                                                        .selectedIndex
                                                        .value = index;
                                                    mallDetailsManager
                                                        .execute(
                                                            id: mallSnapshot
                                                                .data!
                                                                .categories![
                                                                    index]
                                                                .id!,
                                                            mallId:
                                                                args!.mallId);
                                                  },
                                                ),
                                              ),
                                            );
                                          }),
                                    );
                                  })),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          flex: 10,
                          child: mallSnapshot.data!.stores!.isNotEmpty
                              ? ListView.builder(
                                  itemCount:
                                      mallSnapshot.data?.stores?.length ?? 0,
                                  itemExtent: 180,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      width: double.infinity,
                                      child: InkWell(
                                        onTap: () {
                                          locator<FilterManager>()
                                              .cateIndexSubject
                                              .sink
                                              .add([]);
                                          locator<ProductListManager>()
                                              .cateId
                                              .sink
                                              .add("");
                                          locator<ProductListManager>()
                                              .storeId
                                              .sink
                                              .add(
                                                  "${mallSnapshot.data!.stores![index].id!}");
                                          Navigator.of(context).pushNamed(
                                            AppRouts.ProductsListPage,
                                            arguments: ProductsListPageArgs(
                                              cateId: "",
                                              id: mallSnapshot
                                                  .data!.stores![index].id!,
                                              logo: mallSnapshot
                                                  .data!.stores![index].logo!,
                                              name: mallSnapshot
                                                  .data!.stores![index].name!,
                                              storeId:
                                                  "${mallSnapshot.data!.stores![index].id!}",
                                            ),
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                width: double.infinity,
                                                child: Card(
                                                  // color: Colors.transparent,

                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: NetworkAppImage(
                                                      imageUrl:
                                                          "${mallSnapshot.data?.stores?[index].logo}",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, left: 8, right: 8),
                                              child: Text(
                                                  "${mallSnapshot.data?.stores?[index].name}",
                                                  style:
                                                      AppFontStyle.greyTextH3),
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
                    ),
                  )
                : NotAvailableComponent(
                    view: FaIcon(
                      FontAwesomeIcons.storeAltSlash,
                      color: AppStyle.blueTextButtonOpacity,
                      size: 100,
                    ),
                    title: locator<PrefsService>().appLanguage == "en"
                        ? "Mall is unavailable right now"
                        : "المركز التجاري غير متاح الآن");
          }),
    );
  }
}
