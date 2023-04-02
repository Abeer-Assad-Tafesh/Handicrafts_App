import 'package:flutter/material.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_form_field.dart';
import '../widgets/text_form_label.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              AllAppBar(text: 'تواصل معنا',back: true,),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left:30, right:30,top: 40,bottom: 30),
                    child: Column(
                      children: [
                        const TextFormLabel(icon: "assets/icons/profile.svg", label: 'الاسم بالكامل'),
                        const AppTextFormField(),
                        const SizedBox(height: 15),
                        const TextFormLabel(icon: "assets/icons/message.svg", label: 'البريد الإلكتروني'),
                        const AppTextFormField(),
                        const SizedBox(height: 40),
                        const AppTextFormField(height: 250,maxLines: 10,hintText: 'أدخل نص لا يزيد عن 70 حرف',),
                        const SizedBox(height: 40),
                        AppButton(text: 'إرسال',onPressed: (){
                          Navigator.pushNamed(context, '/sent_successfully_screen');
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
