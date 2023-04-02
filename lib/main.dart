import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:handcrafts/constants.dart';
import 'package:handcrafts/screens/about_shop_page.dart';
import 'package:handcrafts/screens/account_screen.dart';
import 'package:handcrafts/screens/basic_screens.dart';
import 'package:handcrafts/screens/buyer_info_screen.dart';
import 'package:handcrafts/screens/buyer_password_edit_screen.dart';
import 'package:handcrafts/screens/cart_screen.dart';
import 'package:handcrafts/screens/contact_us_screen.dart';
import 'package:handcrafts/screens/favorite_screen.dart';
import 'package:handcrafts/screens/home_screen.dart';
import 'package:handcrafts/screens/launch_screen.dart';
import 'package:handcrafts/screens/buyer_login_page.dart';
import 'package:handcrafts/screens/login_register_screen.dart';
import 'package:handcrafts/screens/most_rated.dart';
import 'package:handcrafts/screens/most_requested.dart';
import 'package:handcrafts/screens/out_boarding_screen.dart';
import 'package:handcrafts/screens/purchase_details_screen.dart';
import 'package:handcrafts/screens/question_screen.dart';
import 'package:handcrafts/screens/register_as_screen.dart';
import 'package:handcrafts/screens/buyer_register_page.dart';
import 'package:handcrafts/screens/reset_password_screen.dart';
import 'package:handcrafts/screens/sent_successfully_screen.dart';
import 'package:handcrafts/screens/shop_page.dart';
import 'package:handcrafts/screens/shop_screen.dart';
import 'package:handcrafts/screens/verification_code_screen.dart';
import 'package:handcrafts/screens/who_us_screen.dart';
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
        Locale('ar')
      ],
      initialRoute: '/contact_us_screen',
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
        '/buyer_info_screen' : (context) => const BuyerInfoScreen(),
        '/buyer_password_edit_screen' : (context) => const BuyerPasswordInfoScreen(),

        '/contact_us_screen' : (context) => const ContactUsScreen(),
        '/shop_screen' : (context) => const ShopScreen(),
        '/shop_page' : (context) => const ShopPage(),
        '/about_shop_screen' : (context) => const AboutShopPage(),
        '/who_us_screen' : (context) => const WhoUsScreen(),
        '/question_screen' : (context) => const QuestionScreen(),
        '/most_requested_screen' : (context) => const MostRequested(),
        '/most_rated_screen' : (context) => const MostRated(),
        '/sent_successfully_screen' : (context) => const SentSuccessfullyScreen(),
      },
    );
  }
}

