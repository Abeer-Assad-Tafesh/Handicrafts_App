import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/api_helper.dart';
import 'package:handcrafts/api/get/home_getx_controller.dart';
import 'package:handcrafts/deepLink/dynamic_link_service.dart';
import 'package:handcrafts/firebase/fb_notifications.dart';
import 'package:handcrafts/screens/chat/chat_screen.dart';
import 'package:handcrafts/screens/seller/more_screens/add_store_page.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:handcrafts/screens/buyer/basic_buyer/basic_buyer_screens.dart';
import 'package:handcrafts/screens/buyer/basic_buyer/cart_screen.dart';
import 'package:handcrafts/screens/buyer/basic_buyer/favorite_screen.dart';
import 'package:handcrafts/screens/buyer/basic_buyer/register_as_screen.dart';
import 'package:handcrafts/screens/buyer/home/home_screen.dart';
import 'package:handcrafts/screens/buyer/home/sub_home/most_rated_screen.dart';
import 'package:handcrafts/screens/buyer/home/sub_home/most_requested_screen.dart';
import 'package:handcrafts/screens/buyer/home/sub_home/product_details_screen.dart';
import 'package:handcrafts/screens/login_register/buyer_login_page.dart';
import 'package:handcrafts/screens/login_register/buyer_register_page.dart';
import 'package:handcrafts/screens/login_register/login_register_screen.dart';
import 'package:handcrafts/screens/buyer/profile/account_screen.dart';
import 'package:handcrafts/screens/buyer/profile/buyer_info_screen.dart';
import 'package:handcrafts/screens/buyer/profile/buyer_orders_screen.dart';
import 'package:handcrafts/screens/buyer/profile/buyer_password_edit_screen.dart';
import 'package:handcrafts/screens/buyer/profile/cart_history.dart';
import 'package:handcrafts/screens/buyer/profile/contact_us_screen.dart';
import 'package:handcrafts/screens/buyer/profile/question_screen.dart';
import 'package:handcrafts/screens/buyer/profile/reset_password_screen.dart';
import 'package:handcrafts/screens/buyer/profile/verification_code_screen.dart';
import 'package:handcrafts/screens/buyer/profile/who_us_screen.dart';
import 'package:handcrafts/screens/buyer/shop/about_shop_page.dart';
import 'package:handcrafts/screens/buyer/shop/shop_page.dart';
import 'package:handcrafts/screens/buyer/shop/shop_screen.dart';
import 'package:handcrafts/screens/full_image_screen.dart';
import 'package:handcrafts/screens/hand_loading_image_screen.dart';
import 'package:handcrafts/screens/buyer/buyer_notifications_screen.dart';
import 'package:handcrafts/screens/launch_screen.dart';
import 'package:handcrafts/screens/out_boarding_screen.dart';
import 'package:handcrafts/screens/purchase_details_screen.dart';
import 'package:handcrafts/screens/seller/basic_seller/basic_seller_screens.dart';
import 'package:handcrafts/screens/seller/basic_seller/more_screen.dart';
import 'package:handcrafts/screens/search_page.dart';
import 'package:handcrafts/screens/seller/basic_seller/statistics_screen.dart';
import 'package:handcrafts/screens/seller/more_screens/contact_us_seller_page.dart';
import 'package:handcrafts/screens/seller/more_screens/my_store_page.dart';
import 'package:handcrafts/screens/seller/more_screens/question_seller_page.dart';
import 'package:handcrafts/screens/seller/more_screens/store_info_page.dart';
import 'package:handcrafts/screens/seller/more_screens/who_us_seller_page.dart';
import 'package:handcrafts/screens/seller/product_ops/add_product_page.dart';
import 'package:handcrafts/screens/seller/product_ops/edit_product.dart';
import 'package:handcrafts/screens/seller/product_ops/request_details_page.dart';
import 'package:handcrafts/screens/seller/seller_notifications_screen.dart';
import 'package:handcrafts/screens/sent_successfully_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await init();
  await SharedPrefController().initPref();
  await FbNotifications.initNotifications();
  FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    DynamicLinksService dls = DynamicLinksService();
    dls.initDynamicLinks(dynamicLinkData);
  }).onError((error) {});

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      // Set the status bar background color to white
      statusBarIconBrightness: Brightness.dark,
      // Set the status bar icons' color to black
      statusBarBrightness:
          Brightness.light, // Set the status bar text color to black
    ),
  );

  runApp(
     MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Get.put(HomeGetXController());

    return ScreenUtilInit(
      designSize: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          locale: const Locale('ar'),
          navigatorKey: Get.key,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'PNU',
            // <-- 1
            textTheme: Theme.of(context).textTheme.apply(fontFamily: 'PNU'),
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: kPrimaryColor,
              cursorColor: kPrimaryColor,
              selectionHandleColor: kPrimaryColor,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar'),
          ],
          initialRoute: '/launch_screen' , // SharedPrefController().loggedIn ? '/basic_buyer_screens' : '/login_register_screen',

          routes: {
            '/launch_screen': (context) => const LaunchScreen(),
            '/out_boarding_screen': (context) => const OutBoardingScreen(),
            '/verification_code_screen': (context) => VerificationCodeScreen(),
            '/reset_password_screen': (context) => ResetPasswordScreen(),

            '/basic_buyer_screens': (context) => const BasicBuyerScreens(),
            '/home_screen': (context) => const HomeScreen(),
            '/hand_loading_image_screen': (context) =>
                const HandLoadingImageScreen(),
            '/buyer_notifications_screen': (context) =>
                const BuyerNotificationsScreen(),

            '/favorite_screen': (context) => const FavoriteScreen(),
            '/cart_screen': (context) => const CartScreen(),
            '/purchase_details_screen': (context) => PurchaseDetails(),
            // '/register_as_screen' : (context) => const RegisterAsScreen(),
            '/login_register_screen': (context) => const LoginRegisterScreen(),
            '/buyer_login_page': (context) => const BuyerLoginPage(),
            '/buyer_register_page': (context) => const BuyerRegisterPage(),
            '/account_screen': (context) => AccountScreen(),
            '/buyer_info_screen': (context) => BuyerInfoScreen(),
            '/buyer_orders_screen': (context) => const BuyerOrdersScreen(),
            // '/buyer_history_cart_screen': (context) => const BuyerCartHistoryScreen(),
            '/buyer_password_edit_screen': (context) =>
                const BuyerPasswordInfoScreen(),
            '/contact_us_screen': (context) => const ContactUsScreen(),
            '/who_us_screen': (context) => const WhoUsScreen(),
            '/question_screen': (context) => const QuestionScreen(),
            '/most_requested_screen': (context) => const MostRequestedScreen(),
            '/most_rated_screen': (context) => const MostRatedScreen(),

            '/product_details_screen': (context) =>
                const ProductDetailsScreen(),
            '/full_image_screen': (context) => FullImageScreen(),
            '/shop_screen': (context) => ShopScreen(),
            '/shop_page': (context) => ShopPage(),
            '/about_shop_screen': (context) => AboutShopPage(),
            '/sent_successfully_screen': (context) =>
                const SentSuccessfullyScreen(),

            '/basic_seller_screens': (context) => BasicSellerScreens(),
            // '/home_screen' : (context) => const HomeScreen(),
            // '/favorite_screen' : (context) => const FavoriteScreen(),
            // '/more_screen' : (context) => const MoreScreen(),
            '/seller_notifications_screen': (context) =>
                const SellerNotificationsScreen(),
            '/request_details_page': (context) => const RequestDetailsPage(),
            '/add_product_page': (context) => const AddProductPage(),
            '/edit_product_page': (context) => EditProductPage(),

            '/search_screen': (context) => SearchScreen(),

            '/store_info_page': (context) => const StoreInfoPage(),
            '/add_store_page': (context) => const AddStorePage(),
            '/my_store_page': (context) => const MyStorePage(),
            '/who_us_seller_page': (context) => const WhoUsSellerPage(),
            '/question_seller_page': (context) => const QuestionSellerPage(),
            '/contact_us_seller_page': (context) => const ContactUsSellerPage(),

            '/chat_screen': (context) => ChatScreen(),
          },
        );
      },
    );
  }
}
