import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/models/user.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/app_text_form_field.dart';
import 'package:handcrafts/widgets/text_form_label.dart';


class BuyerInfoScreen extends StatefulWidget {
  const BuyerInfoScreen({Key? key}) : super(key: key);

  @override
  State<BuyerInfoScreen> createState() => _BuyerInfoScreenState();
}
class _BuyerInfoScreenState extends State<BuyerInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _fullNameController = TextEditingController(
    text: SharedPrefController().name
  );
  TextEditingController _emailController = TextEditingController(
      text: SharedPrefController().email
  );
  TextEditingController _phoneNumController = TextEditingController(
      text: SharedPrefController().phone
  );
  late TextEditingController _passwordController;
  late String _name;
  late String _email;
  late String _password;
  late String _phone;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _fullNameController = TextEditingController();
    // _emailController = TextEditingController();
    // _phoneNumController = TextEditingController();
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
      body: SafeArea(
        child: Column(
          children: [
            AllAppBar(
              text: 'معلوماتي',
              back: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            foregroundColor: Colors.grey,
                            child: const Icon(
                              Icons.person_outline_rounded,
                              size: 40,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            // open gallery to reset the photo
                          },
                          child: Text(
                            'إعادة تعيين الصورة',
                            style: TextStyle(color: kPrimaryColor, fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 50),
                        const TextFormLabel(
                            icon: "assets/icons/profile.svg",
                            label: 'الاسم بالكامل'),
                        AppTextFormField(
                          controller: _fullNameController,
                          onChanged: (value){
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
                        ),
                        const SizedBox(height: 10),
                        const TextFormLabel(
                            icon: "assets/icons/call.svg", label: 'رقم الجوال'),
                        AppTextFormField(
                          controller: _phoneNumController,
                          hintText: '059/056',
                          onChanged: (value){
                            _phone = value;
                          },
                          validator: validatePhoneNum,
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 40),
                        AppButton(
                          text: 'تعديل',
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              Navigator.pushNamed(context, '/basic_screens');
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
        return null;
      }
    } else {
      return 'أدخل إيميل صحيح';
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

}
