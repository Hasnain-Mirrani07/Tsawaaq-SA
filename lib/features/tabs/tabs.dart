import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/categories/categories_page.dart';
import 'package:tasawaaq/features/drawer/drawer.dart';
import 'package:tasawaaq/features/favorite/favorite_page.dart';
import 'package:tasawaaq/features/home/home_page.dart';
import 'package:tasawaaq/features/search/search_page.dart';
import 'package:tasawaaq/features/setting/setting_page.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';

class TabsWidget extends StatefulWidget {
  TabsWidget({
    Key? key,
  }) : super(key: key);

  @override
  _TabsWidgetState createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget> {
  int currentIndex = 0;
  Widget currentWidget = HomePage();
  Widget currentAppBarWidget = MainAppBar(
    // onNotificationClicked: (){
    //   Navigator.of(context).pushNamed(AppRouts.NotificationsPage);
    // },
    hasRoundedEdge: false,
    elevation: 0,
    hasDrawer: true,
    hasNotification: true,
    title: Column(
      children: [
        Container(
          width: 110,
          child: Image.asset(
            AppAssets.APP_BAR_LOGO,
          ),
        ),
        // Text(
        //   locator<PrefsService>().appLanguage == 'en' ? 'ALWAYS IN STYLE !':'! ALWAYS IN STYLE',
        //   style: TextStyle(
        //     fontSize: 8,
        //     color: AppStyle.yellowButton,
        //   ),
        // )
      ],
    ),
  );

  void _selectTap(int tabIndex) {
    currentIndex = tabIndex;
    switch (tabIndex) {
      case 0:
        currentAppBarWidget = MainAppBar(
          // onNotificationClicked: (){
          //   Navigator.of(context).pushNamed(AppRouts.NotificationsPage);
          // },
          hasRoundedEdge: false,
          elevation: 0,
          hasDrawer: true,
          hasNotification: true,
          title: Column(
            children: [
              Container(
                width: 110,
                child: Image.asset(
                  AppAssets.APP_BAR_LOGO,
                ),
              ),
              // Text(
              //   locator<PrefsService>().appLanguage == 'en' ? 'ALWAYS IN STYLE !':'! ALWAYS IN STYLE',
              //   style: TextStyle(
              //     fontSize: 8,
              //     color: AppStyle.yellowButton,
              //   ),
              // )
            ],
          ),
        );
        currentWidget = HomePage();
        break;
      case 1:
        currentAppBarWidget = MainAppBar(
          // onNotificationClicked: (){
          //   Navigator.of(context).pushNamed(AppRouts.NotificationsPage);
          // },
          title: Text('${context.translate(AppStrings.CATEGORIES)}'),
          onBackClicked: () {
            setState(() {
              _selectTap(0);
            });
          },
        );
        currentWidget = CategoriesPage();
        break;
      case 2:
        currentAppBarWidget = MainAppBar(
          // onNotificationClicked: (){
          //   Navigator.of(context).pushNamed(AppRouts.NotificationsPage);
          // },
          title: Text('${context.translate(AppStrings.SEARCH)}'),
          onBackClicked: () {
            setState(() {
              _selectTap(0);
            });
          },
        );
        currentWidget = SearchPage();
        break;
      case 3:
        currentAppBarWidget = MainAppBar(
          // onNotificationClicked: (){
          //   Navigator.of(context).pushNamed(AppRouts.NotificationsPage);
          // },
          title: Text('${context.translate(AppStrings.WishList)}'),
          onBackClicked: () {
            // locator<SearchManager>().inPageState.add(PageState.IDLE);
            setState(() {
              _selectTap(0);
            });
          },
        );
        currentWidget = FavoritePage();
        break;
      case 4:
        currentAppBarWidget = MainAppBar(
          // onNotificationClicked: (){
          //   Navigator.of(context).pushNamed(AppRouts.NotificationsPage);
          // },
          title: Text('${context.translate(AppStrings.SETTINGS)}'),
          onBackClicked: () {
            setState(() {
              _selectTap(0);
            });
          },
        );
        currentWidget = SettingPage();
        break;
      default:
        currentAppBarWidget = MainAppBar(
            // onNotificationClicked: (){
            //   Navigator.of(context).pushNamed(AppRouts.NotificationsPage);
            // },
            );
        currentWidget = HomePage();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final prefs = context.use<PrefsService>();

    return WillPopScope(
      onWillPop: () async {
        if (currentIndex == 0) {
          return true;
        } else {
          setState(() {
            _selectTap(0);
          });
          return false;
        }
      },
      child: Scaffold(
        // backgroundColor: AppStyle.appBarColor,
        drawer: AppDrawer(),
        drawerEnableOpenDragGesture: currentIndex == 0 ? true : false,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          // child: SafeArea(
          child: currentAppBarWidget,
          // ),
        ),
        body: Container(color: Colors.white, child: currentWidget),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: AppStyle.appBarColor,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              // primaryColor: Colors.red,
              textTheme: Theme.of(context).textTheme.copyWith(bodySmall: new TextStyle(color: Colors.yellow))),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              // boxShadow: [
              //   BoxShadow(
              //       color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              // ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: BottomNavigationBar(
                onTap: (index) {
                  setState(() {
                    _selectTap(index);
                  });
                },
                currentIndex: currentIndex,
                selectedItemColor: AppStyle.yellowButton,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 5,
                unselectedItemColor: Colors.blue[100],
                iconSize: 30,
                items: List.generate(5, (index) {
                  var _selectedItemColor = AppStyle.yellowButton;
                  String _tooltip = '';
                  String _icon = '';
                  String _title = '';
                  switch (index) {
                    case 0:
                      _icon = AppAssets.HOME_ICON;
                      _tooltip = '${context.translate(AppStrings.HOME)}';
                      _title = '${context.translate(AppStrings.HOME)}';
                      break;
                    case 1:
                      _icon = AppAssets.CATEGORIES_ICON;
                      _tooltip = '${context.translate(AppStrings.CATEGORIES)}';
                      _title = '${context.translate(AppStrings.CATEGORIES)}';

                      break;
                    case 2:
                      _icon = AppAssets.SEARCH_ICON;
                      _tooltip = '${context.translate(AppStrings.SEARCH)}';
                      _title = '${context.translate(AppStrings.SEARCH)}';

                      break;
                    case 3:
                      _icon = AppAssets.FAVORITE_ICON;
                      _tooltip = '${context.translate(AppStrings.FAVORITES)}';
                      _title = '${context.translate(AppStrings.FAVORITES)}';
                      break;
                    case 4:
                      _icon = AppAssets.SETTING_ICON;
                      _tooltip = '${context.translate(AppStrings.SETTINGS)}';
                      _title = '${context.translate(AppStrings.SETTINGS)}';

                      break;
                    default:
                  }

                  return BottomNavigationBarItem(
                    icon: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          _icon,
                          color: currentIndex == index ? _selectedItemColor : Colors.blue[100],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "$_title",
                          style: TextStyle(height: 0, color: currentIndex == index ? _selectedItemColor : Colors.blue[100], fontSize: 10),
                        )
                      ],
                    ),
                    label: '',
                    tooltip: _tooltip,
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
