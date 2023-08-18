import 'dart:convert';
import 'package:get/get.dart';
import 'package:handcrafts/api/api_helper.dart';
import 'package:handcrafts/api/api_settings.dart';
import 'package:handcrafts/api/models/store.dart';
import 'package:http/http.dart' as http;

class StoreApiController with ApiHelper{

  Future<List<Store>> showStores() async{
    var url = Uri.parse(ApiSettings.stores);
    var response = await http.get(url, headers: headers);

    if(response.statusCode == 200){
      var storeJsonList = jsonDecode(response.body)['data'] as List<dynamic>;
      return storeJsonList
          .map((storeData) => Store.fromJson(storeData))
          .toList();
    }else{
      print('showStores code => ${response.statusCode}');
    }
    return [];
  }

  Future<Store?> getStoreInfo(int storeId) async{
    var url = Uri.parse(ApiSettings.stores.replaceFirst('{id}',storeId.toString() ));
    var response = await http.get(url, headers: headers);

    if(response.statusCode == 200){
      var storeData = jsonDecode(response.body)['data'];
      // print('========Success========');
      return Store.fromJson(storeData);
    }else{
      print('showStores code => ${response.statusCode}');
    }
    return null;
  }


  Future<bool> addNewStore(Store store) async {
    var url = Uri.parse(ApiSettings.stores);
    var response = await http.put(url,
        body: {

        },
        headers: headers
    );
    if(response.statusCode == 200){
      Get.snackbar('نجحت الإضافة', 'تم إضافة المتجر بنجاح',
          duration: const Duration(seconds: 2));
      return true;
    }else{
      Get.snackbar('فشلت الإضافة', 'أعد المحاولة مرة أخرى',
          duration: const Duration(seconds: 2));
      print(response.statusCode);
    }
    return false;
  }

  Future<bool> updateStoreInfo(Store store) async {
    var url = Uri.parse(ApiSettings.stores.replaceFirst('{id}', store.id.toString()));
    var response = await http.put(url,
        body: {

        },
        headers: headers
    );
    if(response.statusCode == 200){
      Get.snackbar('نجح التعديل', 'تم تعديل معلومات المتجر بنجاح',
          duration: const Duration(seconds: 2));
      return true;
    }else{
      Get.snackbar('فشل التعديل', 'حاول مرة أخرى',
          duration: const Duration(seconds: 2));
      print(response.statusCode);
    }
    return false;
  }
}