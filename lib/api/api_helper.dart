import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:handcrafts/api/get/home_getx_controller.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/repository/cart_repo.dart';
import '../api/controllers/cart_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper{

  Map<String,String> get headers {
    var headers = {
      'Accept' : 'application/json',
    };

    if (SharedPrefController().loggedIn){
      headers['Authorization'] = 'Bearer TOKEN';
    }
    return headers;
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false; // No internet connection
    } else {
      return true; // Internet connection is available
    }
  }

}

// this method is called on main method for reloading data
Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
/*
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
*/

  //repos
// تم تخزين ApiClient فوق في getX , فاحنا بنستدعيها من getX باستخدام Get.find()0
  /* Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));*/
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  //controllers
/*  Get.lazyPut(() => PopularProductControllers(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductControllers(recommendedProductRepo: Get.find()));*/
  Get.lazyPut(() => CartController(cartRepo: Get.find()));

}