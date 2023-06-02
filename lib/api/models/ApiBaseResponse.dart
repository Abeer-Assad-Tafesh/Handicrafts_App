import 'package:handcrafts/api/models/user.dart';

class ApiBaseResponse {
  late String message;
  late bool success;
  late User user;
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
    user = User.fromJson(json['user']);
    token = json['token'];
  }
}
