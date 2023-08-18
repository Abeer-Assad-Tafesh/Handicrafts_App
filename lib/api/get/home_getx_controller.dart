import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/home_api_controller.dart';
import 'package:handcrafts/api/models/product.dart';

class HomeGetXController extends GetxController {
  List<Product> productsList = <Product>[];
  bool loading = false;
  final HomeApiController _apiController = HomeApiController();

  @override
  void onInit() {
    getHome();
    super.onInit();
  }

  Future<void> getHome() async {
    loading = true;
    productsList = await _apiController.showHome();
    loading = false;
    update();
  }
}
