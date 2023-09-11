import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:handcrafts/api/api_helper.dart';
import 'package:handcrafts/api/api_settings.dart';
import 'package:handcrafts/api/models/store.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../get/store_getx_controller.dart.dart';
import '../models/user.dart';

class StoreApiController with ApiHelper {

  Future<List<Store>> showStores() async {
    var url = Uri.parse(ApiSettings.stores.replaceFirst('/{id}', ''));
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var storeJsonList = jsonDecode(response.body)['data'] as List<dynamic>;
      return storeJsonList
          .map((storeData) => Store.fromJson(storeData))
          .toList();
    } else {
      print('showStores code => ${response.statusCode}');
    }
    return [];
  }

  Future<Store?> getStoreInfo(int storeId) async {
    var url = Uri.parse(ApiSettings.stores.replaceFirst('{id}', storeId.toString()));
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var storeData = jsonDecode(response.body)['data'];
      // print('========Success========');
      return Store.fromJson(storeData);
    } else {
      print('showStores code => ${response.statusCode}');
    }
    return null;
  }

  Future<bool> addNewStore(Store store, UserApi user) async {
    var url = Uri.parse(ApiSettings.stores.replaceFirst('/{id}',''));
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);


    request.fields['name'] = user.name;
    request.fields['description'] = store.description!;
    request.fields['phone_whatsapp'] = SharedPrefController().phone;
    request.fields['url_facebook'] = store.urlFacebook?? 'https://ar-ar.facebook.com/';
    request.fields['url_instegram'] = store.urlInstagram?? 'https://ar-ar.facebook.com/';
    request.fields['status'] = 'active';
    request.fields['store_owner'] = store.storeOwner?? '';
    request.fields['category'] = store.category!;
    request.fields['country'] = 'فلسطين';
    request.fields['city'] = 'غزة';
    request.fields['user_id'] = SharedPrefController().craftsmanUserId;
    request.fields['email'] = SharedPrefController().email;

    var imageFileLogo = await http.MultipartFile.fromPath(
        'logo_image', store.logoImage!);
    var imageFileCover = await http.MultipartFile.fromPath(
        'cover_image', store.logoImage!);

    request.files.add(imageFileLogo);
    request.files.add(imageFileCover);

    var response = await request.send();

    if (response.statusCode == 200) {
      Get.snackbar('نجحت الإضافة', 'تم إضافة المتجر بنجاح',colorText: kPrimaryColor,
          duration: const Duration(seconds: 2));
      return true;
    } else {
      Get.snackbar('فشلت الإضافة', 'أعد المحاولة مرة أخرى',
          duration: const Duration(seconds: 2));
      print('${response.statusCode} ${ await response.stream.bytesToString()}');
    }
    return false;
  }

  Future<bool> updateStoreInfo(Store store,UserApi user) async {
    var url = Uri.parse(ApiSettings.updateStore.replaceFirst('{id}',
    SharedPrefController().craftsmanStoreId));

    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);

    print('id :: ${SharedPrefController().craftsmanStoreId}');

    request.fields['name'] = user.name;
    request.fields['id'] = SharedPrefController().craftsmanStoreId;
    request.fields['description'] = store.description!;
    request.fields['phone_whatsapp'] = user.phoneNumber!;
    request.fields['url_facebook'] = store.urlFacebook?? 'https://ar-ar.facebook.com/';
    request.fields['url_instegram'] = store.urlInstagram?? 'https://ar-ar.instagram.com/';
    request.fields['status'] = 'active';
    request.fields['store_owner'] = store.storeOwner?? '';
    request.fields['category'] = store.category!;
    request.fields['country'] = 'فلسطين';
    request.fields['city'] = 'غزة';
    request.fields['user_id'] = SharedPrefController().craftsmanUserId;
    request.fields['email'] = user.email;

    var imageFileLogo = await http.MultipartFile.fromPath(
        'logo_image', store.logoImage!);
    var imageFileCover = await http.MultipartFile.fromPath(
        'cover_image', store.logoImage!);

    request.files.add(imageFileLogo);
    request.files.add(imageFileCover);

    var response = await request.send().timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      Get.snackbar('نجح التعديل', 'تم تعديل معلومات المتجر بنجاح',
          duration: const Duration(seconds: 2));
      return true;
    } else {
      Get.snackbar('فشل التعديل', 'حاول مرة أخرى',
          duration: const Duration(seconds: 2));
      print('${response.statusCode} ${ await response.stream.bytesToString()}');
    }
    return false;
  }
}
