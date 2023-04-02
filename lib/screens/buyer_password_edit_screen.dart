import 'package:flutter/material.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_form_field.dart';
import '../widgets/text_form_label.dart';

class BuyerPasswordInfoScreen extends StatelessWidget {
  const BuyerPasswordInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              AllAppBar(text: 'كلمة المرور',back: true,),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left:30, right:30,top: 100,bottom: 30),
                    child: Column(
                      children: [
                        const Text('تغيير كلمة المرور',
                          style: TextStyle(color: Colors.black,
                              fontSize: 16
                          ),
                        ),
                        const SizedBox(height: 50,),
                        const TextFormLabel(icon: "assets/icons/password.svg", label: 'كلمة المرور الحالية'),
                        const AppTextFormField(suffixIcon: Icons.remove_red_eye_outlined,obscureText: true,),
                        const SizedBox(height: 20,),
                        const TextFormLabel(icon: "assets/icons/password.svg", label: 'كلمة المرور الجديدة'),
                        const AppTextFormField(suffixIcon: Icons.remove_red_eye_outlined,obscureText: true,),
                        const SizedBox(height: 20,),
                        const TextFormLabel(icon: "assets/icons/password.svg", label: 'تأكيد كلمة المرور'),
                        const AppTextFormField(suffixIcon: Icons.remove_red_eye_outlined,obscureText: true,),
                        const SizedBox(height: 50,),
                        AppButton(text: 'تعديل',onPressed: (){
                          // Navigator.pushNamed(context, '/basic_screens');
                        },),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
