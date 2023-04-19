import 'package:get/get.dart';
import 'package:handcrafts/controller/cart_controller.dart';
import '../data/repository/popular_product_repo.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';


// 3- controllers get the response from repos and then processing it to models(objects)
class PopularProductControllers extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductControllers({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  // a simple method to return the list from ui, because the above one is private
  List<dynamic> get popularProductList => _popularProductList;

  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartSameProductItems = 0;
  int get inCartSameProductItems => _inCartSameProductItems + _quantity;

  Future<void> getPopularProductList() async {
    // response is json
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print('got products');
      _popularProductList = [];
      // it takes a list of objects (products)
      // response.body is a json(map)
      // .products => is to access _products
      _popularProductList.addAll(Product.fromJson(response.body).products);
      print('$_popularProductList');
      _isLoaded = true;
      update(); // instead of setState(){}
    } else {
      print('not got products ${response.statusCode}');

    }
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

  void initProduct(ProductModel product, CartController cart) {
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

  void addItem(ProductModel product) {
      _cart.addItemToCart(product, _quantity);
      _quantity = 0;
      _inCartSameProductItems = _cart.getQuantity(product);
      _cart.items.forEach((key, value) {
        print('The key is ${value.id.toString()} and the quantity is ${value.quantity.toString()}');
      });
      Get.snackbar('Good', 'product added successfully',duration: const Duration(seconds: 2));
      update();
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
