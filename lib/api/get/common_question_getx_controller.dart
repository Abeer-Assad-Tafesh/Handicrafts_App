
import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/common_question_api_controller.dart';
import 'package:handcrafts/api/models/question.dart';

class CommonQuestionGetXController extends GetxController {
  List<CommonQuestion> questionsList = <CommonQuestion>[];
  bool loading = false;
  final CommonQuestionsApiController _apiController = CommonQuestionsApiController();
  static CommonQuestionGetXController get to => Get.find<CommonQuestionGetXController>();

  @override
  void onInit() {
    showQuestions();
    super.onInit();
  }

  Future<void> showQuestions() async {
    loading = true;
    questionsList = await _apiController.showCommonQuestions();
    loading = false;
    update();
  }
}
