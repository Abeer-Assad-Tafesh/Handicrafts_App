import 'dart:convert';
import 'package:get/get.dart';
import '../../models/cart_model.dart';
import '../../utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

//2- repositories is to call methods from Api client to get response of request
class CartRepo extends GetxService{

  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> storedCart = [];
  List<String> storedHistoryCart = [];

  // below code is to store and get cart data when app closed and then opened again
  void addToCartList(List<CartModel> cartList) {
     /*sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
     return ;*/

    var time = DateTime.now().toString();
    storedCart = [];
    cartList.forEach((element) {
      element.time = time;
      // we need to convert the CartModel/object into (String) because sh.p. accepts only String type
      return storedCart.add(jsonEncode(element));
    });

  }


  // below code is to store checked out cart products in cart history
  void addToCartHistoryList() {

    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      storedHistoryCart =
      sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < storedCart.length; i++) {
      storedHistoryCart.add(storedCart[i]);
    }
    storedCart = [];
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, storedHistoryCart);
  }

  List<CartModel> getCartHistoryList() {

    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      storedHistoryCart =
      sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartHistoryList = [];
    CartModel objectElement;
    storedHistoryCart.forEach((element) {
      objectElement = CartModel.fromJson(jsonDecode(element));
      cartHistoryList.add(objectElement);
    });
    return cartHistoryList;
  }

  void removeHistoryCart(){
    storedCart = [];
    storedHistoryCart = [];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }


}