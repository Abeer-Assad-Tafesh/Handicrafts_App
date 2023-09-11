import 'package:handcrafts/api/models/product.dart';

class OrderItem {
  int? id;
  int? orderId;
  int? productId;
  String? productName;
  int? quantity;
  double? price;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  late Product? product;


  OrderItem(
      {this.id,
        this.orderId,
        this.productId,
        this.productName,
        this.quantity,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    quantity = json['quantity'];
    // price = json['price'];
    var priceValue = json['price'];
    if (priceValue is int) {
      price = priceValue.toDouble();
    } else if (priceValue is double) {
      price = priceValue;
    } else {
      price = 0.0;
      throw Exception("Invalid data type for 'price' field");
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    product = json['product'] != null ?  Product.fromJson(json['product']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['quantity'] = quantity;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}