import 'package:handcrafts/api/models/api_base_response.dart';
import 'package:handcrafts/api/models/category.dart';
import 'package:handcrafts/api/models/store.dart';

class AllProducts {
  late int id;
  late int storeId;
  late int categoryId;
  late String name;
  late String slug;
  late String description;
  late double price;
  late double comparePrice;
  late double rating;
  late int featured;
  late String status;
  late String imageUrl;
  late List<String> productImages;
  late Store store;
  late Category category;


  AllProducts.fromJson(Map<String, dynamic> json){
    id = json['id'];
    storeId = json['store_id'];
    categoryId = json['category_id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    // price = json['price'];
    // Handle different data types for 'price' field
    var priceValue = json['price'];
    if (priceValue is int) {
      price = priceValue.toDouble(); // Convert int to double
    } else if (priceValue is double) {
      price = priceValue;
    } else {
      // Set a default value or handle the error as per your requirements
      price = 0.0; // Default value
      // Or throw an exception
      throw Exception("Invalid data type for 'price' field");
    }
    var comparePriceField = json['compare_price'];
    if (comparePriceField is int) {
      comparePrice = comparePriceField.toDouble(); // Convert int to double
    } else if (comparePriceField is double) {
      comparePrice = comparePriceField;
    } else {
      // Set a default value or handle the error as per your requirements
      comparePrice = 0.0; // Default value
      // Or throw an exception
      throw Exception("Invalid data type for 'rating' field");
    }
    var ratingField = json['rating'];
    if (ratingField is int) {
      rating = ratingField.toDouble(); // Convert int to double
    } else if (ratingField is double) {
      rating = ratingField;
    } else {
      // Set a default value or handle the error as per your requirements
      rating = 0.0; // Default value
      // Or throw an exception
      throw Exception("Invalid data type for 'rating' field");
    }
    featured = json['featured'];
    status = json['status'];
    imageUrl = json['image_url'];

    if (json['product_images'] != null) {
      productImages = <String>[];
      json['product_images'].forEach((v) {
        productImages.add(v);
      });
    }

    store = Store.fromJson(json['store']);
    category = Category.fromJson(json['category']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['store_id'] = storeId;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['slug'] = slug;
    data['description'] = description;
    data['price'] = price;
    data['compare_price'] = comparePrice;
    data['rating'] = rating;
    data['featured'] = featured;
    data['status'] = status;
    data['image_url'] = imageUrl;
    data['product_images'] = productImages;
    data['store'] = store.toJson();
    data['category'] = category.toJson();
    return data;
  }
}