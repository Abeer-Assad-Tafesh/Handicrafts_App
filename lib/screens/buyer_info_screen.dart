import 'package:flutter/material.dart';
import 'package:handcrafts/widgets/all_appBar.dart';

import '../constants.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_form_field.dart';
import '../widgets/text_form_label.dart';

class BuyerInfoScreen extends StatelessWidget {
  const BuyerInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(
        child: Column(
          children: [
            AllAppBar(text: 'معلوماتي',back: true,),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          foregroundColor: Colors.grey,
                          child: const Icon(Icons.person_outline_rounded,),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          // open gallery to reset the photo
                        },
                        child: Text('إعادة تعيين الصورة',
                          style: TextStyle(color: kDefaultColor,
                              fontSize: 14
                          ),
                        ),
                      ),
                      const SizedBox(height: 50,),
                      const TextFormLabel(icon: "assets/icons/profile.svg", label: 'الاسم بالكامل'),
                      const AppTextFormField(),
                      const SizedBox(height: 10),
                      const TextFormLabel(icon: "assets/icons/message.svg", label: 'البريد الإلكتروني'),
                      const AppTextFormField(),
                      const SizedBox(height: 10),
                      const TextFormLabel(icon: "assets/icons/call.svg", label: 'رقم الجوال'),
                      const AppTextFormField(),
                      const SizedBox(height: 10),
                      const SizedBox(height: 40,),
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
