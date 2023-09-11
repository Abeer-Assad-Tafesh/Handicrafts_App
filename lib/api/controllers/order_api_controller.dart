import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/api_helper.dart';
import 'package:handcrafts/api/api_settings.dart';
import 'package:handcrafts/api/models/order.dart';
import 'package:handcrafts/api/models/store.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants.dart';

class OrderApiController with ApiHelper {

  Future<List<Orderr>> showOrders() async {
    var url = Uri.parse(ApiSettings.order.replaceFirst('/{id}', ''));

    if(SharedPrefController().craftsmanStoreId.isEmpty ){
      return [];
    }
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var ordersJsonList = jsonDecode(response.body)['data']['data'];
      return ordersJsonList
          .map<Orderr>((orderData) => Orderr.fromJson(orderData))
          .where((order) => order.storeId ==
          int.parse(SharedPrefController().craftsmanStoreId))
          .toList();
    } else {
      print('showOrders code => ${response.statusCode}');
    }
    return [];
  }

  Future<List<Orderr>> showUserOrders() async {
    var url = Uri.parse(ApiSettings.order.replaceFirst('/{id}', ''));
    print('=====>>>  ${SharedPrefController().id}');
    if(SharedPrefController().id.isEmpty ){
      print('=====>>>  empty');

      return [];
    }
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {

      var ordersJsonList = jsonDecode(response.body)['data']['data'];
      return ordersJsonList
          .map<Orderr>((orderData) => Orderr.fromJson(orderData))
          .where((order) => order.userId == int.parse(SharedPrefController().id))
          .toList();
    } else {
      print('showOrders code => ${response.statusCode}');
    }
    return [];
  }

  Future<Orderr?> getOrder(int orderId) async {
    var url =
        Uri.parse(ApiSettings.order.replaceFirst('{id}', orderId.toString()));
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var orderData = jsonDecode(response.body)['data'];
      // print('========Success========');
      return Orderr.fromJson(orderData);
    } else {
      print('get order code => ${response.statusCode}');
    }
    return null;
  }

  Future<bool> addOrder(List<Orderr> orders) async {
    print('iam here 4 ${orders.length}');
    bool success = true;
    var url = Uri.parse(ApiSettings.order.replaceFirst('/{id}', ''));

    for (int x = 0; x < orders.length; x++) {
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);

      // Add form fields
      request.fields['user_id'] = orders[x].userId.toString();
      request.fields['point_id'] = '1';
      request.fields['store_id'] = orders[x].storeId.toString();
      request.fields['total'] = orders[x].total.toString();
      request.fields['payment_method'] = 'عند الاستلام';
      request.fields['payment_status'] = 'paid';
      request.fields['order_status'] = 'قيد المراجعة';
      request.fields['address'] = orders[x].address??'';
      request.fields['delivery_date'] = orders[x].deliveryDate??'';
      request.fields['delivery_time'] = orders[x].deliveryTime??'';

      var response = await request.send();
      if (response.statusCode == 200) {
        print('iam here 5');
        var responseData = await response.stream.toBytes();
        var orderId = jsonDecode(utf8.decode(responseData))['data']['id'];

        print('${orders[x].orderItems![0].productName}');
        for (int i = 0; i < orders[x].orderItems!.length; i++) {
          bool imagesAdded = await addOrderItems(orders[x], orderId, i);
          if (!imagesAdded) {
            Get.snackbar('فشل', 'مشكلة في إرسال الصور',
                colorText: Colors.red);
            break;
          }
        }
        Get.snackbar('نجحت العملية', 'تم إرسال الطلب بنجاح',
            colorText: kPrimaryColor);
        return true;
      } else {
        print('add order code => ${response.statusCode}  ${jsonDecode(utf8.decode(await response.stream.toBytes()))['message']}');
        success = false;
        print(success);
        print('iam here 6');
        break;
      }
    }
    return success;
  }

  Future<bool> addOrderItems(Orderr order, int orderId, int index) async {
    var url = Uri.parse(ApiSettings.orderItems);
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);

    // Add form fields
    request.fields['order_id'] = orderId.toString();
    request.fields['product_id'] = order.orderItems![index].productId.toString();
    request.fields['quantity'] = order.orderItems![index].quantity.toString();
    request.fields['price'] = order.orderItems![index].price.toString();
    request.fields['discount'] = '0';
    request.fields['product_name'] = order.orderItems![index].productName!;

    var response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      print('delete order code => ${response.statusCode}');
    }
    return false;
  }

  Future<bool> deleteOrder(int orderId) async {
    var url =
    Uri.parse(ApiSettings.order.replaceFirst('{id}', orderId.toString()));
    var response = await http.delete(url, headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      print('delete order code => ${response.statusCode}');
    }
    return false;
  }

  Future<bool> changeOrderState(int orderId, String state) async {
    print('$orderId $state');
    var url =
    Uri.parse(ApiSettings.updateOrderStatus.replaceFirst('{id}', orderId.toString()));
    var response = await http.put(url,
        body: {
          'order_status': state,
        },
        headers: headers);

    if (response.statusCode == 200) {
      Get.snackbar('نجح التحديث', 'تم تحديث الطلب بنجاح',
          colorText: kPrimaryColor);
      return true;
    } else {
      print('update order code => ${response.statusCode}');
    }
    return false;
  }


}
