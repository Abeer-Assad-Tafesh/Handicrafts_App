import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/auth_api_controller.dart';
import 'package:handcrafts/api/models/user.dart';
import 'package:handcrafts/screens/buyer/basic_buyer/basic_buyer_screens.dart';
import 'package:handcrafts/screens/seller/basic_seller/basic_seller_screens.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:handcrafts/screens/buyer/profile/verification_code_screen.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/app_text_form_field.dart';
import 'package:handcrafts/widgets/small_text.dart';
import 'package:handcrafts/widgets/text_form_label.dart';
import 'package:random_color/random_color.dart';

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
                              icon: "assets/icons/email.svg",
                              label: 'البريد الإلكتروني'),
                          AppTextFormField(
                            controller: _emailController,
                            onChanged: (value) {
                            },
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
                                },
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
                                login();
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
                                                             "assets/icons/email.svg",
                                                         label: 'الإيميل'),
                                                     AppTextFormField(
                                                       controller:
                                                           _forgetEmailController,
                                                       onChanged: (value) {
                                                       },
                                                     ),
                                                     const SizedBox(
                                                         height: 30),
                                                     AppButton(
                                                       onPressed:
                                                           () async {
                                                         if(_forgetEmail.isNotEmpty){
                                                           await forgetPassword(context);
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
    if(checkData()){
      bool status = await AuthApiController()
          .login(email: _emailController.text.trim(), password: _passwordController.text.trim());
      if (status) {
        try {
          _auth.signInWithEmailAndPassword(
              email: _emailController.text.trim(), password: _passwordController.text.trim()).then((value) {
            UserApi? user = SharedPrefController().user;
            print('${user?.typeUser}');
            if (user?.typeUser == 'buyer') {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const BasicBuyerScreens()));
            } else {
              print('user store id : ${user?.store.userId}');
              // if(user?.store.id == null){
                if(user?.store.userId == null){
                Navigator.pushNamed(context, 'add_store_page');
              }else{
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    BasicSellerScreens(storeId: user?.store.userId,)
                ));
              }
            }
          }
          );
        } catch (e) {
          print('-----> $e');
        }

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


  final RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)| (\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  bool checkData() {
    if (_emailController.text.isEmpty) {
      Get.snackbar('مهلاً', 'أدخل ايميلك ', colorText: Colors.red);
      return false;
    } else if (!regex.hasMatch(_emailController.text!)) {
      Get.snackbar('مهلاً', 'أدخل إيميل صحيح ', colorText: Colors.red);
      return false;
    } else if (_passwordController.text.isEmpty) {
      Get.snackbar('مهلاً', 'أدخل كلمة المرور ', colorText: Colors.red);
      return false;
    }
    return true;
  }

}
