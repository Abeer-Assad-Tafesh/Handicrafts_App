import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/home_api_controller.dart';
import 'package:handcrafts/api/controllers/product_api_controller.dart.dart.dart';
import 'package:handcrafts/api/controllers/store_api_controller.dart.dart';
import 'package:handcrafts/api/models/product.dart';
import 'package:handcrafts/api/models/store.dart';

class ProductGetXController extends GetxController {
  RxList<Product?> storeProductsList = <Product>[].obs;
  bool loading = false;
  final ProductApiController _apiController = ProductApiController();

  static ProductGetXController get to => Get.find<ProductGetXController>();

  @override
  void onInit() {
    getStoreProducts();
    super.onInit();
  }

  Future<void> getStoreProducts({int? storeId}) async {
    loading = true;
    storeProductsList.value =
        await _apiController.getStoreProducts(storeId: storeId!);
    loading = false;
    update();
  }

  Future<bool> createProduct({required Product product}) async {
    loading = true;
    bool created = await _apiController.createProduct(product: product);
    loading = false;
    if (created) {
      storeProductsList.add(product);
      update();
    }
    return created;
  }

  Future<bool> updateProduct({required Product product}) async {
    loading = true;
    bool updated = await _apiController.updateProduct(product: product);
    loading = false;
    if (updated) {
      int index =
          storeProductsList.indexWhere((element) => element?.id == product.id);
      if (index != -1) {
        storeProductsList.replaceRange(index, index + 1, [product]);
      }
      update();
    }
    return updated;
  }

  Future<bool> deleteProduct({required int productId}) async {
    loading = true;
    bool updated = await _apiController.deleteProduct(productId: productId);
    loading = false;
    if (updated) {
      int index =
          storeProductsList.indexWhere((element) => element?.id == productId);
      if (index != -1) {
        storeProductsList.removeAt(index);
      }
      update();
    }
    return updated;
  }

  Future<bool> addProductRating(
      {required double rating, required int productId}) async {
    loading = true;
    bool updated =
        await _apiController.saveRating(rating: rating, productId: productId);
    loading = false;
    if (updated) {
      update();
    }
    return updated;
  }

  Future<double> showProductRating({required int productId}) async {
    loading = true;
    var rating = await _apiController.showRating(productId: productId);
    print('rating => $rating');
    loading = false;
    update();
    return rating;
  }
}
