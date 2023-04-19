import 'package:get/get.dart';
import '../controller/cart_controller.dart';
import '../controller/popular_product_controller.dart';
import '../controller/recommended_product_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/cart_repo.dart';
import '../data/repository/popular_product_repo.dart';
import '../data/repository/recommended_product_repo.dart';
import '../utils/app_constant.dart';

// this method is called on main method for reloading data
Future<void> init() async {

Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repos
// تم تخزين ApiClient فوق في getX , فاحنا بنستدعيها من getX باستخدام Get.find()0
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());

  //controllers
  Get.lazyPut(() => PopularProductControllers(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductControllers(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));


}