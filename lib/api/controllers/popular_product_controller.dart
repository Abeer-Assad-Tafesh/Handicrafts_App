import 'package:get/get.dart';
import 'package:handcrafts/api/api_helper.dart';
import 'package:handcrafts/api/controllers/home_api_controller.dart';
import 'package:handcrafts/api/models/product.dart';
import 'package:handcrafts/api/controllers/cart_controller.dart';
import '../models/cart_model.dart';
import 'package:http/http.dart' as http;

class PopularProductControllers extends GetxController with ApiHelper{
  final HomeApiController _apiController = HomeApiController();
  late CartController _cart;

  List<Product> _popularProductList = <Product>[];
  List<Product> get popularProductList => _popularProductList;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
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
    _isLoading = true;
    var productsList = await _apiController.showHome();
    _popularProductList = productsList.where((element) => element.featured == 0 ).toList();
    _isLoading = false;
    update();
  }

  // cart work
  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity){
    if ((_inCartSameProductItems + quantity) < 0) {
      // Get.snackbar('ملاحظة', 'لا يمكنك الخصم أكثر',duration: const Duration(seconds: 2));
      if(_inCartSameProductItems > 0){
        _quantity = -_inCartSameProductItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartSameProductItems + quantity) > 20) {
      Get.snackbar('ملاحظة', 'لا يمكنك إضافة أكثر من 20 منتج',duration: const Duration(seconds: 2));
      return 20;
    }else {
      return quantity;
    }
  }

  void initProduct(Product product, CartController cart) {
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

  void addItem(Product product) {
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
      Get.snackbar('تم', 'تم إضافة المنتج بنجاح',duration: const Duration(seconds: 2));
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
