import 'dart:convert';
import 'package:get/get.dart';
import '../../utils/app_constant.dart';

// 1- Api client deals with server (get/post requests)  =>  2- repos
class ApiClient extends GetConnect implements GetxService{

  late String token;
  final String appBaseUrl;
  late Map<String,String> _mainHeaders;

  ApiClient({required this.appBaseUrl}){
    // appBaseUrl is stored to getX internally
    baseUrl = appBaseUrl;
    // timeout = const Duration(seconds: 30);
    token = AppConstants.TOKEN;
    _mainHeaders = {
      'Content-type' : 'application/json; charset=UTF-8',
      'Authorization' : 'Bearer $token'
    };
  }

  Future<Response> getData(String uri,) async {
    try{
      Response response =  await get(uri);
      // print('response  => ${response.statusCode}');
      return response;

    }catch(e){
      // print('${e.toString()}    55555555888888');
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}