import 'package:flutter/material.dart';
import 'package:handcrafts/widgets/app_button.dart';

class RegisterAsScreen extends StatelessWidget {
  const RegisterAsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('تسجيل الدخول ك :',
        style: TextStyle(fontSize: 20),),
        const SizedBox(height: 20,),
        AppButton(onPressed: (){
          Navigator.pushNamed(context, '/login_register_screen',);
        }, text: 'مشتري'),
        const SizedBox(height: 20,),
        AppButton(onPressed: (){}, text: 'بائع'),
      ],
    );
  }
}
