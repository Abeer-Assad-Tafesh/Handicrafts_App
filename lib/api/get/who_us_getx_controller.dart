
import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/common_question_api_controller.dart';
import 'package:handcrafts/api/controllers/who_us_api_controller.dart.dart';
import 'package:handcrafts/api/models/question.dart';

class WhoUsGetXController extends GetxController {
  String? whoUs;
  bool loading = false;
  final WhoUsApiController _apiController = WhoUsApiController();
  static WhoUsGetXController get to => Get.find<WhoUsGetXController>();

  @override
  void onInit() {
    showWhoUs();
    super.onInit();
  }

  Future<void> showWhoUs() async {
    loading = true;
    whoUs = await _apiController.showWhoUs();
    loading = false;
    update();
  }
}
