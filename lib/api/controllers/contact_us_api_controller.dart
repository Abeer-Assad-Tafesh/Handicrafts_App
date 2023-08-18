import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/api_helper.dart';
import '../../prefs/shared_pref_controller.dart';
import '../../utils/constants.dart';
import '../api_settings.dart';
import 'package:http/http.dart' as http;

class ContactUsApiController with ApiHelper{

  Future<bool> sendApiMessage({required String email, required String name, required String message}) async{
    var url = Uri.parse(ApiSettings.contactUs);
    var response = await http.post(url,
        headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
      HttpHeaders.acceptHeader: 'application/json',
    },
    body : {
      'email' : email,
      'name' : name,
      'message' : message,
    });

    if(response.statusCode == 200){
      Get.snackbar('تم إرسال الرسالة بنجاح', 'شكراً لتواصلك .. سيتم الرد بأقرب وقت ممكن',
          colorText: kPrimaryColor);
      return true;
    }else{
      print(response.statusCode);
      Get.snackbar('لم يتم إرسال الرسالة!', 'أعد المحاولة مجدداً',
          colorText: Colors.red);
      return false;
    }
  }

}