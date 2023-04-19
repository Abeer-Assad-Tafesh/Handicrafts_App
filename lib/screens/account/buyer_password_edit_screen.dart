import 'package:flutter/material.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_form_field.dart';
import '../../widgets/text_form_label.dart';

class BuyerPasswordInfoScreen extends StatefulWidget {
  const BuyerPasswordInfoScreen({Key? key}) : super(key: key);

  @override
  State<BuyerPasswordInfoScreen> createState() =>
      _BuyerPasswordInfoScreenState();
}

class _BuyerPasswordInfoScreenState extends State<BuyerPasswordInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmedNewPasswordController;
  late String _oldPassword;
  late String _newPassword;
  late String _confirmedNewPassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmedNewPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmedNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          AllAppBar(
            text: 'كلمة المرور',
            back: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 100, bottom: 30),
                child: Column(
                  children: [
                    const Text(
                      'تغيير كلمة المرور',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const TextFormLabel(
                        icon: "assets/icons/password.svg",
                        label: 'كلمة المرور الحالية'),
                    AppTextFormField(
                      controller: _oldPasswordController,
                      onChanged: (value) {
                        _oldPassword = value;
                      },
                      validator: validateNewPassword,
                      suffixIcon: Icons.remove_red_eye_outlined,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const TextFormLabel(
                        icon: "assets/icons/password.svg",
                        label: 'كلمة المرور الجديدة'),
                    AppTextFormField(
                      controller: _newPasswordController,
                      onChanged: (value) {
                        _newPassword = value;
                      },
                      validator: validateNewPassword,
                      suffixIcon: Icons.remove_red_eye_outlined,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                    const SizedBox(
                      height: 50,
                    ),
                    AppButton(
                      text: 'تعديل',
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          // Navigator.pushNamed(context, '/verification_code_screen');
                          print('password edited ^-^');
                          /*print('login');
                              AuthHelper.authHelper
                                  .login(email, password)
                                  .then((value) => () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder:(context) =>  HomePageUi()
                                  ),
                                );
                              });*/
                        }
                        // Navigator.pushNamed(context, '/basic_screens');
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  String? validateNewPassword(String? value) {
    if (value!.isEmpty) {
      return 'أدخل كلمة السر';
    } else {
      if (value.length < 6) {
        return 'يجب أن لا تقل كلمة السر عن 6 خانات';
      } else {
        return null;
      }
    }
  }

  String? validateConfirmedNewPassword(String? value) {
    if (value!.isEmpty || value != _newPassword) {
      return 'كلمة السر غير متطابقة';
    } else {
      return null;
    }
  }
}
