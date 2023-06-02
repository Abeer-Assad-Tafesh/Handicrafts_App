import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:handcrafts/constants.dart';
import 'package:handcrafts/controller/popular_product_controller.dart';
import 'package:handcrafts/controller/recommended_product_controller.dart';
import 'package:handcrafts/screens/buyre/basic_buyer/basic_buyer_screens.dart';
import 'package:handcrafts/screens/buyre/basic_buyer/cart_screen.dart';
import 'package:handcrafts/screens/buyre/basic_buyer/favorite_screen.dart';
import 'package:handcrafts/screens/buyre/basic_buyer/register_as_screen.dart';
import 'package:handcrafts/screens/buyre/home/home_screen.dart';
import 'package:handcrafts/screens/buyre/home/sub_home/most_rated_screen.dart';
import 'package:handcrafts/screens/buyre/home/sub_home/most_requested_screen.dart';
import 'package:handcrafts/screens/buyre/home/sub_home/product_details_screen.dart';
import 'package:handcrafts/screens/buyre/login_register/buyer_login_page.dart';
import 'package:handcrafts/screens/buyre/login_register/buyer_register_page.dart';
import 'package:handcrafts/screens/buyre/login_register/login_register_screen.dart';
import 'package:handcrafts/screens/buyre/profile/account_screen.dart';
import 'package:handcrafts/screens/buyre/profile/buyer_info_screen.dart';
import 'package:handcrafts/screens/buyre/profile/buyer_password_edit_screen.dart';
import 'package:handcrafts/screens/buyre/profile/cart_history.dart';
import 'package:handcrafts/screens/buyre/profile/contact_us_screen.dart';
import 'package:handcrafts/screens/buyre/profile/question_screen.dart';
import 'package:handcrafts/screens/buyre/profile/reset_password_screen.dart';
import 'package:handcrafts/screens/buyre/profile/verification_code_screen.dart';
import 'package:handcrafts/screens/buyre/profile/who_us_screen.dart';
import 'package:handcrafts/screens/buyre/shop/about_shop_page.dart';
import 'package:handcrafts/screens/buyre/shop/shop_page.dart';
import 'package:handcrafts/screens/buyre/shop/shop_screen.dart';
import 'package:handcrafts/screens/full_image_screen.dart';
import 'package:handcrafts/screens/hand_loading_image_screen.dart';
import 'package:handcrafts/screens/buyer_notifications_screen.dart';
import 'package:handcrafts/screens/launch_screen.dart';
import 'package:handcrafts/screens/out_boarding_screen.dart';
import 'package:handcrafts/screens/purchase_details_screen.dart';
import 'package:handcrafts/screens/seller/basic_seller/basic_seller_screens.dart';
import 'package:handcrafts/screens/seller/basic_seller/more_screen.dart';
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
import 'helper/h_dependencies.dart' as dep ;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductControllers>().getPopularProductList();
    Get.find<RecommendedProductControllers>().getRecommendedProductList();

    return GetMaterialApp(
      locale:Locale('ar',),
      navigatorKey:Get.key,
      theme: ThemeData(
        accentColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: kPrimaryColor,
          cursorColor: kPrimaryColor,
          selectionHandleColor: kPrimaryColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColor,
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
      initialRoute: '/basic_seller_screens',
      routes: {
        '/launch_screen' : (context) => const LaunchScreen(),
        '/out_boarding_screen' : (context) => const OutBoardingScreen(),
        '/verification_code_screen' : (context) => const VerificationCodeScreen(),
        '/reset_password_screen' : (context) => const ResetPasswordScreen(),

        '/basic_buyer_screens' : (context) => const BasicBuyerScreens(),
        '/home_screen' : (context) => const HomeScreen(),
        '/hand_loading_image_screen' : (context) => const HandLoadingImageScreen(),
        '/buyer_notifications_screen' : (context) => const BuyerNotificationsScreen(),

        '/favorite_screen' : (context) => const FavoriteScreen(),
        '/cart_screen' : (context) => const CartScreen(),
        '/purchase_details_screen' : (context) => const PurchaseDetails(),
        '/register_as_screen' : (context) => const RegisterAsScreen(),
        '/login_register_screen' : (context) => const LoginRegisterScreen(),
        '/buyer_login_page' : (context) => const BuyerLoginPage(),
        '/buyer_register_page' : (context) => const BuyerRegisterPage(),
        '/account_screen' : (context) => const AccountScreen(),
        '/buyer_info_screen' : (context) => const BuyerInfoScreen(),
        '/buyer_history_cart_screen' : (context) => const BuyerCartHistoryScreen(),
        '/buyer_password_edit_screen' : (context) => const BuyerPasswordInfoScreen(),
        '/contact_us_screen' : (context) => const ContactUsScreen(),
        '/who_us_screen' : (context) => const WhoUsScreen(),
        '/question_screen' : (context) => const QuestionScreen(),
        '/most_requested_screen' : (context) => const MostRequestedScreen(),
        '/most_rated_screen' : (context) => const MostRatedScreen(),

        '/product_details_screen' : (context) => ProductDetailsScreen(),
        '/full_image_screen' : (context) => FullImageScreen(),
        '/shop_screen' : (context) => const ShopScreen(),
        '/shop_page' : (context) => const ShopPage(),
        '/about_shop_screen' : (context) => const AboutShopPage(),
        '/sent_successfully_screen' : (context) => const SentSuccessfullyScreen(),

        '/basic_seller_screens' : (context) =>  BasicSellerScreens(),
        // '/home_screen' : (context) => const HomeScreen(),
        // '/favorite_screen' : (context) => const FavoriteScreen(),
        // '/more_screen' : (context) => const MoreScreen(),
        '/seller_notifications_screen' : (context) => const SellerNotificationsScreen(),
        '/request_details_page' :  (context) => const RequestDetailsPage(),
        '/add_product_page' :  (context) => const AddProductPage(),
        '/edit_product_page' :  (context) => const EditProductPage(),

        '/store_info_page' : (context) =>  StoreInfoPage(),
        '/my_store_page' : (context) =>  MyStorePage(),
        '/who_us_seller_page' : (context) =>  WhoUsSellerPage(),
        '/question_seller_page' : (context) =>  QuestionSellerPage(),
        '/contact_us_seller_page' : (context) =>  ContactUsSellerPage(),

      },
    );
  }
}

