import 'package:get/get.dart';
import 'package:handcrafts/api/models/product.dart';
import 'package:handcrafts/api/repository/cart_repo.dart';
import '../models/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  bool isLoading = false;
  static CartController get to => Get.find();
  List<CartModel> storedCartItems = [];

  // when press Add to cart btn
  void addItemToCart(Product product, int quantity) {
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
        Get.snackbar('ملاحظة', 'يجب عليك إضافة عنصر واحد على الأقل إلى السلة',
            duration: const Duration(seconds: 2));
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(Product product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(Product product) {
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
    return _items.entries.map((e) => e.value).toList();
  }

  // cart page   // storeId with it's products
  Map<String, List<CartModel>> getItemsByStore() {
    Map<String, List<CartModel>> itemsByStore = {};

    // Iterate through all items in the cart
    _items.forEach((productId, cartModel) {
      // Get the store ID of the product
      String storeId = cartModel.product!.storeId.toString();

      // Check if the store ID already exists in the map
      if (itemsByStore.containsKey(storeId)) {
        // If the store ID exists, add the product to the existing list
        itemsByStore[storeId]!.add(cartModel);
      } else {
        // If the store ID doesn't exist, create a new list and add the product to it
        itemsByStore[storeId] = [cartModel];
      }
    });

    return itemsByStore;
  }


  double get totalCartProductsPrice{
    double total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  void clear(){
    _items = {};
    update();
  }


/*  void addItemsToHistory(){
    isLoading = true;
    cartRepo.addToCartHistoryList();
    clear();
    isLoading = false;
    update();
  }

  List<CartModel> getHistoryCartItems(){
    return cartRepo.getCartHistoryList();
  }

  // remove when logout
  void clearCartHistory(){
    cartRepo.removeHistoryCart();
    update();
  }*/
}
