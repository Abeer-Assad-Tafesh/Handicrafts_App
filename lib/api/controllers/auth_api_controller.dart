import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/api_settings.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:http/http.dart' as http;
import 'package:handcrafts/api/models/user.dart';

class AuthApiController {
  UserApi? user;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> register({required UserApi user}) async {
    var url = Uri.parse(ApiSettings.register);
    var response = await http.post(url, body: {
      'name': user.name,
      'email': user.email,
      'password': user.password,
      'phone_number': user.phoneNumber,
      'type_user': user.typeUser,
    });

    if (response.statusCode == 201) {
      Get.snackbar('تم إنشاء الحساب بنجاح ..',
          'سجل دخولك مرة أخرى لتتمتع بالتسوق داخل التطبيق',
          colorText: kPrimaryColor);
      return true;
    } else if (response.statusCode == 422) {
      Get.snackbar('خطأ!', '${jsonDecode(response.body)['message']}',
          colorText: Colors.red);
      return false;
    } else {
      Get.snackbar('حدث خطأ ما!', 'فشل إنشاء الحساب', colorText: Colors.red);
      return false;
    }
  }


  Future<bool> login({required String email, required String password}) async {
    var url = Uri.parse(ApiSettings.login);
    var response = await http.post(url, body: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      //TODO: SHARED PREFERENCES - SAVE LOGGED IN USER DATA
      var jsonUser = jsonDecode(response.body)['user'];
      var jsonToken = jsonDecode(response.body)['token'];
      user = UserApi.fromJson(jsonUser);
      SharedPrefController().savePassword(password: password);
      SharedPrefController().save(user: user!, token: jsonToken);

      Get.snackbar('أهلا بك...', 'تم تسجيل الدخول بنجاح',
          colorText: kPrimaryColor);
      return true;
    } else if (response.statusCode == 401) {
      Get.snackbar('عذراً!', '${jsonDecode(response.body)['message']}',
          colorText: Colors.red);
      return false;
    } else {
      Get.snackbar('حدث خطأ ما!', 'فشل تسجيل الدخول', colorText: Colors.red);
      return false;
    }
  }


  Future<bool> logout() async {
    var url = Uri.parse(ApiSettings.logout);
    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
      HttpHeaders.acceptHeader: 'application/json'
    });
    // 401 لما تكون token expired
    if (response.statusCode == 200 || response.statusCode == 401) {
      await _firebaseLogout();
      SharedPrefController().clear();
      return true;
    }
    return false;
  }


  Future<void> _firebaseLogout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error during logout: $e');
      Get.snackbar('حدث خطأ ما!', 'فشل تسجيل الخروج من Firebase', colorText: Colors.red);
    }
  }


  Future<UserApi?> getProfile() async {
    var url = Uri.parse(ApiSettings.getProfile);
    var response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: SharedPrefController().token,
          HttpHeaders.acceptHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      var jsonUser = jsonDecode(response.body)['data'];
      // var userImage = jsonDecode(response.body)['data']['profile']['image_url'];
      UserApi user = UserApi.fromJson(jsonUser);
      /*Get.snackbar('نجح', '${jsonDecode(response.body)['message']}',
          colorText: kPrimaryColor);*/
      return user;
    } else {
     /* Get.snackbar('حدث خطأ ما777!', '${jsonDecode(response.body)['message']}',
          colorText: Colors.red);*/
      return null;
    }
  }


  Future<bool> updateUserProfile({required UserApi user,}) async {
    var url = Uri.parse(ApiSettings.updateProfile);
    var response = await http.post(url, body: {
      'name': user.name,
      'email': user.email,
      'image_url': user.profile?.imgProfile,
      'phone_number': user.phoneNumber,
    }, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
      HttpHeaders.acceptHeader: 'application/json',
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      Get.snackbar('حدث خطأ!', '${jsonDecode(response.body)['message']}',
          colorText: Colors.red);
      return false;
    }
  }


  Future<bool> forgetPassword({required String email}) async {
    var url = Uri.parse(ApiSettings.forgetPassword);
    var response = await http.post(url, body: {
      'email': email,
    });
    if (response.statusCode == 200) {

      return true;
    } else {
      Get.snackbar('حدث خطأ ما8888!', '${jsonDecode(response.body)['message']}',
          colorText: Colors.red);
      return false;
    }
  }


  Future<bool> resetForgetPassword({
    required String email,
    required String code,
    required String password,
  }) async {
    var url = Uri.parse(ApiSettings.resetForgetPassword);
    var response = await http.post(url, body: {
      'email': email,
      'code': code,
      'password': password,
      'password_confirmation': password,
    }, headers: {
      HttpHeaders.acceptHeader: 'application/json'
    });
    if (response.statusCode == 200) {
      Get.snackbar('تم إعادة تعيين كلمة المرور بنجاح', '${jsonDecode(response.body)['message']}',
          colorText: kPrimaryColor);
      return true;
    } else {
      Get.snackbar('حدث خطأ ما555!', '${jsonDecode(response.body)['message']}',
          colorText: Colors.red);
      return false;
    }
  }


  Future<bool> resetPassword({required String newPassword,required String oldPassword,}) async {
    var url = Uri.parse(ApiSettings.updateProfilePassword);
    var response = await http.post(url, body: {
      'current_password': oldPassword,
      'password': newPassword,
      'password_confirmation': newPassword,
    }, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
      HttpHeaders.acceptHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }




}
