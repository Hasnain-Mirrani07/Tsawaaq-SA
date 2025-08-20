import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/cart/cart_count/cart_count_manager.dart';
import 'package:tasawaaq/features/cart/cart_count/cart_count_response.dart';
import 'package:tasawaaq/shared/network_app_image/network_app_image.dart';

// const String testImg =
//     'http://grasse-kw.com/gaaz/uploads/sliders/NVGIkOtwdSQCgiyBZBj5mKxByEJQ7zUirBiBlOks.jpeg';
//           preferredSize: Size.fromHeight(140.0),

class LogoAppBar extends StatefulWidget {
  final Widget? title;
  final bool hasRoundedEdge, hasDrawer, hasInfo, hasNotification, hasCart;
  final VoidCallback? onInfoClicked,
      onNotificationClicked,
      onCartClicked,
      onBackClicked;
  final double? elevation;
  final String imageUrl;
  LogoAppBar({
    Key? key,
    this.title,
    this.hasRoundedEdge = true,
    this.hasDrawer = false,
    this.hasInfo = false,
    this.hasNotification = false,
    this.hasCart = true,
    this.onInfoClicked,
    this.onNotificationClicked,
    this.onCartClicked,
    this.onBackClicked,
    this.elevation,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _LogoAppBarState createState() => _LogoAppBarState();
}

class _LogoAppBarState extends State<LogoAppBar> {
  void _defaultOnClickInfo() {}

  void _defaultOnClickNotification() {}

  void _defaultOnClickCart(context) {
    // showDialog(
    //     context: context,
    //     builder: (_) {
    //       return TasawaaqDialog(
    //         titleTextAlign: TextAlign.start,
    //         contentTextAlign: TextAlign.center,
    //         columnCrossAxisAlignment: CrossAxisAlignment.start,
    //         // onCloseBtn: () {
    //         //   Navigator.of(context).pop();
    //         // },
    //         title: 'dddddddddddddddddd',
    //         description:
    //             'ssssssssssssssssssssssss\naaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\naaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\naaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
    //       );
    //     });

    Navigator.of(context).pushNamed(AppRouts.CartPage);
  }

  @override
  Widget build(BuildContext context) {
    final cartCountManager = context.use<CartCountManager>();

    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 10,
                child: Container(
                  padding:
                      EdgeInsets.only(right: 6, left: 6, top: 12, bottom: 5),
                  decoration: BoxDecoration(
                    color: AppStyle.appBarColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: widget.hasDrawer
                            ? SvgPicture.asset(
                                '${AppAssets.DRAWER_ICON}',
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                        onPressed: () {
                          if (widget.hasDrawer) {
                            Scaffold.of(context).openDrawer();
                          } else {
                            widget.onBackClicked != null
                                ? widget.onBackClicked!()
                                : Navigator.of(context).pop();
                          }
                        },
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (widget.hasInfo)
                            IconButton(
                              icon: SvgPicture.asset(
                                '${AppAssets.INFO_ICON}',
                                color: Colors.white,
                              ),
                              onPressed: widget.onInfoClicked != null
                                  ? widget.onInfoClicked!
                                  : () {
                                      _defaultOnClickCart(context);
                                    },
                            ),
                          if (widget.hasCart)
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
                                      onPressed: widget.onCartClicked != null
                                          ? widget.onCartClicked!
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
                                      onPressed: widget.onCartClicked != null
                                          ? widget.onCartClicked!
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
                                      showBadge: int.parse(
                                              '${cartCountSnapshot.data?.count}') >
                                          0,
                                      // animationType: BadgeAnimationType.scale,
                                      badgeContent: Text(
                                          '${cartCountSnapshot.data?.count}',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      child: SvgPicture.asset(
                                        '${AppAssets.BAG_ICON}',
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: widget.onCartClicked != null
                                        ? widget.onCartClicked!
                                        : () {
                                            _defaultOnClickCart(context);
                                          },
                                  );
                                }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: 5,
              // ),
              Expanded(
                flex: 7,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.03 +
                (MediaQuery.of(context).viewPadding.top),
            left: 130.w,
            right: 130.w,
            child: Container(
              // width: 100,
              height: 97.h,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: NetworkAppImage(
                  boxFit: BoxFit.fill,
                  imageUrl: widget.imageUrl,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    // return AppBar(
    //   elevation: widget.elevation,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.only(
    //       bottomLeft: Radius.circular(widget.hasRoundedEdge ? 20 : 0),
    //       bottomRight: Radius.circular(widget.hasRoundedEdge ? 20 : 0),
    //     ),
    //   ),
    //   title: widget.title != null ? widget.title : Text(''),
    //   centerTitle: true,
    //   leading: Builder(
    //     builder: (context) => InkWell(
    //       onTap: () {
    //         if (widget.hasDrawer) {
    //           Scaffold.of(context).openDrawer();
    //         } else {
    //           widget.onBackClicked != null
    //               ? widget.onBackClicked!()
    //               : Navigator.of(context).pop();
    //         }
    //       },
    //       child: Container(
    //         padding: EdgeInsets.all(18),
    //         child: widget.hasDrawer
    //             ? SvgPicture.asset(
    //                 '${AppAssets.DRAWER_ICON}',
    //                 color: Colors.white,
    //               )
    //             : Icon(Icons.arrow_back),
    //       ),
    //     ),
    //   ),
    //   actions: <Widget>[
    //     if (widget.hasInfo)
    //       IconButton(
    //         icon: SvgPicture.asset(
    //           '${AppAssets.INFO_ICON}',
    //           color: Colors.white,
    //         ),
    //         onPressed: widget.onInfoClicked != null
    //             ? widget.onInfoClicked!
    //             : _defaultOnClickInfo,
    //       ),
    //     if (widget.hasNotification)
    //       IconButton(
    //         icon: SvgPicture.asset(
    //           '${AppAssets.BELL_ICON}',
    //           color: Colors.white,
    //         ),
    //         onPressed: widget.onNotificationClicked != null
    //             ? widget.onNotificationClicked!
    //             : _defaultOnClickNotification,
    //       ),
    //     if (widget.hasCart)
    //       IconButton(
    //         icon: SvgPicture.asset(
    //           '${AppAssets.BAG_ICON}',
    //           color: Colors.white,
    //         ),
    //         onPressed: widget.onCartClicked != null
    //             ? widget.onCartClicked!
    //             : () {
    //                 _defaultOnClickCart(context);
    //               },
    //       ),
    //   ],
    // );
  }
}

////////////////////////////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:tasawaaq/app_assets/app_assets.dart';
// import 'package:tasawaaq/shared/dialog/tasawaaq_dialog.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// const String testImg =
//     'http://grasse-kw.com/gaaz/uploads/sliders/NVGIkOtwdSQCgiyBZBj5mKxByEJQ7zUirBiBlOks.jpeg';

// class LogoAppBar extends StatefulWidget {
//   final Widget? title;
//   final bool hasRoundedEdge, hasDrawer, hasInfo, hasNotification, hasCart;
//   final VoidCallback? onInfoClicked,
//       onNotificationClicked,
//       onCartClicked,
//       onBackClicked;
//   final double? elevation;
//   LogoAppBar({
//     Key? key,
//     this.title,
//     this.hasRoundedEdge = true,
//     this.hasDrawer = false,
//     this.hasInfo = false,
//     this.hasNotification = false,
//     this.hasCart = true,
//     this.onInfoClicked,
//     this.onNotificationClicked,
//     this.onCartClicked,
//     this.onBackClicked,
//     this.elevation,
//   }) : super(key: key);

//   @override
//   _LogoAppBarState createState() => _LogoAppBarState();
// }

// class _LogoAppBarState extends State<LogoAppBar> {
//   void _defaultOnClickInfo() {}

//   void _defaultOnClickNotification() {}

//   void _defaultOnClickCart(context) {
//     showDialog(
//         context: context,
//         builder: (_) {
//           return TasawaaqDialog(
//             titleTextAlign: TextAlign.start,
//             contentTextAlign: TextAlign.center,
//             columnCrossAxisAlignment: CrossAxisAlignment.start,
//             // onCloseBtn: () {
//             //   Navigator.of(context).pop();
//             // },
//             title: 'dddddddddddddddddd',
//             description:
//                 'ssssssssssssssssssssssss\naaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\naaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\naaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
//           );
//         });
//   }

//   late OverlayEntry overlayEntry;

//   void _showOverlay(BuildContext context) async {
//     // Declaring and Initializing OverlayState
//     // and OverlayEntry objects
//     OverlayState? overlayState = Overlay.of(context);
//     // OverlayEntry overlayEntry;
//     overlayEntry = OverlayEntry(builder: (context) {
//       // You can return any widget you like here
//       // to be displayed on the Overlay
//       return Positioned(
//         top: MediaQuery.of(context).size.height * 0.03 +
//             (MediaQuery.of(context).viewPadding.top),
//         left: 130.w,
//         right: 130.w,
//         child: Material(
//           child: InkWell(
//             onTap: () {
//               _removeOverlay();
//               print('object');
//             },
//             child: Container(
//               // width: 100,
//               height: 120.h,
//               child: Image.network(
//                 testImg,
//                 fit: BoxFit.fill,
//                 colorBlendMode: BlendMode.multiply,
//               ),
//             ),
//           ),
//         ),
//       );
//     });

//     // Inserting the OverlayEntry into the Overlay
//     overlayState?.insert(overlayEntry);
//   }

//   @override
//   void dispose() {
//     _removeOverlay();
//     super.dispose();
//   }

//   // @override
//   // void didUpdateWidget(LogoAppBar oldWidget) {
//   //   super.didUpdateWidget(oldWidget);
//   //   _removeOverlay();
//   // }

//   _removeOverlay() {
//     overlayEntry.remove();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // if (mounted) {}

//     WidgetsBinding.instance!.addPostFrameCallback((_) {
//       _showOverlay(context);
//     });

//     return AppBar(
//       elevation: widget.elevation,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(widget.hasRoundedEdge ? 20 : 0),
//           bottomRight: Radius.circular(widget.hasRoundedEdge ? 20 : 0),
//         ),
//       ),
//       title: widget.title != null ? widget.title : Text(''),
//       centerTitle: true,
//       leading: Builder(
//         builder: (context) => InkWell(
//           onTap: () {
//             if (widget.hasDrawer) {
//               Scaffold.of(context).openDrawer();
//             } else {
//               widget.onBackClicked != null
//                   ? widget.onBackClicked!()
//                   : Navigator.of(context).pop();
//             }
//           },
//           child: Container(
//             padding: EdgeInsets.all(18),
//             child: widget.hasDrawer
//                 ? SvgPicture.asset(
//                     '${AppAssets.DRAWER_ICON}',
//                     color: Colors.white,
//                   )
//                 : Icon(Icons.arrow_back),
//           ),
//         ),
//       ),
//       actions: <Widget>[
//         if (widget.hasInfo)
//           IconButton(
//             icon: SvgPicture.asset(
//               '${AppAssets.INFO_ICON}',
//               color: Colors.white,
//             ),
//             onPressed: widget.onInfoClicked != null
//                 ? widget.onInfoClicked!
//                 : _defaultOnClickInfo,
//           ),
//         if (widget.hasNotification)
//           IconButton(
//             icon: SvgPicture.asset(
//               '${AppAssets.BELL_ICON}',
//               color: Colors.white,
//             ),
//             onPressed: widget.onNotificationClicked != null
//                 ? widget.onNotificationClicked!
//                 : _defaultOnClickNotification,
//           ),
//         if (widget.hasCart)
//           IconButton(
//             icon: SvgPicture.asset(
//               '${AppAssets.BAG_ICON}',
//               color: Colors.white,
//             ),
//             onPressed: widget.onCartClicked != null
//                 ? widget.onCartClicked!
//                 : () {
//                     _defaultOnClickCart(context);
//                   },
//           ),
//       ],
//     );
//   }
// }
