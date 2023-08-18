import 'package:handcrafts/api/models/api_base_response.dart';
import 'package:handcrafts/api/models/product.dart';

class HomeResponse extends ApiBaseResponse {
  late List<Product> allProducts;

  HomeResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json){
    if (json['data'] != null) {
      allProducts = <Product>[];
      json['data'].forEach((v) {
        allProducts.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = allProducts.map((v) => v.toJson()).toList();
    return data;
  }
}