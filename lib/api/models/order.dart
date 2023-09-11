import 'package:handcrafts/api/models/order_item.dart';
import 'package:handcrafts/api/models/product.dart';
import 'package:handcrafts/api/models/store.dart';
import 'package:handcrafts/api/models/user.dart';

class Orderr {
  late int? id;
  late int? storeId;
  late int? userId;
  late String? deliveryDate;
  late String? deliveryTime;
  late String? paymentMethod;
  late String? paymentStatus;
  late String? orderStatus;
  late String? address;
  late double? total;
  late String? createdAt;
  late String? updatedAt;
  late List<OrderItem>? orderItems;
  late UserApi? user;
  late Store? store;

  Orderr();

  Orderr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    userId = json['user_id'];
    deliveryDate = json['delivery_date'];
    deliveryTime = json['delivery_time'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    address = json['address'];
    // total = json['total'];
    var priceValue = json['total'];
    if (priceValue is int) {
      total = priceValue.toDouble();
    } else if (priceValue is double) {
      total = priceValue;
    } else {
      total = 0.0;
      throw Exception("Invalid data type for 'price' field");
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['order_items'] != null) {
      orderItems = <OrderItem>[];
      json['order_items'].forEach((v) {
        orderItems!.add( OrderItem.fromJson(v));
      });
    }
    user = json['user'] != null ?  UserApi.fromJson(json['user']) : null;
    store = json['store'] != null ?  Store.fromJson(json['store']) : null;
  }

/*
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['store_id'] = storeId;
    data['user_id'] = userId;
    data['delivery_date'] = deliveryDate;
    data['delivery_time'] = deliveryTime;
    data['payment_method'] = paymentMethod;
    data['payment_status'] = paymentStatus;
    data['total'] = total;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (orderItems != null) {
      data['order_items'] = orderItems!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
*/
}

