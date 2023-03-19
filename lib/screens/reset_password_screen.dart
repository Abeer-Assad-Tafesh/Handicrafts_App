import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_form_field.dart';
import '../widgets/text_form_label.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

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
                padding: EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Container(
                        alignment: AlignmentDirectional.center,
                        child: SvgPicture.asset('assets/images/reset_password.svg')),
                    const SizedBox(height: 70),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const TextFormLabel(
                                icon: Icons.lock_outline, label: 'كلمة المرور'),
                            const AppTextFormField(
                              suffixIcon: Icons.remove_red_eye_outlined,
                              obscureText: true,
                            ),
                            const SizedBox(height: 12),
                            const TextFormLabel(
                                icon: Icons.lock_outline, label: 'تأكيد كلمة المرور'),
                            const AppTextFormField(
                              suffixIcon: Icons.remove_red_eye_outlined,
                              obscureText: true,
                            ),
                            const SizedBox(height: 40),
                            AppButton(
                              onPressed: (){
                                Navigator.pushNamed(context, '/login_screen');
                              },
                              text: 'حفظ',
                            ),
                            const SizedBox(height: 20),
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
