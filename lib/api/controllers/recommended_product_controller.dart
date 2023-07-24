import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/home_api_controller.dart';
import 'package:handcrafts/api/models/all_products.dart';

// 3- controllers get the response from repos and then processing it to models(objects)
class RecommendedProductControllers extends GetxController{
 /* final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductControllers({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];

  // a simple method to return the list from ui, because the above one is private
  List<dynamic> get recommendedProductList => _recommendedProductList;*/

  final HomeApiController _apiController = HomeApiController();
  RxList<AllProducts> _recommendedProductList = <AllProducts>[].obs;

  // a simple method to return the list from ui, because the above one is private
  List<AllProducts> get recommendedProductList => _recommendedProductList;
  RxBool _isLoaded = false.obs;
  bool get isLoaded  => _isLoaded.value;

  @override
  void onInit(){
    getRecommendedProductList();
    super.onInit();
  }

  Future<void> getRecommendedProductList() async{
    print('ggggggggggkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
    _isLoaded.value = true;
    var productsList = await _apiController.showHome();
    _recommendedProductList.value = productsList.where((element) => element.rating >= 4 ).toList();
    print('++++++++++++++$_recommendedProductList+++++++++++++');
    _isLoaded.value = false;
    update();
    /*// response is json
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode == 200){
      print('got products');
      _recommendedProductList = [];
      // it takes a list of objects (food/products)
      // response.body is a json(map)
      // .products => is to access _products
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      print('{$_recommendedProductList}');
      _isLoaded = true;
      update(); // instead of setState(){}
    }else{

    }*/
  }
}