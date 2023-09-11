import 'package:handcrafts/api/models/product.dart';

class Store {
  late int? id;
  late String? name;
  late int? userId;
  late String? email;
  late String? description;
  late String? phoneWhatsapp;
  late String? urlFacebook;
  late String? urlInstagram;
  late String? logoImage;
  late String? coverImage;
  late String? status;
  late String? storeOwner;
  late String? category;
  late String? country;
  late String? city;
  late int? deliveryPrice;
  // late List<AllProducts> products;

  Store();

  Store.fromJson(Map<String, dynamic> json) {
    id= json['id'];
    name= json['name'];
    email= json['email'];
    userId= json['user_id'];
    description= json['description'];
    phoneWhatsapp= json['phone_whatsapp'];
    urlFacebook= json['url_facebook'];
    urlInstagram= json['url_instegram'];
    logoImage= json['logo_image'];
    coverImage= json['cover_image'];
    status= json['status'];
    storeOwner = json['store_owner'];
    category = json['category'];
    country = json['country'];
    city = json['city'];
    deliveryPrice= json['delivery_price'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'user_id': userId,
      'description': description,
      'phone_whatsapp': phoneWhatsapp,
      'url_facebook': urlFacebook,
      'url_instegram': urlInstagram,
      'logo_image': logoImage,
      'cover_image': coverImage,
      'status': status,
      'store_owner': storeOwner,
      'delivery_price': deliveryPrice,
      "category": "تطريز",
      "country": "فلسطين",
      "city": "غزة",
    };
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
