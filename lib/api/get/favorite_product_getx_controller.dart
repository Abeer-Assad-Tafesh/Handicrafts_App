
import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/favorite_products_api_controller.dart';
import 'package:handcrafts/api/models/product.dart';

class FavoriteGetXController extends GetxController{
  List<Product> favoriteList = <Product>[];
  bool loading = false;
  final FavoriteProductsApiController _favoriteProductsApiController = FavoriteProductsApiController();
  static FavoriteGetXController get to => Get.find();

  @override
  void onInit() {
    getFavorite();
    super.onInit();
  }

  Future<void> getFavorite() async {
    loading = true;
    favoriteList = await _favoriteProductsApiController.showFavorite();
    loading = false;
    update();
  }

  Future<bool> addFavorite({required Product product}) async {
    bool status = await _favoriteProductsApiController.addFavorite(id: product.id);
    if(status){
      favoriteList.add(product);

      /* if(product.isFavorite){
        favoriteList.removeWhere((element) => element.id == product.id);
      }else{
        product.isFavorite = true;
        favoriteList.add(product);
      }*/
    }
    return status;
  }

  Future<bool> removeFavorite({required Product product}) async {
    bool status = await _favoriteProductsApiController.removeFavorite(id: product.id);
    if(status){
      favoriteList.removeWhere((element) => element.id == product.id);
      /* if(product.isFavorite){
        favoriteList.removeWhere((element) => element.id == product.id);
      }else{
        product.isFavorite = true;
        favoriteList.add(product);
      }*/
    }
    return status;
  }


 /* Future<bool> updateFavorite({required AllProducts product}) async {
    bool status = await _favoriteProductsApiController.updateFavorite(id: product.id);
    if(status){
       if(product.isFavorite){
        favoriteList.removeWhere((element) => element.id == product.id);
      }else{
        product.isFavorite = true;
        favoriteList.add(product);
      }
    }
    return status;
  }*/
}