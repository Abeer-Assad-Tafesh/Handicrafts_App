import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handcrafts/api/controllers/auth_api_controller.dart';
import 'package:handcrafts/api/models/user.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/app_text_form_field.dart';
import 'package:handcrafts/widgets/big_text.dart';
import 'package:handcrafts/widgets/text_form_label.dart';

class BuyerRegisterPage extends StatefulWidget {
  const BuyerRegisterPage({Key? key}) : super(key: key);

  @override
  State<BuyerRegisterPage> createState() => _BuyerRegisterPageState();
}

class _BuyerRegisterPageState extends State<BuyerRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumController;
  late TextEditingController _passwordController;
  late String _name;
  late String _email;
  late String _password;
  late String _phone;

  String _userType = 'buyer';

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextFormLabel(
                            icon: "assets/icons/profile.svg",
                            label: 'الاسم بالكامل'),
                        AppTextFormField(
                            controller: _fullNameController,
                            onChanged: (value) {
                              _name = value;
                            },
                            validator: validateName,
                        ),
                        const SizedBox(height: 10),
                        const TextFormLabel(
                            icon: "assets/icons/message.svg",
                            label: 'البريد الإلكتروني'),
                        AppTextFormField(
                            controller: _emailController,
                            onChanged: (value) {
                              _email = value;
                            },
                            validator: validateEmail,
                          textInputField: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 10),
                        const TextFormLabel(
                            icon: "assets/icons/call.svg", label: 'رقم الجوال'),
                        AppTextFormField(
                          controller: _phoneNumController,
                          onChanged: (value){
                            _phone = value;
                          },
                          validator: validatePhoneNum,
                          textInputField: TextInputType.phone,
                        ),
                        const SizedBox(height: 10),
                        const TextFormLabel(
                            icon: "assets/icons/password.svg",
                            label: 'كلمة المرور'),
                        AppTextFormField(
                          controller: _passwordController,
                          onChanged: (value) {
                            _password = value;
                          },
                          validator: validatePassword,
                          suffixIcon: Icons.remove_red_eye_outlined,
                          obscureText: true,
                        ),
                        const SizedBox(height: 10),
                        BigText(text: 'التسجيل ك:',size: 16,color: Colors.grey,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                contentPadding: EdgeInsets.zero,
                                title: BigText(text: 'مشتري',size: 18,),
                                value: 'buyer',
                                groupValue: _userType,
                                onChanged: (String? value){
                                  if(value != null){
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
                                title: BigText(text: 'حرفي',size: 18,),
                                value: 'craftsman',
                                groupValue: _userType,
                                onChanged: (String? value){
                                  if(value != null){
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
                            onPressed: () {
                              if(_formKey.currentState!.validate()){
                                print('===========>done');
                                register();
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
                            },
                          ),
                        ),
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

User get user {
    User user = User();
    user.name = _name;
    user.email = _email;
    user.phoneNumber = _phone;
    user.password = _password;
    user.typeUser = _userType;
    return user;
}

 Future<void> register() async{
    bool status = await AuthApiController().register(user: user);
    print('===========>$status');
    if(status){
      if(_userType == 'buyer'){
        Navigator.pushNamed(context, '/basic_buyer_screens');
      }else {
        Navigator.pushNamed(context, '/basic_seller_screens');
      }
    }
  }



  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'أدخل اسمك';
    } else {
      if(value.length<3){
        return 'أدخل اسم لا يقل عن ثلاث حروف';
      }
      return null;
    }
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      final RegExp regex = RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)| (\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
      if (!regex.hasMatch(value!)) {
        return 'أدخل إيميل صحيح';
      } else {
        return 'أدخل إيميلك';
      }
    } else {
      return null;
    }
  }

  String? validatePhoneNum(String? value) {
    String pattern = r'(^(?:05[96])?[0-9]{7}$)';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return 'أدخل رقم هاتفك';
    }
    else if (!regExp.hasMatch(value)) {
      return 'أدخل رقم هاتف صحيح';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'أدخل كلمة السر';
    } else {
      if (value.length < 6) {
        return 'يجب أن لا تقل كلمة السر عن 6 خانات';
      }if(value.length >15){
        return 'يجب أن لا تزيد كلمة السر عن 15 خانة';
      } else {
        return null;
      }
    }
  }
}

