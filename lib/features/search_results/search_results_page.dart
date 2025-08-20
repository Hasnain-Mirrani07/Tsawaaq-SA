import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/favorite/add_remove_favorite/manager.dart';
import 'package:tasawaaq/features/product_details/product_details_page.dart';
import 'package:tasawaaq/features/search/search_post/search_post_manager.dart';
import 'package:tasawaaq/features/search/search_post/search_post_response.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/fav_guest_dialog/fav_guest_dialog.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawaaq/shared/not_available_widget/not_available_widget.dart';
import 'package:tasawaaq/shared/pagination_observer/pagination_observer.dart';
import 'package:tasawaaq/shared/product_item/product_item.dart';

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({Key? key}) : super(key: key);

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {


  void initState() {
    super.initState();
    locator<SearchManager>().reCallManager(
    );

  }

  @override
  Widget build(BuildContext context) {


    final searchManager = context.use<SearchManager>();
    final addRemoveFavoriteManager = context.use<AddRemoveFavoriteManager>();


    return
        WillPopScope(
          onWillPop: () async {
            searchManager.resetManager();
            return true;
          },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: MainAppBar(
            title: Text('${context.translate(AppStrings.SEARCH_PRODUCTS)}'),
            onBackClicked: (){
              searchManager.resetManager();
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Observer<SearchPostResponse>(
            manager: searchManager,
            onRetryClicked: () {
              searchManager.reCallManager();
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
                      searchManager.reCallManager();
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
                      searchManager.reCallManager();
                    },
                  ),
                );
              }
            },
            stream: searchManager.response$,
            onSuccess: (context, productListSnapshot) {
              searchManager.total = productListSnapshot.pagination!.total!;
              productListSnapshot.data?.products?.forEach((element) {
                if (searchManager.data.length < searchManager.total) {
                  if(!searchManager.dataIds.contains(element.id!)){
                    searchManager.data.add(element);
                    searchManager.dataIds.add(element.id!);
                  }
                }
              });

            return  Container(
              padding: EdgeInsets.all(15),
              child:  ListView(
                controller: searchManager.scrollController,
                children: [
               searchManager.data.isNotEmpty ?
               GridView.builder(
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 itemCount: searchManager.data.length,
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                               storeId: searchManager
                                   .data[index].store!.id,
                               productId: searchManager
                                   .data[index].id));
                     },
                     child: ProductItem(
                       // storeName:"${searchManager.data[index].store!.id} //${index}",

                       storeName:searchManager.data[index].store!.name,
                       name: searchManager.data[index].name,
                       price:
                       "${searchManager.data[index].price} ${searchManager.data[index].currency}",
                       isFavorite: searchManager
                           .data[index].isLiked ==
                           0
                           ? false
                           : true,
                       imgUrl:
                       searchManager.data[index].image,
                       dsc:
                       "${searchManager.data[index].shortDesc}",
                       // imageHeight: 100,
                       itemBorderRadius: 15,
                       itemElevation: 3,
                       onClickFavoriteBtn: () {
                         if(context.use<PrefsService>().userObj == null){
                           favGuestDialog(context);
                         }else{
                           addRemoveFavoriteManager
                               .addRemoveFavorite(
                               id: searchManager
                                   .data[index].id)
                               .then((value) {
                             if (value == ManagerState.SUCCESS) {
                               searchManager
                                   .data[index].isLiked ==
                                   1
                                   ? searchManager
                                   .data[index].isLiked = 0
                                   : searchManager
                                   .data[index].isLiked = 1;
                               searchManager.reCallManager(
                                   // type: locator<SearchManager>().typeSubject.toString().replaceAll("[", "").replaceAll("]", ""),
                                   // keyWord: "${args.keyWord}"
                               );
                             }
                           });
                         }


                       },
                     ),
                   );
                 },
               )
                   :Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .2,
                          ),
                          NotAvailableComponent(
                 view: FaIcon(
                   FontAwesomeIcons.searchMinus,
                   color: AppStyle.blueTextButtonOpacity,
                   size: 100,
                 ),
              title:
              ('${context.translate(AppStrings.there_are_no_products)}'),
              ),
                        ],
                      ),
                  StreamBuilder<PaginationState>(
                      initialData: PaginationState.IDLE,
                      stream: searchManager.paginationState$,
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
                                  await searchManager
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

            );
          }
        ),
      ),
    );
  }
}


