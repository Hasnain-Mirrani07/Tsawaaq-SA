import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawaaq/app_core/fcm/localNotificationService.dart';
import 'package:tasawaaq/app_core/fcm/pushNotification_service.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/Profile/profile_page.dart';
import 'package:tasawaaq/features/about_mall_and_store/about_mall_store_page.dart';
import 'package:tasawaaq/features/addresses/add_address/add_address_page.dart';
import 'package:tasawaaq/features/addresses/my_addresses/my_addresses_page.dart';
import 'package:tasawaaq/features/ads/ads_page.dart';
import 'package:tasawaaq/features/all_stores/all_stores_page.dart';
import 'package:tasawaaq/features/cart/cart_count/cart_count_manager.dart';
import 'package:tasawaaq/features/cart/cart_page.dart';
import 'package:tasawaaq/features/change_password/change_password_page.dart';
import 'package:tasawaaq/features/checkout/checkout_page.dart';
import 'package:tasawaaq/features/checkout/payment_web_page.dart';
import 'package:tasawaaq/features/contact_us/contact_us_page.dart';
import 'package:tasawaaq/features/edit_profile/profile_phone_verification/verification_page.dart';
import 'package:tasawaaq/features/featured_products/featured_products_page.dart';
import 'package:tasawaaq/features/filter/filter_page.dart';
import 'package:tasawaaq/features/forget_confirm_password/forget_confirm_password_page.dart';
import 'package:tasawaaq/features/forget_password/forget_password_page.dart';
import 'package:tasawaaq/features/forget_password/verification_forget_password/forget_password_verification_page.dart';
import 'package:tasawaaq/features/initial_video/initial_video_page.dart';
import 'package:tasawaaq/features/intro/intro.dart';
import 'package:tasawaaq/features/mall_details/mall_details_page.dart';
import 'package:tasawaaq/features/malls/malls_page.dart';
import 'package:tasawaaq/features/my_orders/my_orders_page.dart';
import 'package:tasawaaq/features/notifications/notifications_page.dart';
import 'package:tasawaaq/features/offer_details/offer_details_page.dart';
import 'package:tasawaaq/features/offers/offers_page.dart';
import 'package:tasawaaq/features/order_details/order_details_page.dart';
import 'package:tasawaaq/features/payment_status/payment_status_page.dart';
import 'package:tasawaaq/features/product_details/product_details_page.dart';
import 'package:tasawaaq/features/product_list/product_list_page.dart';
import 'package:tasawaaq/features/search_results/search_results_page.dart';
import 'package:tasawaaq/features/sign_in_sign_up/sign_in_page.dart';
import 'package:tasawaaq/features/tabs/tabs.dart';
import 'package:tasawaaq/features/verification/verification_page.dart';

import 'app_core/app_core.dart';
import 'features/setting/pages/page.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  // print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  // locator<PushNotificationService>().xxx()
  // locator<PushNotificationService>().onBackgroundMessage(message);

  /*Set `enableInDevMode` to true to see reports while in debug mode
  This is only to be used for confirming that reports are being submitted as expected.
  It is not intended to be used for everyday development.*/
  //! [1] Crashlytics.
  // final crashlytics = FirebaseCrashlytics.instance;
  // await crashlytics.setCrashlyticsCollectionEnabled(true);
  // Pass all uncaught errors to Crashlytics.
  //! [2] Crashlytics.
  // FlutterError.onError = crashlytics.recordFlutterError;
  // FirebaseCrashlytics.instance.crash();

  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    //! Firebase Core.
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    try {
      await setupLocator().then(
        (_) async {
          AppLanguageManager appLanguage = locator<AppLanguageManager>();
          await appLanguage.fetchLocale();

          await SystemChrome.setPreferredOrientations(
              [DeviceOrientation.portraitUp]);
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              // status bar color
              // statusBarColor: AppStyle.appBarColor,
              // statusBarColor: Colors.transparent,
              //status bar brightness
              // statusBarBrightness: Brightness.dark,
              //status barIcon Brightness
              // statusBarIconBrightness: Brightness.dark,
              // navigation bar color
              // systemNavigationBarColor: Colors.blue[900],
              systemNavigationBarColor: Color(0xFF014676),
              //navigation bar icon
              systemNavigationBarIconBrightness: Brightness.light,
              // systemNavigationBarDividerColor: Colors.red,
            ),
          );
          // SystemChrome.setEnabledSystemUIOverlays([]);
          await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
          // await locator<ChatRegisterManager>().initCC();

          runApp(
            Root(
              locator: locator,
              child: TasawaaqApp(),
            ),
          );
        },

        /// TODO: Uncomment when used Firebase
        onError: (error, stackTrace) => debugPrint(
            'runZonedGuarded: Caught error in my root zone. \n$error'),
        //! [3] Crashlytics.
        // onError: (error, stackTrace) =>
        //     FirebaseCrashlytics.instance.recordError(error, stackTrace),
      );
    } catch (error) {
      debugPrint("error $error");
    }
  }, (error, stackTrace) {
    debugPrint('runZonedGuarded: Caught error in my root zone. \n$error');
    debugPrint(
        'runZonedGuarded: Caught error in my root zone. \n${error.toString()}');
    debugPrint('runZonedGuarded: Caught error in my root zone. \n$stackTrace');

    /// TODO: Uncomment when used Firebase
    // FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class TasawaaqApp extends StatefulWidget {
  @override
  _TasawaaqAppState createState() => _TasawaaqAppState();
}

class _TasawaaqAppState extends State<TasawaaqApp> {
  @override
  void initState() {
    super.initState();
    ////////////////////////////////////////////////////////////////////////////
    /// ! PushNotification
    locator<PushNotificationService>().initialize();
    ////////////////////////////////////////////////////////////////////////////
    /// ! LocalNotification
    locator<LocalNotificationService>().initializeLocalNotification();
    ////////////////////////////////////////////////////////////////////////////

    locator<CartCountManager>().execute();
  }

