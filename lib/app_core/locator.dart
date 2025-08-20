import 'package:get_it/get_it.dart';
import 'package:tasawaaq/app_core/fcm/FcmTokenManager.dart';
import 'package:tasawaaq/app_core/fcm/localNotificationService.dart';
import 'package:tasawaaq/app_core/services/media_service/media_Service.dart';
import 'package:tasawaaq/features/Profile/profile_manager.dart';
import 'package:tasawaaq/features/about_mall_and_store/about_mall/about_mall_manager.dart';
import 'package:tasawaaq/features/about_mall_and_store/about_store/about_store_manager.dart';
import 'package:tasawaaq/features/addresses/add_address/add_address_manger.dart';
import 'package:tasawaaq/features/addresses/area_get/area_get_manager.dart';
import 'package:tasawaaq/features/addresses/delete_address/delete_address_manger.dart';
import 'package:tasawaaq/features/addresses/edite_address/edit_address_manger.dart';
import 'package:tasawaaq/features/addresses/my_addresses/my_address_manager.dart';
import 'package:tasawaaq/features/ads/ads_manager.dart';
import 'package:tasawaaq/features/all_stores/all_stores_manager.dart';
import 'package:tasawaaq/features/cart/cart_actions/cart_managers/add_manager.dart';
import 'package:tasawaaq/features/cart/cart_actions/cart_managers/cart_list_manager.dart';
import 'package:tasawaaq/features/cart/cart_actions/cart_managers/remove_manager.dart';
import 'package:tasawaaq/features/cart/cart_count/cart_count_manager.dart';
import 'package:tasawaaq/features/categories/categories_manager.dart';
import 'package:tasawaaq/features/change_password/change_password_manager.dart';
import 'package:tasawaaq/features/checkout/managers/checkout_info_manager.dart';
import 'package:tasawaaq/features/checkout/managers/payment_manager.dart';
import 'package:tasawaaq/features/checkout/promo_code/coupon_manager.dart';
import 'package:tasawaaq/features/contact_us/contact_us_manager.dart';
import 'package:tasawaaq/features/delete_user_action/delete_user_manager.dart';
import 'package:tasawaaq/features/edit_profile/edit_profile_manager.dart';
import 'package:tasawaaq/features/edit_profile/profile_phone_verification/verification_manager.dart';
import 'package:tasawaaq/features/favorite/add_remove_favorite/manager.dart';
import 'package:tasawaaq/features/favorite/favorite_manager.dart';
import 'package:tasawaaq/features/featured_products/featured_products_manager.dart';
import 'package:tasawaaq/features/filter/filter_manager.dart';
import 'package:tasawaaq/features/forget_confirm_password/forget_confirm_password_manager.dart';
import 'package:tasawaaq/features/forget_password/forget_password_manager.dart';
import 'package:tasawaaq/features/forget_password/verification_forget_password/forget_password_ResendManager.dart';
import 'package:tasawaaq/features/forget_password/verification_forget_password/forget_password_verification_manager.dart';
import 'package:tasawaaq/features/home/home_manager.dart';
import 'package:tasawaaq/features/intro/intor_manager.dart';
import 'package:tasawaaq/features/mall_details/mall_details_manager.dart';
import 'package:tasawaaq/features/malls/malls_manager.dart';
import 'package:tasawaaq/features/my_orders/my_orders_manager.dart';
import 'package:tasawaaq/features/notifications/notifications_manager.dart';
import 'package:tasawaaq/features/offer_details/offer_details_manager.dart';
import 'package:tasawaaq/features/offers/offers_manager.dart';
import 'package:tasawaaq/features/order_details/order_details_manager.dart';
import 'package:tasawaaq/features/product_details/product_details_manager.dart';
import 'package:tasawaaq/features/product_list/product_list_manager.dart';
import 'package:tasawaaq/features/re_order/re_order_manager.dart';
import 'package:tasawaaq/features/search/search_get/search_manager.dart';
import 'package:tasawaaq/features/search/search_post/search_post_manager.dart';
import 'package:tasawaaq/features/setting/pages/page_manager.dart';
import 'package:tasawaaq/features/setting/setting_manager.dart';
import 'package:tasawaaq/features/sign_in_sign_up/sign_in_manager.dart';
import 'package:tasawaaq/features/sign_in_sign_up/sign_up_manager.dart';
import 'package:tasawaaq/features/verification/ResendManager.dart';
import 'package:tasawaaq/features/verification/verification_manager.dart';

