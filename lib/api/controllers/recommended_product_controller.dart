import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/home_api_controller.dart';
import 'package:handcrafts/api/models/product.dart';

// 3- controllers get the response from repos and then processing it to models(objects)
class RecommendedProductControllers extends GetxController{

  final HomeApiController _apiController = HomeApiController();
  List<Product> _recommendedProductList = <Product>[];
  List<Product> get recommendedProductList => _recommendedProductList;
  bool _isLoading = false;
  bool get isLoading  => _isLoading;

  @override
  void onInit(){
    getRecommendedProductList();
    super.onInit();
  }

  Future<void> getRecommendedProductList() async{
    _isLoading = true;
    update();
    var productsList = await _apiController.showHome();
    _recommendedProductList = productsList.where((element) => element.rating >= 3 ).toList();
    print('_recommendedProductList ${_recommendedProductList.length}');
    _isLoading = false;
    print('we are here');
    update();
  }
}