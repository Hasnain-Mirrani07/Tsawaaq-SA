import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/features/cart/cart_actions/cart_actions_request.dart';
import 'package:tasawaaq/features/cart/cart_actions/cart_managers/add_manager.dart';
import 'package:tasawaaq/features/favorite/add_remove_favorite/manager.dart';
import 'package:tasawaaq/features/product_details/product_details_manager.dart';
import 'package:tasawaaq/features/product_details/product_details_response.dart';
import 'package:tasawaaq/features/product_details/widgets/product_bottom_button_price.dart';
import 'package:tasawaaq/features/product_details/widgets/product_details_color.dart';
import 'package:tasawaaq/features/product_details/widgets/product_details_overview_widget.dart';
import 'package:tasawaaq/features/product_details/widgets/product_details_quantity.dart';
import 'package:tasawaaq/features/product_details/widgets/product_details_slider.dart';
import 'package:tasawaaq/features/product_details/widgets/title_proce_fav_icon.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/dialog/tasawaaq_dialog.dart';
import 'package:tasawaaq/shared/fav_guest_dialog/fav_guest_dialog.dart';

class ProductDetailsArgs {
  final int? productId;
  final int? storeId;

  ProductDetailsArgs({
    this.productId,
    this.storeId,
  });
}

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  ProductDetailsArgs? args;


  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {

    args = ModalRoute.of(context)!.settings.arguments as ProductDetailsArgs;

    locator<ProductDetailsManager>().quantityNotifier.value = 1;

    if(args != null){
      context.use<ProductDetailsManager>().execute(id: args!.productId!);
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final ProductDetailsArgs args =
    // ModalRoute.of(context)!.settings.arguments as ProductDetailsArgs;
    if(args==null){
      final ProductDetailsArgs args =
      ModalRoute.of(context)!.settings.arguments as ProductDetailsArgs;
      context.use<ProductDetailsManager>().execute(id: args!.productId!);
    }

    final prefs = context.use<PrefsService>();

    final productDetailsManager = context.use<ProductDetailsManager>();
    final addToCartManager = context.use<AddManager>();
    final toast = context.use<ToastTemplate>();
    final addRemoveFavoriteManager = context.use<AddRemoveFavoriteManager>();

    return WillPopScope(
      onWillPop: () async {
        productDetailsManager.colorNotifier.value = null;
        productDetailsManager.sizeNotifier.value = null;
        return true;
      },
      child: Scaffold(
          persistentFooterButtons: [
            Observer<ProductDetailsResponse>(
              onWaiting: (context) => Container(),
              onError: (context, error) => Container(),
              onRetryClicked: () {
                productDetailsManager.execute(id: args!.productId!);
              },
              manager: productDetailsManager,
              stream: productDetailsManager.product$,
              onSuccess: (context, productDetailsSnapshot) {

// if(productDetailsManager.sizeNotifier.value == null){
  locator<ProductDetailsManager>().priceSubject.sink.add(PricePbj(originalPrice: "${productDetailsSnapshot.data!.originalPrice} ${productDetailsSnapshot.data!.currency}",price:"${productDetailsSnapshot.data!.price} ${productDetailsSnapshot.data!.currency}"));
  locator<ProductDetailsManager>().maxForSizeSubject.sink.add(productDetailsSnapshot.data!.stocks!);
  print("this is button");
// }


                return ProductDetailsBottomButton(
                  currency: "${productDetailsSnapshot.data!.currency!}",
                  price: "${productDetailsSnapshot.data!.price!} ${productDetailsSnapshot.data?.currency}",
                  discountPrice: "${productDetailsSnapshot.data!.price!}".compareTo("${productDetailsSnapshot.data!.originalPrice!}") == 0 ? '' : "${productDetailsSnapshot.data!.originalPrice!} ${productDetailsSnapshot.data?.currency}",
                  onClickBtn: () {

                    if(productDetailsManager.maxForSizeSubject.value > 0){

                      if (productDetailsSnapshot.data!.options!.isNotEmpty) {
                        if (productDetailsManager.colorNotifier.value == null) {
                          toast.show(
                              '${context.translate(AppStrings.SELECT_COLOR)}');
                          return;
                        }
                        if (productDetailsSnapshot
                            .data!.options![0].sizes!.isNotEmpty) {
                          if (productDetailsManager.sizeNotifier.value == null) {
                            toast.show(
                                '${context.translate(AppStrings.SELECT_SIZE)}');
                            return;
                          }
                        }
                      }

                      /// TODO: Check Sizes
                      // if (productDetailsSnapshot.data!.options!.isNotEmpty) {
                      // if (productDetailsManager.sizeNotifier.value == null) {
                      //   toast
                      //       .show('${context.translate(AppStrings.SELECT_SIZE)}');
                      //   return;
                      // }
                      // }

                      addToCartManager.addToCart(
                        request: AddToCartRequest(
                          storeId: args!.storeId,
                          productId: args!.productId,
                          count: productDetailsManager.quantityNotifier.value,
                          colorId: productDetailsManager.colorNotifier.value?.id,
                          sizeId: productDetailsManager.sizeNotifier.value?.id,
                        ),
                      ).then((value) {
                        if(value == ManagerState.SUCCESS){
                          showDialog(
                              context: context,
                              builder: (_) {
                                return TasawaaqDialog(
                                    onCloseBtn: (){
                                      Navigator.of(context).pop();
                                    },
                                    titleTextAlign: TextAlign.start,
                                    contentTextAlign: TextAlign.start,
                                    confirmBtnTxt: '${context.translate(AppStrings.Go_Cart)}',
                                    columnCrossAxisAlignment: CrossAxisAlignment.start,
                                    onClickConfirmBtn: (){
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushNamed(AppRouts.CartPage);
                                    },
                                    title: '${context.translate(AppStrings.product_added)}',
                                    description:"${prefs.appLanguage == 'en' ? "continue shopping or go to cart":"مواصلة التسوق أو الذهاب إلى لسلة الشراء"}"

                                  // '${context.translate(AppStrings.continue_shopping_cart)}',
                                );
                              });
                        }


                      });

                      productDetailsManager.colorNotifier.value = null;
                      productDetailsManager.sizeNotifier.value = null;


                    }


                  },
                );
              },
            ),
          ],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: MainAppBar(
              hasRoundedEdge: false,
              onBackClicked: () {
                productDetailsManager.colorNotifier.value = null;
                productDetailsManager.sizeNotifier.value = null;
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Observer<ProductDetailsResponse>(
              onRetryClicked: () {
                context.use<ProductDetailsManager>().execute(id: args!.productId!);
              },
              manager: productDetailsManager,
              stream: productDetailsManager.product$,
              onSuccess: (_, productDetailsSnapshot) {
                print("this is button");
                return StreamBuilder<ManagerState>(
                    initialData: ManagerState.IDLE,
                    stream: addRemoveFavoriteManager.state$,
                    builder: (_,
                        AsyncSnapshot<ManagerState> favoriteStateSnapshot) {
                      return FormsStateHandling(
                        managerState: favoriteStateSnapshot.data,
                        errorMsg: addRemoveFavoriteManager.errorDescription,
                        onClickCloseErrorBtn: () {
                          addRemoveFavoriteManager.inState
                              .add(ManagerState.IDLE);
                        },
                        child: StreamBuilder<ManagerState>(
                            initialData: ManagerState.IDLE,
                            stream: addToCartManager.state$,
                            builder: (_,
                                AsyncSnapshot<ManagerState> stateSnapshot) {
                              return FormsStateHandling(
                                managerState: stateSnapshot.data,
                                errorMsg: addToCartManager.errorDescription,
                                onClickCloseErrorBtn: () {
                                  addToCartManager.inState
                                      .add(ManagerState.IDLE);
                                },
                                child: Container(
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                    children: [
                                      ProductDetailsSlider(
                                        sliderHeight: 240.h,
                                        sliderItems: productDetailsSnapshot
                                            .data?.imagesOfProduct,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          children: [
                                            StreamBuilder<PricePbj>(
                                                initialData: PricePbj(originalPrice:0 ,price: productDetailsSnapshot.data?.price),
                                                stream: context.use<ProductDetailsManager>().priceSubject.stream,
                                                builder: (_, priceSnapshot) {
                                                return TitlePriceFavIcon(
                                                  isFavorite: productDetailsSnapshot.data?.isLiked == 1,
                                                  name: "${productDetailsSnapshot.data?.name}",
                                                  price: "${priceSnapshot.data!.price} ${productDetailsSnapshot.data?.currency}".replaceAll("${productDetailsSnapshot.data?.currency} ${productDetailsSnapshot.data?.currency}", "${productDetailsSnapshot.data?.currency}"),
                                                  onFavoriteClickBtn: () {

                                                    if(context.use<PrefsService>().userObj == null){
                                                      favGuestDialog(context,);
                                                    }else{
                                                      addRemoveFavoriteManager
                                                          .addRemoveFavorite(id: productDetailsSnapshot.data?.id).then((value) {
                                                        if (value==ManagerState.SUCCESS) {
                                                          context.use<ProductDetailsManager>().execute(id: args!.productId!);
                                                        }
                                                      });
                                                    }


                                                  },
                                                );
                                              }
                                            ),
                                            Divider(
                                              height: 30,
                                            ),
                                            ProductDetailsColor(
                                              stock: productDetailsSnapshot.data?.stocks,
                                              currency: "${productDetailsSnapshot.data?.currency}" ,
                                              originalPrice:"${productDetailsSnapshot.data?.originalPrice}" ,
                                              price:"${productDetailsSnapshot.data?.price}" ,
                                              productColors:
                                                  productDetailsSnapshot.data?.options,
                                            ),
                                            // ProductDetailsSize(
                                            //   productSizes:
                                            //       productDetailsSnapshot.data?.sizes,
                                            // ),
                                            ProductDetailsQuantity(
                                              maxQuantity: int.parse("${productDetailsSnapshot.data?.stocks}"),
                                            ),
                                            ProductDetailsOverview(
                                              desc:
                                                  '${productDetailsSnapshot.data?.details}',
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    });
              })),
    );
  }
}


// void _continueCartShopping(BuildContext context,onTap) {
//   showDialog(
//       context: context,
//       builder: (_) {
//         return TasawaaqDialog(
//           onCloseBtn: (){
//             Navigator.of(context).pop();
//           },
//           titleTextAlign: TextAlign.center,
//           contentTextAlign: TextAlign.center,
//           confirmBtnTxt: '${context.translate(AppStrings.Go_Cart)}',
//           columnCrossAxisAlignment: CrossAxisAlignment.start,
//           onClickConfirmBtn: (){
//             onTap();
//           },
//           title: '${context.translate(AppStrings.product_added)}',
//           description:
//           '${context.translate(AppStrings.continue_shopping_cart)}',
//         );
//       });
// }