import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/auth_api_controller.dart';
import 'package:handcrafts/api/models/user.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/app_text_form_field.dart';
import 'package:handcrafts/widgets/big_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handcrafts/widgets/text_form_label.dart';


class BuyerRegisterPage extends StatefulWidget {
  const BuyerRegisterPage({Key? key}) : super(key: key);

  @override
  State<BuyerRegisterPage> createState() => _BuyerRegisterPageState();
}

class _BuyerRegisterPageState extends State<BuyerRegisterPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumController;
  late TextEditingController _passwordController;

  String _userType = 'buyer';
  bool _obscurePassword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(children: [
          Image.asset('assets/images/bg_screens.png',
              width: double.infinity, fit: BoxFit.cover),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextFormLabel(
                            icon: "assets/icons/profile.svg",
                            label: 'الاسم بالكامل'),
                        AppTextFormField(
                          controller: _fullNameController,
                          onChanged: (value) {
                          },
                        ),
                        const SizedBox(height: 10),
                        const TextFormLabel(
                            icon: "assets/icons/email.svg",
                            label: 'البريد الإلكتروني'),
                        AppTextFormField(
                          controller: _emailController,
                          textInputField: TextInputType.emailAddress,
                          onChanged: (value) {
                          },
                        ),
                        const SizedBox(height: 10),
                        const TextFormLabel(
                            icon: "assets/icons/call.svg", label: 'رقم الجوال'),
                        AppTextFormField(
                          controller: _phoneNumController,
                          hintText: '059/056',
                          onChanged: (value) {
                          },
                          textInputField: TextInputType.phone,
                        ),
                        const SizedBox(height: 10),
                        const TextFormLabel(
                            icon: "assets/icons/password.svg",
                            label: 'كلمة المرور'),
                        Stack(
                          children: [
                            AppTextFormField(
                              controller: _passwordController,
                              onChanged: (value) {
                              },
                              obscureText: _obscurePassword,
                            ),
                            Positioned(
                              left: 5,top: 3,
                              child: IconButton(
                                icon: _obscurePassword ? SvgPicture.asset('assets/icons/show.svg',color: kPrimaryColor,) :  SvgPicture.asset('assets/icons/hide.svg',color: kPrimaryColor,),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        BigText(
                          text: 'التسجيل ك:',
                          size: 16,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                contentPadding: EdgeInsets.zero,
                                title: BigText(
                                  text: 'مشتري',
                                  size: 18,
                                ),
                                value: 'buyer',
                                groupValue: _userType,
                                onChanged: (String? value) {
                                  if (value != null) {
                                    setState(() {
                                      _userType = value;
                                    });
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                contentPadding: EdgeInsets.zero,
                                title: BigText(
                                  text: 'حرفي',
                                  size: 18,
                                ),
                                value: 'craftsman',
                                groupValue: _userType,
                                onChanged: (String? value) {
                                  if (value != null) {
                                    setState(() {
                                      _userType = value;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.center,
                          child: AppButton(
                            text: 'تسجيل',
                            onPressed: () async {
                                await register();
                            },
                          ),
                        ),
                        const SizedBox(height: 100),
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

  UserApi get user {
    UserApi user = UserApi();
    user.name = _fullNameController.text.trim();
    user.email = _emailController.text.trim();
    user.phoneNumber = _phoneNumController.text.trim();
    user.password = _passwordController.text.trim();
    user.typeUser = _userType.trim();
    return user;
  }

  Future<void> register() async {
    if(checkData()){
      bool status = await AuthApiController().register(user: user);
      if(status){
        try {
          _auth
              .createUserWithEmailAndPassword(
              email: _emailController.text.trim(), password: _passwordController.text.trim())
              .then((value) {
            User? user = value.user;
            user!.updateProfile(displayName: _fullNameController.text);
            _firestore
                .collection('Users')
                .doc(_auth.currentUser!.uid)
                .set({
              "name": _fullNameController.text.trim(),
              "email": _emailController.text.trim(),
            });
          });
        } catch (e) {
          print('error ====> $e');
        }
        Navigator.pushNamed(context, '/login_register_screen');
      }
    }
  }

  final RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)| (\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  final RegExp regExp = RegExp(r'(^(?:05[96])?[0-9]{7}$)');

  bool checkData() {
    if (_fullNameController.text.isEmpty) {
      Get.snackbar('مهلاً', 'أدخل اسمك ', colorText: Colors.red);
      return false;
    } else if (_fullNameController.text.length < 3) {
      Get.snackbar('مهلاً', 'أدخل اسم لا يقل عن 3 حروف ',
          colorText: Colors.red);
      return false;
    } else if (_emailController.text.isEmpty) {
      Get.snackbar('مهلاً', 'أدخل إيميل ', colorText: Colors.red);
      return false;
    } else if (!regex.hasMatch(_emailController.text!)) {
      Get.snackbar('مهلاً', 'أدخل إيميل صحيح ', colorText: Colors.red);
      return false;
    } else if (_phoneNumController.text.isEmpty) {
      Get.snackbar('مهلاً', 'أدخل رقم هاتفك ', colorText: Colors.red);
      return false;
    } else if (!regExp.hasMatch(_phoneNumController.text)) {
      Get.snackbar('مهلاً', 'أدخل رقم هاتف صحيح', colorText: Colors.red);
      return false;
    } else if (_passwordController.text.isEmpty) {
      Get.snackbar('مهلاً', 'أدخل كلمة مرور', colorText: Colors.red);
      return false;
    }else if (_passwordController.text.length < 6) {
      Get.snackbar('مهلاً', 'أدخل كلمة مرور لا تقل عن 6 خانات', colorText: Colors.red);
      return false;
    }
    return true;
  }

}
