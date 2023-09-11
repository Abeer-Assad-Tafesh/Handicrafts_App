import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/api_helper.dart';
import 'package:handcrafts/api/api_settings.dart';
import 'package:handcrafts/api/models/product.dart';
import 'package:handcrafts/api/models/home_response.dart';
import 'package:handcrafts/api/models/store.dart';
import 'package:handcrafts/api/models/user.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProductApiController with ApiHelper {
  Future<List<Product>> getStoreProducts({required int storeId}) async {
    var url = Uri.parse(ApiSettings.product.replaceFirst('/{id}', ''));
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var productJsonList =
          jsonDecode(response.body)['data']['data'] as List<dynamic>;
      print('========Success  getStoreProducts ========');
      var storeProductsList = productJsonList
          .map((productData) => Product.fromJson(productData))
          .where((productData) => productData.store?.id == storeId)
          .toList();
      return storeProductsList;
    } else {
      print('GetStoreProduct code => ${response.statusCode}');
      return [];
    }
  }

  Future<bool> createProduct({required Product product}) async {
    var url = Uri.parse(ApiSettings.product.replaceFirst('/{id}', ''));
    var request = http.MultipartRequest('POST', url);

    print('Store id  ${SharedPrefController().craftsmanStoreId}');
    request.fields['store_id'] =
        SharedPrefController().craftsmanStoreId; // تعديل
    request.fields['description'] = product.description;
    request.fields['quantity'] =
        0.toString(); // يجب اضافة خاصية quantity للبرودكت
    request.fields['name'] = product.name;
    request.fields['category_id'] = '1';
    request.fields['price'] = product.price.toString();
    request.fields['delivery_period'] = product.deliveryPeriod.toString();
    request.fields['is_visible'] = '1';

    request.headers[HttpHeaders.authorizationHeader] =
        SharedPrefController().token;
    request.headers[HttpHeaders.acceptHeader] = 'application/json';

    final response = await request.send();
    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      Map<String, dynamic> responseData = jsonDecode(responseString);
      int productId = responseData['data']['id'];
      bool imagesAdded = await addProductImages(
          product: product, productId: productId, requestType: 'POST', imageUrl: ApiSettings.productImages);
      if (imagesAdded) {
        Get.snackbar('نجحت الإضافة', 'تم إضافة المنتج بنجاح',
            colorText: kPrimaryColor);
        return true;
      }
      Get.snackbar('فشلت الإضافة', 'حاول مجدداً', colorText: Colors.red);
      return false;
    } else {
      print(
          '    ${response.statusCode}   ======      ${await response.stream.bytesToString()}');
      Get.snackbar('فشلت الإضافة', 'حاول مجدداً', colorText: Colors.red);
      return false;
    }
  }

  Future<bool> addProductImages(
      {required Product product,
      required int productId,
      required String requestType, required String imageUrl}) async {
    var url = Uri.parse(ApiSettings.productImages);
    var request = http.MultipartRequest(requestType, url);

    int counter = 0;
    request.fields['product_id'] = productId.toString(); // تعديل
    for (int i = 0; i < product.productImages!.length; i++) {
      if (product.productImages?[i]?.imageUrl != null) {
        counter++;
        var imageFile = await http.MultipartFile.fromPath(
            'image_url[$i]', product.productImages![i]!.imageUrl);
        request.files.add(imageFile);
      }
    }

    if (counter == 4) {
      final response = await request.send();
      if (response.statusCode == 200) {
        return true;
      } else {
        print('${response.statusCode}   ======   ${await response.stream.bytesToString()}');
        return false;
      }
    } else if(counter == 0) {
      return true;
    }else if(counter < 4 && counter > 0) {
      Get.snackbar('فشل تحديث الصور', 'لا يمكنك تحديث صورة واحدة، يجب تحديث 4 صور', colorText: Colors.red);
      return false;
    }
    return false;
  }

  Future<bool> updateProduct({required Product product}) async {
    var url = Uri.parse(
        ApiSettings.product.replaceFirst('{id}', product.id.toString()));
    var request = http.Request('PUT', url);

    // Set headers
    request.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    request.headers[HttpHeaders.authorizationHeader] =
        SharedPrefController().token;
    request.headers[HttpHeaders.acceptHeader] = 'application/json';

    // Define the form data
    var formData = {
      'store_id': SharedPrefController().craftsmanStoreId,
      'description': product.description,
      'category id': product.categoryId.toString(),
      'name': product.name,
      'price': product.price.toString(),
      'delivery_period': product.deliveryPeriod.toString(),
    };

    // Encode the form data into a query string
    String queryString = Uri(queryParameters: formData).query;
    url = Uri.parse(url.toString() + '?' + queryString); // Append query string to the URL
    var response = await http.put(url);

    if (response.statusCode == 200) {
      if (product.productImages?.length != null) {
        bool imagesAdded = await addProductImages(
            product: product, productId: product.id, requestType: 'POST', imageUrl: ApiSettings.updateProductImages);
        if (imagesAdded) {
          Get.snackbar('نجح التحديث', 'تم تحديث المنتج بنجاح',
              colorText: kPrimaryColor);
          return true;
        }
      }
      return false;
    } else {
      Get.snackbar('فشل التحديث', 'حاول مجدداً', colorText: Colors.red);
      print('  2  ${response.statusCode}   ======      ${response.body}');
      return false;
    }
  }

  Future<bool> deleteProduct({required int productId}) async {
    var url = Uri.parse(
        ApiSettings.product.replaceFirst('{id}', productId.toString()));
    var response = await http.delete(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: SharedPrefController().token,
    });
    if (response.statusCode == 200) {
      Get.snackbar('نجح الحذف', 'تم حذف المنتج بنجاح',
          colorText: kPrimaryColor);
      return true;
    } else {
      print('${response.statusCode}');
      Get.snackbar('فشل الحذف', '${jsonDecode(response.body)['message']}',
          colorText: kPrimaryColor);
      return false;
    }
  }

  Future<bool> saveRating(
      {required double rating, required int productId}) async {
    var url = Uri.parse(
        ApiSettings.rateProduct.replaceFirst('{id}', productId.toString()));
    final response = await http.post(url, body: {
      'rate_value': rating.toString(),
    }, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: SharedPrefController().token,
    });
    if (response.statusCode == 200) {
      Get.snackbar('شكراً لك', 'سيتم أخذ تقييمك بالاعتبار',
          colorText: Colors.black);
      return true;
    } else {
      Get.snackbar('حدث خطأ', 'لم يتم التقييم', colorText: Colors.black);
      return false;
    }
  }

  Future<double> showRating({required int productId}) async {
    var url = Uri.parse(ApiSettings.rateProduct + '/?id=$productId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      // print('[ Rating => ${double.parse(responseData['data']['data'][0]['rating'])}');
      double productRating =
          responseData['data']['data'][0]['rating'].toDouble();
      return productRating;
    } else {
      print('5555555 ${response.statusCode}');
      throw Exception('Failed to load product rating');
    }
  }
}
