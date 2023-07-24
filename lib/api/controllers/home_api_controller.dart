import 'dart:convert';

import 'package:handcrafts/api/api_helper.dart';
import 'package:handcrafts/api/api_settings.dart';
import 'package:handcrafts/api/models/all_products.dart';
import 'package:handcrafts/api/models/home_response.dart';
import 'package:http/http.dart' as http;

class HomeApiController with ApiHelper{

  Future<List<AllProducts>> showHome() async{
    var url = Uri.parse(ApiSettings.homeProducts);
    var response = await http.get(url, headers: headers);

    if(response.statusCode == 200){
      var productJsonList = jsonDecode(response.body)['data']['data'] as List<dynamic>;
      print('========Success========');
      return productJsonList
          .map((productData) => AllProducts.fromJson(productData))
          .toList();
    }else{
      print(response.statusCode);
    }
    return [];
  }
}