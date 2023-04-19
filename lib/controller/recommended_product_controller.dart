import 'package:get/get.dart';
import '../data/repository/recommended_product_repo.dart';
import '../models/product_model.dart';

// 3- controllers get the response from repos and then processing it to models(objects)
class RecommendedProductControllers extends GetxController{

  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductControllers({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];

  // a simple method to return the list from ui, because the above one is private
  List<dynamic> get recommendedProductList => _recommendedProductList;
  bool _isLoaded = false;
  bool get isLoaded  => _isLoaded;

  Future<void> getRecommendedProductList() async{
    // response is json
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

    }
  }
}