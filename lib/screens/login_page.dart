import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/constants.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/text_form_label.dart';

import '../widgets/app_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children:[
            Image.asset('assets/images/bg_screens.png'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    alignment: AlignmentDirectional.center,
                    child: SvgPicture.asset('assets/images/login.svg')),
                Text(
                  'مرحبًا بعودتك',
                  style: TextStyle(
                      fontSize: 22,
                      color: kDefaultColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                const Text(
                  'شاهد آخر إبداع الحرفيين',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const TextFormLabel(
                            icon: Icons.email_outlined,
                            label: 'البريد الإلكتروني (أو رقم الجوال)'),
                        const AppTextFormField(),
                        const SizedBox(height: 12),
                        const TextFormLabel(
                            icon: Icons.lock_outline, label: 'كلمة المرور'),
                        const AppTextFormField(
                          suffixIcon: Icons.remove_red_eye_outlined,
                          obscureText: true,
                        ),
                        const SizedBox(height: 30),
                        AppButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/basic_screens');
                          },
                          text: 'تسجيل الدخول',
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          child: Text(
                            'هل نسيت كلمة المرور ؟',
                            style: TextStyle(
                              fontSize: 14,
                              color: kDefaultColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    scrollable: true,
                                    insetPadding: const EdgeInsets.all(10),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        margin: const EdgeInsets.all(10.0),
                                        width: 400,
                                        // height: 400,
                                        child: Column(
                                          children: [
                                            Form(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'نسيت كلمة المرور',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: kDefaultColor,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  const Text(
                                                    'سيتم إرسال رمز التحقق',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  const TextFormLabel(
                                                      icon: Icons.phone,
                                                      label: 'رقم الجوال'),
                                                  const AppTextFormField(),
                                                  const SizedBox(height: 30),
                                                  AppButton(
                                                    onPressed: (){
                                                      Navigator.pushNamed(context, '/verification_code_screen');
                                                    },
                                                    text: 'تحقق الآن',
                                                    height: 48,
                                                    width: 250,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
          ),
            ),
            ]
        ),
      ),
    );
  }
}
