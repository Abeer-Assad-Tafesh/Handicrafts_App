import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:handcrafts/constants.dart';
import 'package:handcrafts/screens/about_us_page.dart';
import 'package:handcrafts/screens/account_screen.dart';
import 'package:handcrafts/screens/basic_screens.dart';
import 'package:handcrafts/screens/cart_screen.dart';
import 'package:handcrafts/screens/favorite_screen.dart';
import 'package:handcrafts/screens/home_screen.dart';
import 'package:handcrafts/screens/launch_screen.dart';
import 'package:handcrafts/screens/buyer_login_page.dart';
import 'package:handcrafts/screens/login_register_screen.dart';
import 'package:handcrafts/screens/most_rated.dart';
import 'package:handcrafts/screens/most_requested.dart';
import 'package:handcrafts/screens/out_boarding_screen.dart';
import 'package:handcrafts/screens/purchase_details_screen.dart';
import 'package:handcrafts/screens/regiser_as_screen.dart';
import 'package:handcrafts/screens/buyer_register_page.dart';
import 'package:handcrafts/screens/reset_password_screen.dart';
import 'package:handcrafts/screens/sent_successfully_screen.dart';
import 'package:handcrafts/screens/shop_page.dart';
import 'package:handcrafts/screens/shop_screen.dart';
import 'package:handcrafts/screens/verification_code_screen.dart';
import 'package:handcrafts/widgets/app_structure.dart';

void main() {
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
    return MaterialApp(
      theme: ThemeData(
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
        Locale('ar')
      ],
      initialRoute: '/basic_screens',
      routes: {
        '/launch_screen' : (context) => const LaunchScreen(),
        '/out_boarding_screen' : (context) => const OutBoardingScreen(),
        '/verification_code_screen' : (context) => const VerificationCodeScreen(),
        '/reset_password_screen' : (context) => const ResetPasswordScreen(),
        '/basic_screens' : (context) => const BasicScreens(),
        '/home_screen' : (context) => const HomeScreen(),
        '/favorite_screen' : (context) => const FavoriteScreen(),
        '/cart_screen' : (context) => const CartScreen(),
        '/purchase_details_screen' : (context) => const PurchaseDetails(),
        '/register_as_screen' : (context) => const RegisterAsScreen(),
        '/login_register_screen' : (context) => const LoginRegisterScreen(),
        '/buyer_login_page' : (context) => const BuyerLoginPage(),
        '/buyer_register_page' : (context) => const BuyerRegisterPage(),
        '/account_screen' : (context) => const AccountScreen(),
        '/shop_screen' : (context) => const ShopScreen(),
        '/shop_page' : (context) => const ShopPage(),
        '/about_us_page' : (context) => const AboutUsPage(),
        '/most_requested' : (context) => const MostRequested(),
        '/most_rated' : (context) => const MostRated(),
        '/sent_successfully' : (context) => const SentSuccessfullyScreen(),
      },
    );
  }
}

