import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/cart/cart_actions/cart_actions_request.dart';
import 'package:tasawaaq/features/cart/cart_actions/cart_actions_response.dart';
import 'package:tasawaaq/features/cart/cart_actions/cart_managers/add_manager.dart';
import 'package:tasawaaq/features/cart/cart_actions/cart_managers/cart_list_manager.dart';
import 'package:tasawaaq/features/cart/cart_actions/cart_managers/remove_manager.dart';
import 'package:tasawaaq/features/cart/widgets/cart_item_widget.dart';
import 'package:tasawaaq/features/cart/widgets/statistics_item_widget.dart';
import 'package:tasawaaq/features/favorite/add_remove_favorite/manager.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/continue_guest_register_dialog/continue_guest_register_dialog.dart';
import 'package:tasawaaq/shared/custom_button/custom_button.dart';
import 'package:tasawaaq/shared/dialog/tasawaaq_dialog.dart';
import 'package:tasawaaq/shared/fav_guest_dialog/fav_guest_dialog.dart';
import 'package:tasawaaq/shared/not_available_widget/not_available_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.use<CartListManager>().execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartListManager = context.use<CartListManager>();
    final removeFromCartManager = context.use<RemoveManager>();
    final addToCartManager = context.use<AddManager>();
    final addRemoveFavoriteManager = context.use<AddRemoveFavoriteManager>();
    final toast = context.use<ToastTemplate>();
    final prefs = locator<PrefsService>();

    return Scaffold(
      backgroundColor: Colors.white,
      persistentFooterButtons: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Observer<CartActionsResponse>(
              onWaiting: (context) => Container(),
              onError: (context, error) => Container(),
              onRetryClicked: () {
                // cartListManager.execute();
              },
              manager: cartListManager,
              stream: cartListManager.cartList$,
              onSuccess: (context, cartListSnapshot) {
                var cartList = cartListSnapshot.data?.cart;
                return CustomButton(
                  onClickBtn: () {
                    if (cartList!.isNotEmpty) {
                      if (prefs.userObj == null) {
                        continueGuestRegister(context, () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed(AppRouts.CheckOutPage);
                        });
                      } else {
                        Navigator.of(context).pushNamed(AppRouts.CheckOutPage);
                      }
                    } else {
                      toast.show(
                          '${context.translate(AppStrings.cart_is_empty)}');
                    }
                  },
                  txt: '${context.translate(AppStrings.PROCEED_TO_CHECKOUT)}',
                  btnWidth: double.infinity,
                  btnColor: AppStyle.yellowButton,
                );
              }),
        )
      ],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: MainAppBar(
          title: Text('${context.translate(AppStrings.CART)}'),
          hasCart: false,
        ),
      ),
      body: Observer<CartActionsResponse>(
          onRetryClicked: () {
            cartListManager.execute();
          },
          manager: cartListManager,
          stream: cartListManager.cartList$,
          onSuccess: (context, cartListSnapshot) {
            var cartList = cartListSnapshot.data?.cart;
            return cartList!.isEmpty
                ? NotAvailableComponent(
                    view: FaIcon(
                      FontAwesomeIcons.boxOpen,
                      color: AppStyle.blueTextButtonOpacity,
                      size: 100,
                    ),
                    title: ('${context.translate(AppStrings.cart_is_empty)}'),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          // padding: EdgeInsets.symmetric(horizontal: 15),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cartListSnapshot.data?.cart?.length ?? 0,
                          itemBuilder: (_, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 7),
                              child: CartItemWidget(
                                price:
                                    "${cartList[index].totalPrice} ${cartList[index].product?.currency}",
                                isFav: cartList[index].product?.isLiked == 1,
                                count: cartList[index].count,
                                imgUrl: cartList[index].product?.image,
                                size: cartList[index].size.toString().isNotEmpty
                                    ? cartList[index].size?.name
                                    : null,
                                name: cartList[index].product?.name,
                                color: cartList[index].color!,
                                onClickRemove: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        child: SlideInDown(
                                          child: TasawaaqDialog(
                                            title:
                                                "${context.translate(AppStrings.Remove_Item)}",
                                            confirmBtnTxt:
                                                "${context.translate(AppStrings.Remove)}",
                                            onClickConfirmBtn: () {
                                              Navigator.of(context).pop();
                                              removeFromCartManager
                                                  .removeFromCart(
                                                      request:
                                                          RemoveFromCartRequest(
                                                              cartId: cartList[
                                                                      index]
                                                                  .cartId))
                                                  .then((value) {

                                              });
                                            },
                                            columnCrossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            contentTextAlign: TextAlign.start,
                                            description:
                                                "${context.translate(AppStrings.Are_you_sure_you_want_to_remove_item_from_your_cart)}",
                                            onCloseBtn: () {
                                              Navigator.of(context).pop();
                                            },
                                            titleTextAlign: TextAlign.start,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                onClickFav: () {
                                  if (context.use<PrefsService>().userObj ==
                                      null) {
                                    favGuestDialog(
                                      context,
                                    );
                                  } else {
                                    addRemoveFavoriteManager.addRemoveFavorite(
                                        id: cartList[index].product?.id);
                                  }
                                },
                                onClickDecrement: () {
                                  if (cartList[index].count! != 1) {
                                    addToCartManager.addToCart(
                                      request: AddToCartRequest(
                                        storeId:
                                            cartList[index].product?.storeId,
                                        productId: cartList[index].product?.id,
                                        count: cartList[index].count! - 1,
                                        colorId: cartList[index].color?.id,
                                        sizeId: cartList[index].size?.id,
                                      ),
                                    );

                                  } else {
                                    toast.show(prefs.appLanguage == 'en'
                                        ? "sorry!  cant order less than 1 item"
                                        : "عذرا! لايمكن طلب كمية اقل من ١");
                                  }
                                },
                                onClickCIncrement: () {
                                  if (cartList[index].count! <
                                      cartList[index].quantity!) {
                                    addToCartManager.addToCart(
                                      request: AddToCartRequest(
                                        storeId:
                                            cartList[index].product?.storeId,
                                        productId: cartList[index].product?.id,
                                        count: cartList[index].count! + 1,
                                        colorId: cartList[index].color?.id,
                                        sizeId: cartList[index].size?.id,
                                      ),
                                    );

                                  } else {
                                    toast.show(prefs.appLanguage == 'en'
                                        ? "sorry!  reached the maximum quantity"
                                        : "عذرا! وصلت إلى الكمية القصوى");
                                  }
                                },
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        StatisticsItem(
                          title: "${context.translate(AppStrings.SUB_TOTAL)}",
                          value:
                              "${cartListSnapshot.data?.subtotal} ${cartListSnapshot.data?.currency}",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        StatisticsItem(
                          title: "${context.translate(AppStrings.DELIVERY)}",
                          value:
                              "${cartListSnapshot.data?.delivery} ${cartListSnapshot.data?.currency}",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        StatisticsItem(
                          title: "${context.translate(AppStrings.DISCOUNT)}",
                          value:
                              "${cartListSnapshot.data?.discount} ${cartListSnapshot.data?.currency}",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        StatisticsItem(
                          isTotal: true,
                          title: "${context.translate(AppStrings.TOTAL)}",
                          value:
                              "${cartListSnapshot.data?.total} ${cartListSnapshot.data?.currency}",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ));
          }),
    );
  }
}

/// TODO: Remove
List<CartItem> cartItems = [
  CartItem(
      color: "red",
      name: "product 1",
      size: "XL",
      imgUrl:
          "https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg",
      count: 2,
      isFav: true,
      price: "29.99 KWD"),
  CartItem(
      color: "yellow",
      name: "product 2",
      size: "L",
      imgUrl:
          "https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg",
      count: 3,
      isFav: false,
      price: "29.99 KWD"),
  CartItem(
      color: "red",
      name: "product 1",
      size: "XL",
      imgUrl:
          "https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg",
      count: 2,
      isFav: true,
      price: "29.99 KWD"),
];

class CartItem {
  final String? imgUrl;
  final String? price;
  final String? name;
  final String? color;
  final String? size;
  final int? count;
  final bool? isFav;

  CartItem(
      {this.isFav,
      this.price,
      this.count,
      this.name,
      this.size,
      this.color,
      this.imgUrl});
}
