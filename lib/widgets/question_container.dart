
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../api/models/question.dart';

class QuestionContainer extends StatefulWidget {
  CommonQuestion question;
  QuestionContainer({super.key, required this.question,});

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
                  Expanded(
                    child: Text(widget.question.title,
                      style: const TextStyle(
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
                children:  [
                  const Divider(),
                  Text(widget.question.desc,
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

