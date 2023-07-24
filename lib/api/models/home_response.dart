import 'package:handcrafts/api/models/api_base_response.dart';
import 'package:handcrafts/api/models/all_products.dart';

class HomeResponse extends ApiBaseResponse {
  late List<AllProducts> allProducts;

  HomeResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json){
    if (json['data'] != null) {
      allProducts = <AllProducts>[];
      json['data'].forEach((v) {
        allProducts.add(AllProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = allProducts.map((v) => v.toJson()).toList();
    return data;
  }
}