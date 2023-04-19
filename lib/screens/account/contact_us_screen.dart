import 'package:flutter/material.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_form_field.dart';
import '../../widgets/text_form_label.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _messageController;
  late String _name;
  late String _email;
  late String _message;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fullNameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              AllAppBar(text: 'تواصل معنا',back: true,),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left:30, right:30,top: 40,bottom: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const TextFormLabel(icon: "assets/icons/profile.svg", label: 'اسمك'),
                          AppTextFormField(
                            controller: _fullNameController,
                            onChanged: (value) {
                              _name = value;
                            },
                            validator: validateName,
                          ),
                          const SizedBox(height: 15),
                          const TextFormLabel(icon: "assets/icons/message.svg", label: 'بريدك الإلكتروني'),
                          AppTextFormField(
                            controller: _emailController,
                            onChanged: (value) {
                              _email = value;
                            },
                            validator: validateEmail,
                          ),
                          const SizedBox(height: 40),
                          AppTextFormField(
                            controller: _messageController,
                            onChanged: (value) {
                              _name = value;
                            },
                            validator: validateMessage,
                            height: 250,maxLines: 10,hintText: 'أدخل نص لا يزيد عن 70 حرف',
                          ),
                          const SizedBox(height: 40),
                          AppButton(text: 'إرسال',onPressed: (){
                            if(_formKey.currentState!.validate()){
                              Navigator.pushNamed(context, '/sent_successfully_screen');
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
                          },),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
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

  String? validateMessage(String? value) {
    if (value!.isEmpty) {
      return 'أدخل رسالتك';
    } else {
      if (value.length > 70) {
        return 'الحد الأقصى لطول الراسلة هو 70 حرف';
      } else {
        return null;
      }
    }
  }
}
