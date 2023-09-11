import 'package:handcrafts/api/models/category.dart';
import 'package:handcrafts/api/models/product_images.dart';
import 'package:handcrafts/api/models/store.dart';

class Product {
  late int id;
  late int storeId;
  late int categoryId;
  late String name;
  late int isVisible;
  late String slug;
  late String description;
  late int quantity;
  late String? opations;
  late int deliveryPeriod;
  late double price;
  late int isFavorite;
  late double? comparePrice;
  late double rating;
  late int featured;
  late String status;
  late String imageUrl;
  late List<ProductImage?>? productImages;
  late Store? store;
  late Category? category;

  Product();

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    categoryId = json['category_id'];
    name = json['name'];
    isVisible = json['is_visible'];
    isFavorite = json['is_favorite'];
    slug = json['slug'];
    description = json['description'];
    quantity = json['quantity'];
    deliveryPeriod = json['delivery_period'];
    opations = json['opations'];
    var priceValue = json['price'];
    if (priceValue is int) {
      price = priceValue.toDouble();
    } else if (priceValue is double) {
      price = priceValue;
    } else {
      price = 0.0;
      throw Exception("Invalid data type for 'price' field");
    }
    comparePrice = json['compare_price'];
    var ratingField = json['rating'];
    if (ratingField is int) {
      rating = ratingField.toDouble();
    } else if (ratingField is double) {
      rating = ratingField;
    } else {
      rating = 0.0;
      throw Exception("Invalid data type for 'rating' field");
    }
    featured = json['featured'];
    status = json['status'];

    imageUrl = json['image_url'];
    productImages = json['product_images'] != null
        ? (json['product_images'] as List)
            .map((imageJson) => ProductImage.fromJson(imageJson))
            .toList()
        : [];
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'category_id': categoryId,
      'name': name,
      'is_visible': isVisible,
      'slug': slug,
      'description': description,
      'quantity': quantity,
      "delivery_period": deliveryPeriod,
      'price': price,
      'compare_price': comparePrice,
      "opations": opations,
      'rating': rating,
      'featured': featured,
      'status': status,
      'image_url': imageUrl,
      'product_images': productImages?.map((image) => image?.toJson()).toList(),
      'store': store?.toJson(),
      'category': category?.toJson(),
    };
  }
}

