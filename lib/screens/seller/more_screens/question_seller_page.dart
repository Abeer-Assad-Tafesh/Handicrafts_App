import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/get/common_question_getx_controller.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import '../../../widgets/question_container.dart';

class QuestionSellerPage extends StatefulWidget {
  const QuestionSellerPage({Key? key}) : super(key: key);

  @override
  State<QuestionSellerPage> createState() => _QuestionSellerPageState();
}

class _QuestionSellerPageState extends State<QuestionSellerPage> {
  final CommonQuestionGetXController _getXController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              AllAppBar(
                text: 'أسئلة',back: true,
                spaceAfterLogo: 0,
                spaceBeforeLogo:60,
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: GetBuilder<CommonQuestionGetXController>(
                      builder: (controller){
                        var questionsList = controller.questionsList;
                        return  Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10,top: 30),
                          child: Column(
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: questionsList.length,
                                itemBuilder: (context, index) =>
                                    QuestionContainer(question: questionsList[index],),
                              ),
                            ],
                          ),
                        );
                      },)
                ),
              ),
            ],
          )
      ),
    );
  }
}

