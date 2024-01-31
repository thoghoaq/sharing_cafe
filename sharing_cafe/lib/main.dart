import 'dart:io';
import 'dart:async';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:sharing_cafe/controller/auth_controller.dart';
import 'package:sharing_cafe/controller/splash_controller.dart';
import 'package:sharing_cafe/controller/theme_controller.dart';
import 'package:sharing_cafe/data/model/body/notification_body.dart';
import 'package:sharing_cafe/helper/responsive_helper.dart';
import 'package:sharing_cafe/helper/route_helper.dart';
import 'package:sharing_cafe/theme/dark_theme.dart';
import 'package:sharing_cafe/theme/light_theme.dart';
import 'package:sharing_cafe/util/app_constants.dart';
// import 'package:sharing_cafe/view/screens/auth/sign_in_screen.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:get/get.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'helper/get_di.dart' as di;

Future<void> main() async {
  if(ResponsiveHelper.isMobilePhone()) {
    HttpOverrides.global = MyHttpOverrides();
  }
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  // if(GetPlatform.isWeb){
  //   await Firebase.initializeApp(options: const FirebaseOptions(
  //       apiKey: "AIzaSyDFN-73p8zKVZbA0i5DtO215XzAb-xuGSE",
  //       authDomain: "ammart-8885e.firebaseapp.com",
  //       databaseURL: "https://ammart-8885e-default-rtdb.firebaseio.com",
  //       projectId: "ammart-8885e",
  //       storageBucket: "ammart-8885e.appspot.com",
  //       messagingSenderId: "1000163153346",
  //       appId: "1:1000163153346:web:4f702a4b5adbd5c906b25b",
  //       measurementId: "G-L1GNL2YV61"
  //   ));

  //   MetaSEO().config();
  // }
  // await Firebase.initializeApp();
  await di.init();


  //CHECK NOTIFICATION KHI KHỞI CHẠY APP/////////////////////////////////////////
  //NHỚ SỬA MODEL NotificationBody


  NotificationBody? body;
  // try {
  //   if (GetPlatform.isMobile) {
  //     final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
  //     if (remoteMessage != null) {
  //       body = NotificationHelper.convertNotification(remoteMessage.data);
  //     }
  //     await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  //     FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  //   }
  // }catch(_) {}

  // if (ResponsiveHelper.isWeb()) {
  //   await FacebookAuth.instance.webAndDesktopInitialize(
  //     appId: "380903914182154",
  //     cookie: true,
  //     xfbml: true,
  //     version: "v15.0",
  //   );
  // }
  runApp(MyApp(body: body));
}

class MyApp extends StatefulWidget {
  final NotificationBody? body;
  const MyApp({Key? key, required this.body}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    _route();
  }

  void _route() async {
    // if(GetPlatform.isWeb) {
      // await Get.find<SplashController>().initSharedData();
 
      // if(!Get.find<AuthController>().isLoggedIn()) {
      //   await Get.find<AuthController>().guestLogin();
      // }
      // if((Get.find<AuthController>().isLoggedIn() || Get.find<AuthController>().isGuestLoggedIn()) && Get.find<SplashController>().cacheModule != null) {
      //   Get.find<CartController>().getCartDataOnline();
      // }
    // }
    // Get.find<SplashController>().getConfigData(loadLandingData: GetPlatform.isWeb).then((bool isSuccess) async {
    //   if (isSuccess) {
    //     if (Get.find<AuthController>().isLoggedIn()) {
    //       Get.find<AuthController>().updateToken();
    //       if(Get.find<SplashController>().module != null) {
    //         await Get.find<WishListController>().getWishList();
    //       }
    //     }
    //   }
    // });
  }

  @override
Widget build(BuildContext context) {
  return GetBuilder<ThemeController>(builder: (themeController) {
    return GetBuilder<SplashController>(builder: (splashController) {
      return 
      // (GetPlatform.isWeb && splashController.configModel == null) ? const SizedBox() : 
      GetMaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        navigatorKey: Get.key,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
        ),
        theme: themeController.darkTheme ? dark() : light(),
        locale: Get.deviceLocale,
        // fallbackLocale: Locale(AppConstants.languages[0].languageCode!, AppConstants.languages[0].countryCode),
        initialRoute: GetPlatform.isWeb ? RouteHelper.getInitialRoute() : RouteHelper.getSplashRoute(widget.body),
        getPages: RouteHelper.routes,
        defaultTransition: Transition.topLevel,
        transitionDuration: const Duration(milliseconds: 500),
        builder: (BuildContext context, widget) {
          return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1), child: Material(
            child: Stack(children: [

              widget!,

              GetBuilder<SplashController>(builder: (splashController){
                  return const SizedBox();
              })
            ]),
          ));
        },
      );
    });
  });
}

}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}