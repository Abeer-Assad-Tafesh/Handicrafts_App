import 'dart:convert';

import 'package:handcrafts/api/api_helper.dart';
import 'package:handcrafts/api/api_settings.dart';
import 'package:handcrafts/api/models/product.dart';
import 'package:handcrafts/api/models/home_response.dart';
import 'package:http/http.dart' as http;

class FavoriteProductsApiController with ApiHelper{

  Future<List<Product>> showFavorite() async{
    var url = Uri.parse(ApiSettings.favorite);
    var response = await http.get(url, headers: headers);

    if(response.statusCode == 200){
      var productJsonList = jsonDecode(response.body)['data'] as List<dynamic>;
      print('========Success Favorite========');
      return productJsonList
          .map((productData) => Product.fromJson(productData))
          .toList();
    }else{
      print(response.statusCode);
      return [];
    }
  }

  Future<bool> addFavorite({required int id}) async {
    var url = Uri.parse('add/'+ApiSettings.favorite);
    var response = await http.post(
      url,
      body: {'product_id' : id},
      headers: headers,
    );
    print(response.statusCode);
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> removeFavorite({required int id}) async {
    var url = Uri.parse('remove/'+ApiSettings.favorite);
    var response = await http.post(
      url,
      body: {'product_id' : id},
      headers: headers,
    );
    print(response.statusCode);
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }
}