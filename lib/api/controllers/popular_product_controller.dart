import 'package:get/get.dart';
import 'package:handcrafts/api/api_helper.dart';
import 'package:handcrafts/api/controllers/home_api_controller.dart';
import 'package:handcrafts/api/models/all_products.dart';
import 'package:handcrafts/api/controllers/cart_controller.dart';
import '../../models/cart_model.dart';
import 'package:http/http.dart' as http;

// 3- controllers get the response from repos and then processing it to models(objects)
class PopularProductControllers extends GetxController with ApiHelper{
  /*final PopularProductRepo popularProductRepo;
  PopularProductControllers({required this.popularProductRepo});*/

  final HomeApiController _apiController = HomeApiController();

  RxList<AllProducts> _popularProductList = <AllProducts>[].obs;
  // a simple method to return the list from ui, because the above one is private
  List<AllProducts> get popularProductList => _popularProductList;

  late CartController _cart;

  RxBool _isLoaded = false.obs;
  bool get isLoaded => _isLoaded.value;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartSameProductItems = 0;
  int get inCartSameProductItems => _inCartSameProductItems + _quantity;

  @override
  void onInit(){
    getPopularProductList();
    super.onInit();
  }

  Future<void> getPopularProductList() async {
    print('5555kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
    _isLoaded.value = true;
    var productsList = await _apiController.showHome();
    _popularProductList.value = productsList.where((element) => element.featured == 1 ).toList();
    print('========$_popularProductList========');
    _isLoaded.value = false;
    update();
/*
    // response is json
    var response = await http.get(AppConstants.POPULAR_PRODUCT_URI as Uri, headers:headers);
    // Response response = await popularProductRepo.getPopularProductList();
    print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');

    if (response.statusCode == 200) {
      print('got products');
      _popularProductList = [];
      // it takes a list of objects (products)
      // response.body is a json(map)
      // .products => is to access _products
      _popularProductList.addAll(Product.fromJson(response.body as Map<String, dynamic>).products);
      print('$_popularProductList');
      _isLoaded = true;
      update(); // instead of setState(){}
    } else {
      print('not got products ${response.statusCode}');
    }*/
  }

  // we can reuse this below codes in RecommendedProductDetail()
  // cart work
  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
      print('decrement ${quantity.toString()}');
    }
    update();
  }

  int checkQuantity(int quantity){
    if ((_inCartSameProductItems + quantity) < 0) {
      Get.snackbar('note', 'You can\'t reduce more',duration: const Duration(seconds: 2));
      if(_inCartSameProductItems > 0){
        _quantity = -_inCartSameProductItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartSameProductItems + quantity) > 20) {
      Get.snackbar('note', 'You can\'t add more',duration: const Duration(seconds: 2));
      return 20;
    }else {
      return quantity;
    }
  }

  void initProduct(AllProducts product, CartController cart) {
    _quantity = 0;
    _inCartSameProductItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    if (exist) {
      _inCartSameProductItems = _cart.getQuantity(product);
    }
    print('quantity in cart is ${_inCartSameProductItems.toString()}');
  }

  void addItem(AllProducts product) {
    print('============${product.price}');
      _cart.addItemToCart(product, _quantity);
      _quantity = 0;
      _inCartSameProductItems = _cart.getQuantity(product);
    print('quantity in cart is ${_inCartSameProductItems.toString()}');
      _cart.items.forEach((key, value) {
        print('The key is ${value.id.toString()} and the quantity is ${value.quantity.toString()}');
      });
      if(_inCartSameProductItems == 0){
        update();
      }else{
      Get.snackbar('Good', 'product added successfully',duration: const Duration(seconds: 2));
      update();
      }
  }


  //cart icon work
  int get totalItemsInCart{
    return _cart.totalCartItems;
  }

  // cart page

  List<CartModel> get getCartItems{
    return _cart.getItems;
  }

}
