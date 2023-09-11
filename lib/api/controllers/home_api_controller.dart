import 'dart:convert';
import 'package:handcrafts/api/api_helper.dart';
import 'package:handcrafts/api/api_settings.dart';
import 'package:handcrafts/api/models/product.dart';
import 'package:http/http.dart' as http;

class HomeApiController with ApiHelper{
  Future<List<Product>> showHome() async{
    var url = Uri.parse(ApiSettings.product.replaceFirst('/{id}', ''));
    var response = await http.get(url, headers: headers);

    if(response.statusCode == 200){
      var productJsonList = jsonDecode(response.body)['data']['data'] as List<dynamic>;
      print('========Success showHome() ========');
      return productJsonList
          .where((productData) => productData['is_visible'] == 1)
          .map((productData) => Product.fromJson(productData))
          .toList();
    }else{
      return [];
    }
  }
}