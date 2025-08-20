import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/filter/filter_manager.dart';
import 'package:tasawaaq/features/mall_details/mall_details_page.dart';
import 'package:tasawaaq/features/product_list/product_list_manager.dart';
import 'package:tasawaaq/features/product_list/product_list_page.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';

class MallsOrStoresWidget extends StatelessWidget {
  final String? title;
  final VoidCallback? onViewAllClickBtn;
  final VoidCallback? onSingleItemClickBtn;
  final double containerHeight;
  final double itemWidth;
  final List? sliderList;
  final bool isStore;

////////
  /// to do dont forget to modify the check on is empty or null
// (widget.sliderList == null ) => dont forget to modify this check
////////

  const MallsOrStoresWidget(
      {Key? key,
      this.title,
      this.onViewAllClickBtn,
      required this.isStore,
      this.onSingleItemClickBtn,
      this.containerHeight = 100,
      this.itemWidth = 100,
      this.sliderList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (sliderList != null)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$title',
                            style: AppFontStyle.blueTextH3,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            width: 55,
                            height: 1,
                            color: AppStyle.yellowButton,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: onViewAllClickBtn,
                        child: Text(
                          '${context.translate(AppStrings.VIEW_ALL_H)}',
                          style: AppFontStyle.yellowTextH4,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: containerHeight,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: sliderList!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 3),
                                child: InkWell(
                                  onTap: () {
                                    if (isStore) {
                                      locator<ProductListManager>().cateId.sink.add("");
                                      locator<FilterManager>().cateIndexSubject.sink.add([]);
                                      locator<ProductListManager>().storeId.sink.add("${sliderList?[index].id}");
                                      Navigator.of(context).pushNamed(
                                        AppRouts.ProductsListPage,
                                        arguments: ProductsListPageArgs(
                                          cateId: "",
                                          id: sliderList?[index].id,
                                          logo: sliderList?[index].logo,
                                            name: sliderList?[index].name,
                                          storeId: "${sliderList?[index].id}",
                                          // storeId: "${sliderList?[index].id}",

                                        ),
                                      );
                                    } else {
                                      Navigator.of(context).pushNamed(
                                        AppRouts.MallDetailsPage,
                                        arguments: MallDetailsArgs(
                                            mallId: sliderList?[index].id,
                                            mallImg: sliderList?[index].logo),
                                      );
                                    }
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: NetworkAppImage(
                                              boxFit: BoxFit.fill,
                                              height: containerHeight,
                                              width: itemWidth,
                                              imageUrl: isStore == true
                                                  ? "${sliderList![index].logo}"
                                                  : "${sliderList![index].logo}",
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 8, right: 8),
                                        child:
                                            Text("${sliderList![index].name}"),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  endIndent: 15,
                  indent: 15,
                ),
              ],
            )
          : Container(),
    );
  }
}
