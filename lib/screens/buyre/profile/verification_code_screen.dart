import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/constants.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/code_box.dart';


class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({Key? key}) : super(key: key);

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('assets/images/bg_screens.png'),
            Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Column(

                children: [
                  const SizedBox(height: 30,),
                  Row(
                    children: const [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 8,),
                      Text('رمز التحقق'),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  Center(
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/images/verif_code.svg'),
                        Text(
                          'أدخل رمز التحقق',
                          style: TextStyle(
                              fontSize: 22,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'تم إرسال رمز التحقق',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                        ),
                        const SizedBox(height: 10,),
                        const Text(
                          '+97259938494',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            CodeBox(),
                            CodeBox(),
                            CodeBox(),
                            CodeBox(),
                          ],
                        ),
                        const SizedBox(height: 60),
                        AppButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/reset_password_screen');
                          },
                          text: 'تحقق الآن',
                        ),
                        const SizedBox(height: 30,),
                        Text(
                          'إعادة إرسال بعد',
                          style: TextStyle(
                              fontSize: 18,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10,),
                        const Text(
                          '1:20',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

