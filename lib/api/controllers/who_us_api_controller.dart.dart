import 'dart:convert';

import 'package:handcrafts/api/api_helper.dart';
import 'package:handcrafts/api/api_settings.dart';
import 'package:handcrafts/api/models/product.dart';
import 'package:handcrafts/api/models/question.dart';
import 'package:http/http.dart' as http;

class WhoUsApiController with ApiHelper{

  Future<String> showWhoUs() async{
    var url = Uri.parse(ApiSettings.whoUs);
    var response = await http.get(url, headers: headers);

    if(response.statusCode == 200){
      final whoUs = json.decode(response.body)['data'][0]['value'];
      print('#######${whoUs}');
      return whoUs;
    }else{
      print(response.statusCode);
    }
    return '';
  }
}