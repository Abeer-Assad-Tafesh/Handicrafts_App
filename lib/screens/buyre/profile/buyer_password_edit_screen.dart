import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/auth_api_controller.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/app_text_form_field.dart';
import 'package:handcrafts/widgets/text_form_label.dart';


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

  bool _obscureNewPassword = true;
  bool _obscureOldPassword = true;
  bool _obscureConfirmedPassword = true;

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
                    Stack(
                      children: [
                        AppTextFormField(
                          controller: _oldPasswordController,
                          onChanged: (value) {
                            _oldPassword = value;
                            return _oldPassword;
                          },
                          validator: validateNewPassword,
                          obscureText: _obscureOldPassword,
                        ),
                        Positioned(
                          left: 5,top: 3,
                          child: IconButton(
                            icon: _obscureOldPassword ? SvgPicture.asset('assets/icons/show.svg',color: kPrimaryColor,) :  SvgPicture.asset('assets/icons/hide.svg',color: kPrimaryColor,),
                            onPressed: () {
                              setState(() {
                                _obscureOldPassword = !_obscureOldPassword;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const TextFormLabel(
                        icon: "assets/icons/password.svg",
                        label: 'كلمة المرور الجديدة'),
                    Stack(
                      children: [
                        AppTextFormField(
                          controller: _newPasswordController,
                          onChanged: (value){
                            _newPassword = value;
                            return _newPassword;
                          },
                          validator: validateNewPassword,
                          obscureText: _obscureNewPassword,
                        ),
                        Positioned(
                          left: 5,top: 3,
                          child: IconButton(
                            icon: _obscureNewPassword ? SvgPicture.asset('assets/icons/show.svg',color: kPrimaryColor,) :  SvgPicture.asset('assets/icons/hide.svg',color: kPrimaryColor,),
                            onPressed: () {
                              setState(() {
                                _obscureNewPassword = !_obscureNewPassword;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const TextFormLabel(
                        icon: "assets/icons/password.svg",
                        label: 'تأكيد كلمة المرور'),
                    Stack(
                      children: [
                        AppTextFormField(
                          controller: _confirmedNewPasswordController,
                          onChanged: (value) {
                            _confirmedNewPassword = value;
                            return _confirmedNewPassword;
                          },
                          validator: validateConfirmedNewPassword,
                          obscureText: _obscureConfirmedPassword,
                        ),
                        Positioned(
                          left: 5,top: 3,
                          child: IconButton(
                            icon: _obscureConfirmedPassword ? SvgPicture.asset('assets/icons/show.svg',color: kPrimaryColor,) :  SvgPicture.asset('assets/icons/hide.svg',color: kPrimaryColor,),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmedPassword = !_obscureConfirmedPassword;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    AppButton(
                      text: 'تعديل',
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          performResetPassword();
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

  performResetPassword() async {
    if (_newPassword == _confirmedNewPassword) {
      bool status = await AuthApiController()
          .resetPassword(password: _newPassword);
      if(status){
        Get.snackbar('نجحت العملية', 'تم إعادة تعيين كلمة المرور بنجاح',colorText: kPrimaryColor);
      }
    }
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
