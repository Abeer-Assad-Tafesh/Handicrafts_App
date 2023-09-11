import 'dart:convert';
import 'dart:io';

import 'package:handcrafts/api/api_helper.dart';
import 'package:handcrafts/api/api_settings.dart';
import 'package:handcrafts/api/models/product.dart';
import 'package:handcrafts/api/models/home_response.dart';
import 'package:http/http.dart' as http;

import '../../prefs/shared_pref_controller.dart';

class FavoriteProductsApiController with ApiHelper {

  Future<List<Product>> showFavorite() async{
    var url = Uri.parse(ApiSettings.favorite.replaceFirst('product', 'products'));
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
      HttpHeaders.acceptHeader: 'application/json',
    });
    if(response.statusCode == 200){
      var productJsonList = jsonDecode(response.body)['data'] as List<dynamic>;
      print('========Success Favorite========');
      return productJsonList
          .map((productData) => Product.fromJson(productData['product']))
          .toList();
    }else{
      print(response.statusCode);
      print('========Failed Favorite========');
      return [];
    }
  }

/*  Future<List<Product>> showFavorite() async {
    var url = Uri.parse(ApiSettings.product.replaceFirst('/{id}', ''));
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var productJsonList =
          jsonDecode(response.body)['data']['data'] as List<dynamic>;
      print('========Success favorite ========');
      return productJsonList
          .where((productData) => productData['is_favorite'] == 1)
          .map((productData) => Product.fromJson(productData))
          .toList();
    } else {
      return [];
    }
  }*/

  Future<bool> addFavorite({required int id}) async {
    var url =
        Uri.parse(ApiSettings.favorite.replaceFirst('product', 'add/product'));
    var response = await http.post(
      url,
      body: {'product_id': id.toString()},
      headers: {
        HttpHeaders.authorizationHeader: SharedPrefController().token,
        HttpHeaders.acceptHeader: 'application/json',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      print('Add Fav: ${response.statusCode} ${jsonDecode(response.body)['message']}');
      return false;
    }
  }

  Future<bool> removeFavorite({required int id}) async {
    var url = Uri.parse(
        ApiSettings.favorite.replaceFirst('product', 'remove/product'));
    var response = await http.post(
      url,
      body: {'product_id': id.toString()},
      headers: {
        HttpHeaders.authorizationHeader: SharedPrefController().token,
        HttpHeaders.acceptHeader: 'application/json',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      print('Remove Fav: ${response.statusCode} ${jsonDecode(response.body)['message']}');
      return false;
    }
  }
}
