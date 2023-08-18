import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/auth_api_controller.dart';
import 'package:handcrafts/api/models/user.dart';

class AuthGetXController extends GetxController {
  UserApi? userApi ;
  bool loading = false;
  final AuthApiController _apiController = AuthApiController();

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  Future<void> getProfile() async {
    loading = true;
    userApi = await _apiController.getProfile();
    loading = false;
    update();
  }

  Future<bool> updateProfile(UserApi user) async {
    loading = true;
    bool status = await _apiController.updateUserProfile(user: user);
    loading = false;
    update();
    return status;
  }

}