import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handcrafts/constants.dart';

class SentSuccessfullyScreen extends StatelessWidget {

  final String mainText;
  final String subText;
  const SentSuccessfullyScreen({Key? key,
    this.mainText = 'تم إرسال الطلب بنجاح',
    this.subText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/sent.png',fit: BoxFit.fill,),
               Text(mainText,
                style: TextStyle(fontSize: 20),
              ),
              Text(subText,
                style: TextStyle(fontSize: 12,color: kPrimaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
