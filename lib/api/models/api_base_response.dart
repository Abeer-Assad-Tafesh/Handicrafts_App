import 'package:handcrafts/api/models/user.dart';

class ApiBaseResponse {
  late String message;
  late bool success;
  late UserApi user;
  late String token;

  ApiBaseResponse({
    required this.message,
    required this.success,
    required this.user,
    required this.token,
  });

  ApiBaseResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    user = UserApi.fromJson(json['user']);
    token = json['token'];
  }
}
