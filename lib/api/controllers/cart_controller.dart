import 'package:get/get.dart';
import 'package:handcrafts/api/models/all_products.dart';
import 'package:handcrafts/api/repository/cart_repo.dart';
import '../../models/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;

  bool isLoading = false;

  static CartController get to => Get.find();
  List<CartModel> storedCartItems = [];


  // when press Add to cart btn
  void addItemToCart(AllProducts product, int quantity) {
    //if product exists => update it
    if (_items.containsKey(product.id)) {
      int totalQuantity = 0;
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity! + quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product);
      });
      if (totalQuantity <= 0) {
        _items.remove(product.id);
        update();
      }
    } else {
      //if product not exists => create it
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          // print('add item id' + product.id.toString() + ' quantity $quantity');
          return CartModel(
              id: product.id,
              name: product.name,
              price: product.price,
              img: product.imageUrl,
              quantity: quantity,
              isExist: true,
              time: DateTime.now().toString(),
              product: product);
        });
      } else {
        Get.snackbar('Note', 'You should at least add an item to cart',
            duration: const Duration(seconds: 2));
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(AllProducts product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(AllProducts product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  //cart icon work
  int get totalCartItems {
    var totalCartProducts = 0;
    _items.forEach((key, value) {
      totalCartProducts += value.quantity!;
    });
    return totalCartProducts;
  }

  // cart page
  List<CartModel> get getItems {
    // (e) is key and value (int, CartModel) and we need just the objects
    return _items.entries.map((e) => e.value).toList();
  }


  double get totalCartProductsPrice{
    double total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }


  void addItemsToHistory(){
    isLoading = true;
    cartRepo.addToCartHistoryList();
    clear();
    isLoading = false;
    update();
  }

  List<CartModel> getHistoryCartItems(){
    return cartRepo.getCartHistoryList();
  }

  void clear(){
    _items = {};
    update();
  }

  // remove when logout
  void clearCartHistory(){
    cartRepo.removeHistoryCart();
    update();
  }
}
