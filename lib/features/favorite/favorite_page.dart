import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/favorite/add_remove_favorite/manager.dart';
import 'package:tasawaaq/features/favorite/favorite_manager.dart';
import 'package:tasawaaq/features/favorite/favorite_response.dart';
import 'package:tasawaaq/features/product_details/product_details_page.dart';
import 'package:tasawaaq/shared/dialog/tasawaaq_dialog.dart';
import 'package:tasawaaq/shared/fav_guest_dialog/fav_guest_dialog.dart';
import 'package:tasawaaq/shared/favorite_item/favorite_item_widget.dart';
import 'package:tasawaaq/shared/not_available_widget/not_available_widget.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.use<FavoriteManager>().execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteManager = context.use<FavoriteManager>();
    final addRemoveFavoriteManager = context.use<AddRemoveFavoriteManager>();

    return locator<PrefsService>().userObj != null
        ? Observer<FavoriteResponse>(
            onRetryClicked: () {
              favoriteManager.execute();
            },
            manager: favoriteManager,
            stream: favoriteManager.favorites$,
            onSuccess: (context, favoriteSnapshot) {
              var favoriteList = favoriteSnapshot.data;
              return favoriteList!.isEmpty
                  ? NotAvailableComponent(
                      view: FaIcon(
                        FontAwesomeIcons.boxOpen,
                        color: AppStyle.blueTextButtonOpacity,
                        size: 100,
                      ),
                      title:
                          ('${context.translate(AppStrings.wishlist_is_empty)}'),
                    )
                  : StreamBuilder<ManagerState>(
                      initialData: ManagerState.IDLE,
                      stream: addRemoveFavoriteManager.state$,
                      builder: (context,
                          AsyncSnapshot<ManagerState> favoriteStateSnapshot) {
                        return FormsStateHandling(
                          managerState: favoriteStateSnapshot.data,
                          errorMsg: addRemoveFavoriteManager.errorDescription,
                          onClickCloseErrorBtn: () {
                            addRemoveFavoriteManager.inState
                                .add(ManagerState.IDLE);
                          },
                          child: Container(
                            child: ListView.builder(
                                padding: EdgeInsets.only(
                                    top: 35, left: 0, right: 0, bottom: 0),
                                shrinkWrap: true,
                                itemCount: favoriteList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 95,
                                    margin: EdgeInsets.only(bottom: 20),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: InkWell(
                                      onTap: () {
                                        /// TODO: navigate to product details page
                                      },
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              AppRouts.ProductDetails,
                                              arguments: ProductDetailsArgs(
                                                  storeId: favoriteList[index]
                                                      .storeId,
                                                  productId:
                                                      favoriteList[index].id));
                                        },
                                        child: FavoriteItem(
                                          name: "${favoriteList[index].name}",
                                          isFavIcon: true,
                                          desc:
                                              "${favoriteList[index].price} ${favoriteList[index].currency}",
                                          imgUrl:
                                              "${favoriteList[index].image}",
                                          onClickFav: () {
                                            if (locator<PrefsService>()
                                                    .userObj !=
                                                null) {
                                              favDialog(
                                                  context,
                                                  addRemoveFavoriteManager,
                                                  favoriteList[index].id);
                                            } else {
                                              favGuestDialog(
                                                context,
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        );
                      });
            })
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NotAvailableComponent(
                  view: FaIcon(
                    FontAwesomeIcons.heartbeat,
                    color: AppStyle.blueTextButtonOpacity,
                    size: 100,
                  ),
                  title: ('${context.translate(AppStrings.need_register)}'),
                ),
                SlideInUp(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRouts.SignInPage);
                    },
                    child: Container(
                      height: 45,
                      width: 125.w,
                      color: AppStyle.appColor,
                      child: Center(
                        child: Text(
                          '${context.translate(AppStrings.LOG_In)}',
                          style: AppFontStyle.whiteTextH3,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}

void favDialog(BuildContext context, AddRemoveFavoriteManager manager, id) {
  final prefs = context.use<PrefsService>();

  showDialog(
    context: context,
    builder: (context) {
      return SlideInDown(
        child: TasawaaqDialog(
          title: prefs.userObj != null
              ? "${context.translate(AppStrings.Remove_Item)}"
              : "${context.translate(AppStrings.Login_First)}",
          confirmBtnTxt: prefs.userObj != null
              ? "${context.translate(AppStrings.Remove)}"
              : "${context.translate(AppStrings.LOG_In)}",
          onClickConfirmBtn: () {
            Navigator.of(context).pop();
            manager.addRemoveFavorite(id: id);
            // if (prefs.userObj != null) {
            //   print("prefs.userObj${prefs.userObj}");
            // } else {
            //   print("prefs.userObj${prefs.userObj}");
            // }
          },
          columnCrossAxisAlignment: CrossAxisAlignment.start,
          contentTextAlign: TextAlign.start,
          description: prefs.userObj != null
              ? "${context.translate(AppStrings.Are_remove_item_wishlist)}"
              : "${context.translate(AppStrings.Login_First_View_wishlist)}",
          onCloseBtn: () {
            Navigator.of(context).pop();
          },
          titleTextAlign: TextAlign.start,
        ),
      );
    },
  );
}
