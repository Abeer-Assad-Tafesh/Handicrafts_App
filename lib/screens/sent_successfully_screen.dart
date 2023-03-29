import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SentSuccessfullyScreen extends StatelessWidget {
  const SentSuccessfullyScreen({Key? key}) : super(key: key);

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
              const Text('تم إرسال الطلب بنجاح',style: TextStyle(
                fontSize: 18
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