  @override
  Widget build(BuildContext context) {
    final langManager = Provider.of(context)<AppLanguageManager>();
    final navigationService = context.use<NavigationService>();
    final prefs = context.use<PrefsService>();
    // final analyticsService = context.use<AnalyticsService>();

    return StreamBuilder<Locale>(
        initialData: Locale('en'),
        stream: langManager.locale$,
        builder: (context, localeSnapshot) {
          return ScreenUtilInit(
            // designSize: Size(375, 925),
            designSize: Size(360, 690),
            builder: (_, __) => MaterialApp(
              debugShowCheckedModeBanner: false,
              color: AppStyle.appBarColor,
              title: 'Tasawaaq App',
              builder: (context, widget) => BaseWidget(
                child: widget!,
              ),
              //! [6] FirebaseAnalytics.
              navigatorObservers: <NavigatorObserver>[
                // analyticsService.getAnalyticsObserver()
              ],
              navigatorKey: navigationService.navigatorKey,
              theme: ThemeData(
                appBarTheme: Theme.of(context).appBarTheme.copyWith(
                      systemOverlayStyle: const SystemUiOverlayStyle(
                        statusBarBrightness: Brightness.dark,
                      ),
                    ),

                primarySwatch: AppStyle.appColor,
                fontFamily: 'Avenir',
                // primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              locale: localeSnapshot.data,

              // List all of the app's supported locales here
              supportedLocales: [
                Locale('en', 'US'),
                Locale('ar', ''),
              ],
              // These delegates make sure that the localization data for the proper language is loaded
              localizationsDelegates: [
                // THIS CLASS WILL BE ADDED LATER
                // A class which loads the translations from JSON files
                AppLocalizations.delegate,
                // Built-in localization of basic text for Material widgets
                GlobalMaterialLocalizations.delegate,
                // Built-in localization for text direction LTR/RTL
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate
              ],
              // Returns a locale which will be used by the app
              localeResolutionCallback: (locale, supportedLocales) {
                if (prefs.appLanguage.isEmpty) {
                  // Check if the current device locale is supported
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale!.languageCode) {
                      langManager.changeLanguage(supportedLocale);
                      prefs.appLanguage = supportedLocale.languageCode;
                      return supportedLocale;
                    }
                  }
                  // If the locale of the device is not supported, use the first one
                  // from the list (English, in this case).
                  langManager.changeLanguage(supportedLocales.first);
                  prefs.appLanguage = supportedLocales.first.languageCode;

                  return supportedLocales.first;
                } else {
                  return Locale(prefs.appLanguage);
                }
              },

              // home: AdsPage(),
              home: InitialVideoPlayerWidget(),
              // home: IntroPage(),

              routes: {
                AppRouts.TABS_WIDGET: (_) => TabsWidget(),
                AppRouts.ADS_PAGE: (_) => AdsPage(),
                AppRouts.ForgetPasswordPage: (_) => ForgetPasswordPage(),
                AppRouts.ForgetPasswordConfirmPage: (_) =>
                    ForgetPasswordConfirmPage(),
                AppRouts.SignInPage: (_) => SignInPage(),
                AppRouts.FeaturedProductsPage: (_) => FeaturedProductsPage(),
                AppRouts.MallsPage: (_) => MallsPage(),
                AppRouts.ProductsListPage: (_) => ProductsListPage(),
                AppRouts.MallDetailsPage: (_) => MallDetailsPage(),
                AppRouts.AllStoresPage: (_) => AllStoresPage(),
                AppRouts.AboutMallsAndStorePage: (_) =>
                    AboutMallsAndStorePage(),
                AppRouts.ProductDetails: (_) => ProductDetails(),
                AppRouts.CartPage: (_) => CartPage(),
                AppRouts.CheckOutPage: (_) => CheckOutPage(),
                AppRouts.AddAddressPage: (_) => AddAddressPage(),
                AppRouts.PaymentStatusPage: (_) => PaymentStatusPage(),
                AppRouts.OrderDetailsPage: (_) => OrderDetailsPage(),
                AppRouts.MyOrdersPage: (_) => MyOrdersPage(),
                AppRouts.SearchResultsPage: (_) => SearchResultsPage(),
                AppRouts.ServicesTemplatePage: (_) => ServicesTemplatePage(),
                AppRouts.ContactUsPage: (_) => ContactUsPage(),
                AppRouts.ChangePasswordPage: (_) => ChangePasswordPage(),
                AppRouts.OffersPage: (_) => OffersPage(),
                AppRouts.OfferDetailsPage: (_) => OfferDetailsPage(),
                AppRouts.MyAddressesPage: (_) => MyAddressesPage(),
                AppRouts.PROFILE_PAGE: (_) => ProfilePage(),
                // AppRouts.EDIT_PROFILE_PAGE: (_) => EditProfilePage(),
                AppRouts.IntroPage: (_) => IntroPage(),
                AppRouts.FILTER_PAGE: (_) => FilterPage(),
                AppRouts.VerificationPage: (_) => VerificationPage(),
                AppRouts.ForgetPasswordVerificationPage: (_) =>
                    ForgetPasswordVerificationPage(),
                // AppRouts.EditaddressPage: (_) => EditAddressPage(),
                AppRouts.PaymentWebPage: (_) => PaymentWebPage(),
                AppRouts.PhoneVerificationPage: (_) => PhoneVerificationPage(),
                AppRouts.NotificationsPage: (_) => NotificationsPage(),
              },
            ),
          );
        });
  }
}
