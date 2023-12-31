import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/api/controllers/auth_api_controller.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/app_text_form_field.dart';
import 'package:handcrafts/widgets/text_form_label.dart';

class ResetPasswordScreen extends StatefulWidget {
  String? code;
  String? email;
  ResetPasswordScreen({Key? key,this.code,this.email}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmedNewPasswordController;
  late String _newPassword;
  late String _confirmedNewPassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newPasswordController = TextEditingController();
    _confirmedNewPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _newPasswordController.dispose();
    _confirmedNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(children: [
          Image.asset('assets/images/bg_screens.png'),
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: const [
                    Icon(Icons.arrow_back),
                    SizedBox(
                      width: 8,
                    ),
                    Text('إعادة تعيين كلمة المرور'),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    alignment: AlignmentDirectional.center,
                    child:
                        SvgPicture.asset('assets/images/reset_password.svg')),
                const SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const TextFormLabel(
                            icon: "assets/icons/password.svg",
                            label: 'كلمة المرور'),
                        AppTextFormField(
                          controller: _newPasswordController,
                          onChanged: (value) {
                            _newPassword = value;
                          },
                          validator: validateNewPassword,
                          suffixIcon: Icons.remove_red_eye_outlined,
                          obscureText: true,
                        ),
                        const SizedBox(height: 12),
                        const TextFormLabel(
                            icon: "assets/icons/password.svg",
                            label: 'تأكيد كلمة المرور'),
                        AppTextFormField(
                          controller: _confirmedNewPasswordController,
                          onChanged: (value) {
                            _confirmedNewPassword = value;
                          },
                          validator: validateConfirmedNewPassword,
                          suffixIcon: Icons.remove_red_eye_outlined,
                          obscureText: true,
                        ),
                        const SizedBox(height: 40),
                        AppButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              performResetPassword();
                            }
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
        ]),
      ),
    );
  }

  performResetPassword() async {
    if (_newPassword == _confirmedNewPassword) {
      bool status = await AuthApiController()
          .resetForgetPassword(email: widget.email!, code: widget.code!, password: _newPassword);
      if(status){
        Navigator.pushNamed(context, '/login_screen');
      }
    }
  }

  String? validateNewPassword(String? value) {
    if (value!.isEmpty) {
      return 'أدخل كلمة المرور';
    } else {
      if (value.length < 6) {
        return 'أدخل كلمة مرور لا تقل عن 6 خانات ';
      } else {
        return null;
      }
    }
  }

  String? validateConfirmedNewPassword(String? value) {
    if (value!.isEmpty || value != _newPassword) {
      return 'كلمة المرور غير مطابقة';
    } else {
      return null;
    }
  }
}
