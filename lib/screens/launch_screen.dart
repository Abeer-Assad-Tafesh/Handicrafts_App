import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:handcrafts/firebase/fb_notifications.dart';
import '../api/controllers/popular_product_controller.dart';
import '../api/controllers/recommended_product_controller.dart';
import '../api/get/auth_getx_controller.dart';
import '../api/get/common_question_getx_controller.dart';
import '../api/get/favorite_product_getx_controller.dart';
import '../api/get/order_getx_controller.dart.dart';
import '../api/get/store_getx_controller.dart.dart';
import '../api/get/who_us_getx_controller.dart';
import '../prefs/shared_pref_controller.dart';


class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> with FbNotifications {

  final PopularProductControllers _popularProductControllers = Get.put(PopularProductControllers());
  final RecommendedProductControllers _recommendedProductControllers = Get.put(RecommendedProductControllers());
  final StoreGetXController _storeGetXController = Get.put(StoreGetXController());
  final AuthGetXController _authGetXController = Get.put(AuthGetXController());
  final CommonQuestionGetXController _getXController = Get.put(CommonQuestionGetXController());
  final WhoUsGetXController _whoUsGetXController = Get.put(WhoUsGetXController());
  final FavoriteGetXController _favoriteGetXController =  Get.put(FavoriteGetXController());
  final OrderGetXController _orderGetXController =  Get.put(OrderGetXController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //FCM Messaging
    requestNotificationPermissions();
    initializeForegroundNotificationForAndroid();
    manageNotificationAction();

    Future.delayed(const Duration(seconds: 2), () {
     var route =  SharedPrefController().loggedIn ?
      SharedPrefController().typeUser == 'buyer' ? '/out_boarding_screen'
          : SharedPrefController().storeExists ? '/basic_seller_screens' : '/add_store_page'
      : '/out_boarding_screen';
      Navigator.pushReplacementNamed(context, route);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/bg_screens.png' ,width: double.infinity,fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Center(
              child: SizedBox(
                height: 160.h,
                width: 160.w,
                child: SvgPicture.asset('assets/images/logo_image.svg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
