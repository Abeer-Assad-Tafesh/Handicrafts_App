import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/small_text.dart';

class SentSuccessfullyScreen extends StatelessWidget {
  final String mainText;
  final String subText;

  const SentSuccessfullyScreen({
    Key? key,
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
              Image.asset(
                'assets/images/sent.png',
                fit: BoxFit.fill,
              ),
              SmallText(
                text: mainText,
                size: 20,
              ),
              SmallText(
                text: subText,
                size: 12,
                color: kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
