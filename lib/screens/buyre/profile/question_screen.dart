import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/widgets/all_appBar.dart';


class QuestionScreen extends StatefulWidget {
   const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              AllAppBar(text: 'أسئلة',back: true,),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10,top: 30),
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                QuestionContainer(),
                          itemCount: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}

class QuestionContainer extends StatefulWidget {
   QuestionContainer({
    super.key,
  });

  @override
  State<QuestionContainer> createState() => _QuestionContainerState();
}

class _QuestionContainerState extends State<QuestionContainer> {

  bool showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Container(
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(6),
       border: Border.all(color: Colors.grey.shade300),
       color: Colors.grey.shade50
     ),
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              if(showAnswer){
                setState(() {
                  showAnswer = false;
                });
              }else{
                setState(() {
                  showAnswer = true;
                });
              }
            },
            child: Row(
              children: [
                const Expanded(
                  child: Text('هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة؟',
                    style: TextStyle(
                        fontSize: 12
                    ),
                  ),
                ),
                showAnswer ?
                Transform.rotate(
                  angle: 3.14,
                  child: SvgPicture.asset("assets/icons/down_arrow.svg",width: 10,height: 10,),
                ) : SvgPicture.asset("assets/icons/down_arrow.svg",width: 10,height: 10,)

              ],
            ),
          ),
          showAnswer
          ? SingleChildScrollView(
            child: Column(
              children: const [
                Divider(),
                Text('هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة،'
                    ' لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص '
                    'أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق\t'
                    'إذا كنت تحتاج إلى عدد أكبر من الفقرات.\n يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد'
                    ' النص لن يبدو مقسما ولا يحوي أخطاء لغوية.\n'
                    ' مولد النص العربى مفيد لمصممي المواقع على وجه الخصوص،'
                    '. لأنه مازال نصاً بديلاً ومؤقتاً.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
          :const SizedBox(),
        ],
      )
    );
  }
}


