import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handcrafts/widgets/app_text_form_field.dart';
import 'package:handcrafts/widgets/text_form_label.dart';
import '../widgets/app_button.dart';

class BuyerRegisterPage extends StatefulWidget {
  const BuyerRegisterPage({Key? key}) : super(key: key);

  @override
  State<BuyerRegisterPage> createState() => _BuyerRegisterPageState();
}

class _BuyerRegisterPageState extends State<BuyerRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('assets/images/bg_screens.png'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    alignment: AlignmentDirectional.center,
                    child: SvgPicture.asset('assets/images/register.svg')),
                const Text(
                  'مرحبًا بك في عالم Handcrafts',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const TextFormLabel(icon: Icons.perm_identity, label: 'الاسم بالكامل'),
                          const AppTextFormField(),
                          const SizedBox(height: 10),
                          const TextFormLabel(icon: Icons.email_outlined, label: 'البريد الإلكتروني'),
                          const AppTextFormField(),
                          const SizedBox(height: 10),
                          const TextFormLabel(icon: Icons.phone, label: 'رقم الجوال'),
                          const AppTextFormField(),
                          const SizedBox(height: 10),
                          const TextFormLabel(icon: Icons.lock_outline, label: 'كلمة المرور'),
                          const AppTextFormField(suffixIcon: Icons.remove_red_eye_outlined,obscureText: true,),
                          const SizedBox(height: 35),
                          AppButton(text: 'تسجيل',onPressed: (){
                            Navigator.pushNamed(context, '/basic_screens');
                          },),
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
