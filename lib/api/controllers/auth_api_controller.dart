import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/api_settings.dart';
import 'package:http/http.dart' as http;
import 'package:handcrafts/api/models/user.dart';
import 'package:html/parser.dart' as parser;
import 'package:dio/dio.dart' as dioo;

class AuthApiController {
  Future<bool> register({required User user}) async {
    var url = ApiSettings.register;

    var dio = dioo.Dio();
    dio.options.headers['Postman-Token'] = '<calculated when request is sent>';
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers['Host'] = '<calculated when request is sent>';
    dio.options.headers['User-Agent'] = 'PostmanRuntime/7.32.2';
    dio.options.headers['Accept'] = '*/*';
    dio.options.headers['Accept-Encoding'] = 'gzip, deflate, br';
    dio.options.headers['Connection'] = 'keep-alive';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['lang'] = 'ar';

    var formData = dioo.FormData();

    formData.fields.addAll([
      MapEntry('name', user.name),
      MapEntry('email', user.email),
      MapEntry('password', user.password),
      MapEntry('phone_number', user.phoneNumber??''),
      MapEntry('type_user', user.typeUser),
    ]);

    try {
      var response = await dio.post(url, data: formData);
      if (response.statusCode == 201) {
        Get.snackbar('', 'Registration successful');
        return true;
      } else if (response.statusCode == 400) {
        Get.snackbar('Bad request',  '${response.data}', colorText: Colors.red);
      } else {
        Get.snackbar('', 'Error occurred', colorText: Colors.red);
      }
      print('Response code: ${response.statusCode}');
      print('Response body: ${response.data}');
    } catch (error) {
      print('Error: $error');
    }
    return false;
  }
}
