import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/auth_api_controller.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
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
            spaceBeforeLogo: 12,
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
                          onChanged: (value) {},
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
                          onChanged: (value){},
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
                          onChanged: (value) {},
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
                      onPressed: () async {
                          await performResetPassword();
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

  Future<void> performResetPassword() async {
    if(checkData()){
      if(_oldPasswordController.text.trim() == SharedPrefController().password){
        if (_newPasswordController.text.trim() == _confirmedNewPasswordController.text.trim()) {
          bool status = await AuthApiController()
              .resetPassword(newPassword: _newPasswordController.text.trim(),
            oldPassword: _oldPasswordController.text.trim(),
          );
          if(status){
            final User? user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              try {
                final AuthCredential credential = EmailAuthProvider.credential(
                  email: SharedPrefController().email,
                  password: SharedPrefController().password,
                );
                await user.reauthenticateWithCredential(credential);
                await user.updatePassword(_newPasswordController.text.trim());
                SharedPrefController().updatePassword(password: _newPasswordController.text.trim());
                Get.snackbar('نجحت العملية', 'تم إعادة تعيين كلمة المرور بنجاح',colorText: kPrimaryColor);
                Navigator.pushNamed(context, '/basic_buyer_screens');
              } catch (e) {
                Get.snackbar('حدث خطأ ما!', 'حاول مرة أخرى', colorText: Colors.red);
              }
            }
          }
        }
      }else{
        Get.snackbar('مهلاً', 'كلمة المرور القديمة غير صحيحية', colorText: Colors.red);
      }
    }
  }

  bool checkData() {
     if (_oldPasswordController.text.isEmpty) {
      Get.snackbar('مهلاً', 'أدخل كلمة المرور القديمة', colorText: Colors.red);
      return false;
    }else if (_newPasswordController.text.isEmpty) {
       Get.snackbar('مهلاً', 'أدخل كلمة المرور الجديدة', colorText: Colors.red);
       return false;
     }else if (_confirmedNewPasswordController.text.isEmpty) {
       Get.snackbar('مهلاً', 'أدخل كلمة المرور الجديدة مرة أخرى', colorText: Colors.red);
       return false;
     }
     return true;
  }

}
