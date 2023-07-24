import 'package:handcrafts/api/models/all_products.dart';

class Store {
  late int id;
  late String name;
  late String slug;
  late String description;
  late String logoImage;
  late String coverImage;
  late String status;
  late String createdAt;
  late String updatedAt;
  // late List<AllProducts> products;



  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    logoImage = json['logo_image'];
    coverImage = json['cover_image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['description'] = description;
    data['logo_image'] = logoImage;
    data['cover_image'] = coverImage;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

/*
  double storeRating() {
    if (products.isEmpty) {
      return 0.0;
    }

    double totalRating = products.map((product) => product.rating).reduce((a, b) => a + b);
    return totalRating / products.length;
  }*/
}
