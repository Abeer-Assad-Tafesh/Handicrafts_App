import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:handcrafts/constants.dart';
import 'package:handcrafts/controller/popular_product_controller.dart';
import 'package:handcrafts/controller/recommended_product_controller.dart';
import 'package:handcrafts/screens/shop/about_shop_page.dart';
import 'package:handcrafts/screens/account/account_screen.dart';
import 'package:handcrafts/screens/basic/basic_screens.dart';
import 'package:handcrafts/screens/account/buyer_info_screen.dart';
import 'package:handcrafts/screens/account/buyer_password_edit_screen.dart';
import 'package:handcrafts/screens/basic/cart_screen.dart';
import 'package:handcrafts/screens/account/contact_us_screen.dart';
import 'package:handcrafts/screens/basic/favorite_screen.dart';
import 'package:handcrafts/screens/full_image_screen.dart';
import 'package:handcrafts/screens/hand_loading_image_screen.dart';
import 'package:handcrafts/screens/home/home_screen.dart';
import 'package:handcrafts/screens/launch_screen.dart';
import 'package:handcrafts/screens/login_register/buyer_login_page.dart';
import 'package:handcrafts/screens/login_register/login_register_screen.dart';
import 'package:handcrafts/screens/home/sub_home/most_rated_screen.dart';
import 'package:handcrafts/screens/home/sub_home/most_requested_screen.dart';
import 'package:handcrafts/screens/notifications_screen.dart';
import 'package:handcrafts/screens/out_boarding_screen.dart';
import 'package:handcrafts/screens/home/sub_home/product_details_screen.dart';
import 'package:handcrafts/screens/purchase_details_screen.dart';
import 'package:handcrafts/screens/account/question_screen.dart';
import 'package:handcrafts/screens/basic/register_as_screen.dart';
import 'package:handcrafts/screens/login_register/buyer_register_page.dart';
import 'package:handcrafts/screens/account/reset_password_screen.dart';
import 'package:handcrafts/screens/sent_successfully_screen.dart';
import 'package:handcrafts/screens/shop/shop_page.dart';
import 'package:handcrafts/screens/shop/shop_screen.dart';
import 'package:handcrafts/screens/account/verification_code_screen.dart';
import 'package:handcrafts/screens/account/who_us_screen.dart';
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
        accentColor: kDefaultColor,
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: kDefaultColor,
          cursorColor: kDefaultColor,
          selectionHandleColor: kDefaultColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: kDefaultColor,
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
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen' : (context) => const LaunchScreen(),
        '/out_boarding_screen' : (context) => const OutBoardingScreen(),
        '/verification_code_screen' : (context) => const VerificationCodeScreen(),
        '/reset_password_screen' : (context) => const ResetPasswordScreen(),
        '/basic_screens' : (context) => const BasicScreens(),
        '/home_screen' : (context) => const HomeScreen(),
        '/hand_loading_image_screen' : (context) => const HandLoadingImageScreen(),
        '/notifications_screen' : (context) => const NotificationsScreen(),

        '/favorite_screen' : (context) => const FavoriteScreen(),
        '/cart_screen' : (context) => const CartScreen(),
        '/purchase_details_screen' : (context) => const PurchaseDetails(),
        '/register_as_screen' : (context) => const RegisterAsScreen(),
        '/login_register_screen' : (context) => const LoginRegisterScreen(),
        '/buyer_login_page' : (context) => const BuyerLoginPage(),
        '/buyer_register_page' : (context) => const BuyerRegisterPage(),
        '/account_screen' : (context) => const AccountScreen(),
        '/buyer_info_screen' : (context) => const BuyerInfoScreen(),
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
      },
    );
  }
}

