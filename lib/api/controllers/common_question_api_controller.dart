import 'dart:convert';

import 'package:handcrafts/api/api_helper.dart';
import 'package:handcrafts/api/api_settings.dart';
import 'package:handcrafts/api/models/product.dart';
import 'package:handcrafts/api/models/question.dart';
import 'package:http/http.dart' as http;

class CommonQuestionsApiController with ApiHelper{

  Future<List<CommonQuestion>> showCommonQuestions() async{
    var url = Uri.parse(ApiSettings.commonQuestion);
    var response = await http.get(url, headers: headers);

    if(response.statusCode == 200){
      final List<dynamic> jsonData = json.decode(response.body)['data'];
      return jsonData.map((questionJson) => CommonQuestion.fromJson(questionJson)).toList();
    }else{
      print(response.statusCode);
    }
    return [];
  }
}