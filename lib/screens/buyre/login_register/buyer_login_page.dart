import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/api/controllers/auth_api_controller.dart';
import 'package:handcrafts/api/models/user.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:handcrafts/screens/buyre/profile/verification_code_screen.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/app_text_form_field.dart';
import 'package:handcrafts/widgets/small_text.dart';
import 'package:handcrafts/widgets/text_form_label.dart';

class BuyerLoginPage extends StatefulWidget {
  const BuyerLoginPage({Key? key}) : super(key: key);

  @override
  State<BuyerLoginPage> createState() => _BuyerLoginPageState();
}

class _BuyerLoginPageState extends State<BuyerLoginPage> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _forgetEmailController;
  late TextEditingController _passwordController;
  late String _email;
  late String _password;
  late String _forgetEmail;

  bool _obscurePassword = true;
  bool _hideAlertDialog = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _forgetEmailController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _forgetEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('assets/images/bg_screens.png',
                width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      alignment: AlignmentDirectional.center,
                      child: SvgPicture.asset('assets/images/login.svg')),
                  Text(
                    'مرحبًا بعودتك',
                    style: TextStyle(
                        fontSize: 22,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  // const Text(
                  //   'شاهد آخر إبداع الحرفيين',
                  //   style: TextStyle(fontSize: 18, color: Colors.grey),
                  // ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
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
                          const SizedBox(height: 12),
                          const TextFormLabel(
                              icon: "assets/icons/password.svg",
                              label: 'كلمة المرور'),
                          Stack(
                            children: [
                              AppTextFormField(
                                controller: _passwordController,
                                onChanged: (value) {
                                  _password = value;
                                },
                                validator: validatePassword,
                                obscureText: _obscurePassword,
                              ),
                              Positioned(
                                left: 5,
                                top: 3,
                                child: IconButton(
                                  icon: _obscurePassword
                                      ? SvgPicture.asset(
                                          'assets/icons/show.svg',
                                          color: kPrimaryColor,
                                        )
                                      : SvgPicture.asset(
                                          'assets/icons/hide.svg',
                                          color: kPrimaryColor,
                                        ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          AppButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                login();
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
                            text: 'تسجيل الدخول',
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            child: Text(
                              'هل نسيت كلمة المرور ؟',
                              style: TextStyle(
                                fontSize: 14,
                                color: kPrimaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                       scrollable: true,
                                       insetPadding:
                                           const EdgeInsets.all(10),
                                       shape: const RoundedRectangleBorder(
                                           borderRadius: BorderRadius.all(
                                               Radius.circular(10.0))),
                                       content: Padding(
                                         padding:
                                             const EdgeInsets.all(8.0),
                                         child: Container(
                                           margin:
                                               const EdgeInsets.all(10.0),
                                           width: 400,
                                           child: Column(
                                             children: [
                                               Form(
                                                 key: _emailFormKey,
                                                 child: Column(
                                                   children: [
                                                     Text(
                                                       'نسيت كلمة المرور',
                                                       style: TextStyle(
                                                           fontSize: 18,
                                                           color:
                                                               kPrimaryColor,
                                                           fontWeight:
                                                               FontWeight
                                                                   .bold),
                                                     ),
                                                     SmallText(
                                                         text:
                                                             'سيتم إرسال رمز التحقق',
                                                         size: 13,
                                                         color: Colors
                                                             .black),
                                                     const SizedBox(
                                                         height: 15),
                                                     const TextFormLabel(
                                                         icon:
                                                             "assets/icons/message.svg",
                                                         label: 'الإيميل'),
                                                     AppTextFormField(
                                                       controller:
                                                           _forgetEmailController,
                                                       onChanged: (value) {
                                                         _forgetEmail =
                                                             value;
                                                       },
                                                       validator:
                                                           validateEmail,
                                                     ),
                                                     const SizedBox(
                                                         height: 30),
                                                     AppButton(
                                                       onPressed:
                                                           () async {
                                                         if (_emailFormKey
                                                             .currentState!
                                                             .validate()) {
                                                           forgetPassword(context);
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
                                                       text: 'تحقق الآن',
                                                       height: 48,
                                                       width: 250,
                                                     ),
                                                   ],
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),
                                       ),
                                     );
                                  });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    bool status = await AuthApiController()
        .login(email: _email.trim(), password: _password.trim());
    print('===========>$status');
    if (status) {
      try {
        _auth.signInWithEmailAndPassword(
            email: _email.trim(), password: _password.trim()).then((value) {
          UserApi? user = SharedPrefController().user;
          print('${user?.typeUser}');
          if (user?.typeUser == 'buyer') {
            Navigator.pushNamed(context, '/basic_buyer_screens');
          } else {
            Navigator.pushNamed(context, '/basic_seller_screens');
          }
        }
        );
      } catch (e) {
        print('-----> $e');
      }

    }
  }

  // cont => is the context of the alert dialog not the page context
  Future<void> forgetPassword(BuildContext cont) async {
    print('===========>$_forgetEmail');
    bool status =
        await AuthApiController().forgetPassword(email: _forgetEmail.trim());
    print('===========>$status');
    if (status) {
      setState(() {
        _hideAlertDialog = false;
      });
      Navigator.pop(cont);
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> VerificationCodeScreen(email: _forgetEmail)));
    }
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'أدخل اسمك';
    } else {
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
    } else if (!regExp.hasMatch(value)) {
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
      } else {
        return null;
      }
    }
  }
}
