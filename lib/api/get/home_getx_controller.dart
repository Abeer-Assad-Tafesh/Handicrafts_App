import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/home_api_controller.dart';
import 'package:handcrafts/api/models/all_products.dart';

class HomeGetXController extends GetxController {
  RxList<AllProducts> productsList = <AllProducts>[].obs;
  bool loading = false;
  final HomeApiController _apiController = HomeApiController();

  @override
  void onInit() {
    getHome();
    super.onInit();
  }

  Future<void> getHome() async {
    loading = true;
    productsList.value = await _apiController.showHome();
    loading = false;
    update();
  }
}
