import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:phsar_muslim/provider/facebook_login_provider.dart';
import 'package:phsar_muslim/provider/featured_deal_provider.dart';
import 'package:phsar_muslim/provider/google_sign_in_provider.dart';
import 'package:phsar_muslim/provider/home_category_product_provider.dart';
import 'package:phsar_muslim/provider/location_provider.dart';
import 'package:phsar_muslim/provider/top_seller_provider.dart';
import 'package:phsar_muslim/provider/wallet_transaction_provider.dart';
import 'package:phsar_muslim/view/screen/compare/controller/compare_controller.dart';
import 'package:phsar_muslim/view/screen/order/order_details_screen.dart';
import 'package:phsar_muslim/provider/auth_provider.dart';
import 'package:phsar_muslim/provider/brand_provider.dart';
import 'package:phsar_muslim/provider/cart_provider.dart';
import 'package:phsar_muslim/provider/category_provider.dart';
import 'package:phsar_muslim/provider/chat_provider.dart';
import 'package:phsar_muslim/provider/coupon_provider.dart';
import 'package:phsar_muslim/provider/localization_provider.dart';
import 'package:phsar_muslim/provider/notification_provider.dart';
import 'package:phsar_muslim/provider/onboarding_provider.dart';
import 'package:phsar_muslim/provider/order_provider.dart';
import 'package:phsar_muslim/provider/profile_provider.dart';
import 'package:phsar_muslim/provider/search_provider.dart';
import 'package:phsar_muslim/provider/seller_provider.dart';
import 'package:phsar_muslim/provider/splash_provider.dart';
import 'package:phsar_muslim/provider/support_ticket_provider.dart';
import 'package:phsar_muslim/provider/theme_provider.dart';
import 'package:phsar_muslim/provider/wishlist_provider.dart';
import 'package:phsar_muslim/theme/dark_theme.dart';
import 'package:phsar_muslim/theme/light_theme.dart';
import 'package:phsar_muslim/utill/app_constants.dart';
import 'package:phsar_muslim/view/screen/splash/splash_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'di_container.dart' as di;
import 'helper/custom_delegate.dart';
import 'localization/app_localization.dart';
import 'notification/my_notification.dart';
import 'provider/product_details_provider.dart';
import 'provider/banner_provider.dart';
import 'provider/flash_deal_provider.dart';
import 'provider/product_provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(debug: true , ignoreSsl: true);
  await di.init();
  final NotificationAppLaunchDetails? notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  int? orderID;
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    orderID = (notificationAppLaunchDetails!.payload != null && notificationAppLaunchDetails.payload!.isNotEmpty)
        ? int.parse(notificationAppLaunchDetails.payload!) : null;
  }
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
  final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (remoteMessage != null) {
    orderID = remoteMessage.notification?.titleLocKey != null ? int.parse(remoteMessage.notification!.titleLocKey!) : null;
  }
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  FlutterNativeSplash.remove();

  await MyNotification.initialize(flutterLocalNotificationsPlugin);
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<CategoryProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<HomeCategoryProductProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<TopSellerProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<FlashDealProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<FeaturedDealProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BrandProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BannerProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductDetailsProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OnBoardingProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SearchProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SellerProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CouponProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ChatProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OrderProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<NotificationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<WishListProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CartProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SupportTicketProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<GoogleSignInProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<FacebookLoginProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<WalletTransactionProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CompareProvider>()),
    ],
    child: MyApp(orderId: orderID),
  ));
}

class MyApp extends StatelessWidget {
  final int? orderId;
  const MyApp({Key? key, required this.orderId}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    List<Locale> locals = [];
    for (var language in AppConstants.languages) {
      locals.add(Locale(language.languageCode!, language.countryCode));
    }
    return MaterialApp(
      title: AppConstants.appName,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
      locale: Provider.of<LocalizationProvider>(context).locale,
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackLocalizationDelegate()
      ],
      builder:(context,child){
        return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1), child: child!);
      },
      supportedLocales: locals,
      home: orderId == null ? const SplashScreen() : OrderDetailsScreen(orderId: orderId, isNotification: true),
    );
  }
}

class Get {
  static BuildContext? get context => navigatorKey.currentContext;
  static NavigatorState? get navigator => navigatorKey.currentState;
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}