import 'app_core.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Setup PrefsService.
  var instance = await PrefsService.getInstance();
  locator.registerSingleton<PrefsService>(instance!);

  /// AppLanguageManager
  locator.registerLazySingleton<AppLanguageManager>(() => AppLanguageManager());

  /// NavigationService
  locator.registerLazySingleton<NavigationService>(() => NavigationService());

  /// FcmTokenManager
  locator.registerLazySingleton<FcmTokenManager>(() => FcmTokenManager());

  /// AnalyticsService
  // locator.registerLazySingleton<AnalyticsService>(() => AnalyticsService());

  /// SignInManager
  locator.registerLazySingleton<SignInManager>(() => SignInManager());

  // /// LocalNotificationService
  // locator.registerLazySingleton<LocalNotificationService>(
  //     () => LocalNotificationService());

  /// LocalNotificationService
  locator.registerLazySingleton<LocalNotificationService>(() => LocalNotificationService());

  /// PushNotificationService
  // locator.registerLazySingleton<PushNotificationService>(
  //     () => PushNotificationService());

  /// LoadingManager
  locator.registerLazySingleton<LoadingManager>(() => LoadingManager());

  /// ApiService
  locator.registerLazySingleton<ApiService>(() => ApiService());

  /// ToastTemplate
  locator.registerLazySingleton<ToastTemplate>(() => ToastTemplate());

  /// ForgetPasswordManager
  locator.registerLazySingleton<ForgetPasswordManager>(() => ForgetPasswordManager());

  /// ForgetPasswordConfirmManager
  locator.registerLazySingleton<ForgetPasswordConfirmManager>(() => ForgetPasswordConfirmManager());

  /// MallDetailsManager
  locator.registerLazySingleton<MallDetailsManager>(() => MallDetailsManager());

  /// AllStoresManager
  locator.registerLazySingleton<AllStoresManager>(() => AllStoresManager());

  /// ProductListManager
  locator.registerLazySingleton<ProductListManager>(() => ProductListManager());

  /// FilterManager
  locator.registerLazySingleton<FilterManager>(() => FilterManager());

  /// AddAddressManager
  locator.registerLazySingleton<AddAddressManager>(() => AddAddressManager());

  /// SearchManager
  locator.registerLazySingleton<SearchManager>(() => SearchManager());

  /// MyOrderManager
  locator.registerLazySingleton<MyOrderManager>(() => MyOrderManager());

  /// SettingsManager
  locator.registerLazySingleton<SettingsManager>(() => SettingsManager());

  /// ContactUsManager
  locator.registerLazySingleton<ContactUsManager>(() => ContactUsManager());

  /// ChangePasswordManager
  locator.registerLazySingleton<ChangePasswordManager>(() => ChangePasswordManager());

  /// AdsManager
  locator.registerLazySingleton<AdsManager>(() => AdsManager());

  /// EditProfileManager
  locator.registerLazySingleton<EditProfileManager>(() => EditProfileManager());

  /// MediaService
  locator.registerLazySingleton<MediaService>(() => MediaService());

  /// PageManager
  locator.registerLazySingleton<PageManager>(() => PageManager());

  /// HomeManager
  locator.registerLazySingleton<HomeManager>(() => HomeManager());

  /// IntroManager
  locator.registerLazySingleton<IntroManager>(() => IntroManager());

  /// SignUpManager
  locator.registerLazySingleton<SignUpManager>(() => SignUpManager());

  /// VerificationManager
  locator.registerLazySingleton<VerificationManager>(() => VerificationManager());

  /// ResendManager
  locator.registerLazySingleton<ResendManager>(() => ResendManager());

  /// ForgetPasswordResendManager
  locator.registerLazySingleton<ForgetPasswordResendManager>(() => ForgetPasswordResendManager());

  /// ForgetPasswordVerificationManager
  locator.registerLazySingleton<ForgetPasswordVerificationManager>(() => ForgetPasswordVerificationManager());

  /// MallsManager
  locator.registerLazySingleton<MallsManager>(() => MallsManager());

  /// FeaturedProductsManager
  locator.registerLazySingleton<FeaturedProductsManager>(() => FeaturedProductsManager());

  /// AboutStoreManager
  locator.registerLazySingleton<AboutStoreManager>(() => AboutStoreManager());

  /// AboutMallManager
  locator.registerLazySingleton<AboutMallManager>(() => AboutMallManager());

  /// ProductDetailsManager
  locator.registerLazySingleton<ProductDetailsManager>(() => ProductDetailsManager());

  /// CategoriesManager
  locator.registerLazySingleton<CategoriesManager>(() => CategoriesManager());

  /// CartCountManager
  locator.registerLazySingleton<CartCountManager>(() => CartCountManager());

  /// AddManager
  locator.registerLazySingleton<AddManager>(() => AddManager());

  /// CartListManager
  locator.registerLazySingleton<CartListManager>(() => CartListManager());

  /// RemoveManager
  locator.registerLazySingleton<RemoveManager>(() => RemoveManager());

  /// FavoriteManager
  locator.registerLazySingleton<FavoriteManager>(() => FavoriteManager());

  /// AddRemoveFavoriteManager
  locator.registerLazySingleton<AddRemoveFavoriteManager>(() => AddRemoveFavoriteManager());

  /// CheckoutInfoManager
  locator.registerLazySingleton<CheckoutInfoManager>(() => CheckoutInfoManager());

  /// MyAddressesManager
  locator.registerLazySingleton<MyAddressesManager>(() => MyAddressesManager());

  /// DeleteAddressManager
  locator.registerLazySingleton<DeleteAddressManager>(() => DeleteAddressManager());

  /// EditAddressManager
  locator.registerLazySingleton<EditAddressManager>(() => EditAddressManager());

  /// AreaGetManager
  locator.registerLazySingleton<AreaGetManager>(() => AreaGetManager());

  /// SearchGetManager
  locator.registerLazySingleton<SearchGetManager>(() => SearchGetManager());

  /// PaymentManager
  locator.registerLazySingleton<PaymentManager>(() => PaymentManager());

  /// CouponManager
  locator.registerLazySingleton<CouponManager>(() => CouponManager());

  /// OrderDetailsManager
  locator.registerLazySingleton<OrderDetailsManager>(() => OrderDetailsManager());

  /// ProfileManager
  locator.registerLazySingleton<ProfileManager>(() => ProfileManager());

  /// ReOrderManager
  locator.registerLazySingleton<ReOrderManager>(() => ReOrderManager());

  /// OffersManager
  locator.registerLazySingleton<OffersManager>(() => OffersManager());

  /// OfferDetailsManager
  locator.registerLazySingleton<OfferDetailsManager>(() => OfferDetailsManager());

  /// PhoneVerificationManager
  locator.registerLazySingleton<PhoneVerificationManager>(() => PhoneVerificationManager());

  /// NotificationsManager
  locator.registerLazySingleton<NotificationsManager>(() => NotificationsManager());

  /// DeleteUserManager
  locator.registerLazySingleton<DeleteUserManager>(() => DeleteUserManager());

  /// TwitterSignInService
  // locator.registerLazySingleton<TwitterSignInService>(
  //     () => TwitterSignInService());

  /// GoogleSignInService
  // locator
  // .registerLazySingleton<GoogleSignInService>(() => GoogleSignInService());

  /// FacebookSignInService
  // locator.registerLazySingleton<FacebookSignInService>(
  //     () => FacebookSignInService());
}
