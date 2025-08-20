import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/features/cart/cart_count/cart_count_manager.dart';
import 'package:tasawaaq/features/cart/cart_count/cart_count_response.dart';

//           preferredSize: Size.fromHeight(140.0),

class MainAppBar extends StatelessWidget {
  final Widget? title;
  final bool hasRoundedEdge,
      hasDrawer,
      hasInfo,
      hasNotification,
      hasCart,
      hasLeading;
  final VoidCallback? onInfoClicked,
      // onNotificationClicked,
      onCartClicked,
      onBackClicked;
  final double? elevation;
  const MainAppBar({
    Key? key,
    this.title,
    this.hasRoundedEdge = true,
    this.hasDrawer = false,
    this.hasInfo = false,
    this.hasNotification = false,
    this.hasCart = true,
    this.onInfoClicked,
    // this.onNotificationClicked,
    this.onCartClicked,
    this.onBackClicked,
    this.elevation,
    this.hasLeading = true,
  }) : super(key: key);

  void _defaultOnClickInfo() {}
  void _defaultOnClickNotification() {}
  void _defaultOnClickCart(context) {
    //   showDialog(
    //       context: context,
    //       builder: (_) {
    //         return TasawaaqDialog(
    //           titleTextAlign: TextAlign.start,
    //           contentTextAlign: TextAlign.center,
    //           columnCrossAxisAlignment: CrossAxisAlignment.start,
    //           // onCloseBtn: () {
    //           //   Navigator.of(context).pop();
    //           // },
    //           title: 'dddddddddddddddddd',
    //           description:
    //               'ssssssssssssssssssssssss\naaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\naaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\naaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
    //         );
    //       });

    Navigator.of(context).pushNamed(AppRouts.CartPage);
  }

  @override
  Widget build(BuildContext context) {
    final cartCountManager = context.use<CartCountManager>();

    return AppBar(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(hasRoundedEdge ? 20 : 0),
          bottomRight: Radius.circular(hasRoundedEdge ? 20 : 0),
        ),
      ),
      title: title != null ? title : Text(''),
      centerTitle: true,
      leading: hasLeading
          ? Builder(
              builder: (context) => InkWell(
                onTap: () {
                  if (hasDrawer) {
                    Scaffold.of(context).openDrawer();
                  } else {
                    onBackClicked != null
                        ? onBackClicked!()
                        : Navigator.of(context).pop();
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(18),
                  child: hasDrawer
                      ? SvgPicture.asset(
                          '${AppAssets.DRAWER_ICON}',
                          color: Colors.white,
                        )
                      : Icon(Icons.arrow_back),
                ),
              ),
            )
          : Container(),
      actions: <Widget>[
        if (hasInfo)
          IconButton(
            icon: SvgPicture.asset(
              '${AppAssets.INFO_ICON}',
              color: Colors.white,
            ),
            onPressed:
                onInfoClicked != null ? onInfoClicked! : _defaultOnClickInfo,
          ),
        if (hasNotification)
          IconButton(
            icon: SvgPicture.asset(
              '${AppAssets.BELL_ICON}',
              color: Colors.white,
            ),
            // onPressed: onNotificationClicked != null
            //     ? onNotificationClicked!
            //     : _defaultOnClickNotification,
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouts.NotificationsPage);
            },
          ),
        if (hasCart)
          Observer<CartCountResponse>(
              onWaiting: (context) => IconButton(
                    icon: Badge(
                      showBadge: false,
                      // animationType: BadgeAnimationType.scale,
                      child: SvgPicture.asset(
                        '${AppAssets.BAG_ICON}',
                        color: Colors.white,
                      ),
                    ),
                    onPressed: onCartClicked != null
                        ? onCartClicked!
                        : () {
                            _defaultOnClickCart(context);
                          },
                  ),
              onError: (context, error) => IconButton(
                    icon: Badge(
                      showBadge: false,
                      // animationType: BadgeAnimationType.scale,
                      child: SvgPicture.asset(
                        '${AppAssets.BAG_ICON}',
                        color: Colors.white,
                      ),
                    ),
                    onPressed: onCartClicked != null
                        ? onCartClicked!
                        : () {
                            _defaultOnClickCart(context);
                          },
                  ),
              onRetryClicked: () {
              },
              manager: cartCountManager,
              stream: cartCountManager.cartCount$,
              onSuccess: (context, cartCountSnapshot) {
                return IconButton(
                  icon: Badge(
                    showBadge:
                        int.parse('${cartCountSnapshot.data?.count}') > 0,
                    // animationType: BadgeAnimationType.scale,
                    badgeContent: Text('${cartCountSnapshot.data?.count}',
                        style: TextStyle(color: Colors.white)),
                    child: SvgPicture.asset(
                      '${AppAssets.BAG_ICON}',
                      color: Colors.white,
                    ),
                  ),
                  onPressed: onCartClicked != null
                      ? onCartClicked!
                      : () {
                          _defaultOnClickCart(context);
                        },
                );
              }),
      ],
    );
  }
}
