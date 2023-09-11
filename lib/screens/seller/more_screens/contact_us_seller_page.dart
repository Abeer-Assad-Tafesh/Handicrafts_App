import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/app_text_form_field.dart';
import 'package:handcrafts/widgets/text_form_label.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../api/controllers/contact_us_api_controller.dart';
import '../../../prefs/shared_pref_controller.dart';


class ContactUsSellerPage extends StatefulWidget {
  const ContactUsSellerPage({Key? key}) : super(key: key);

  @override
  State<ContactUsSellerPage> createState() => _ContactUsSellerPageState();
}

class _ContactUsSellerPageState extends State<ContactUsSellerPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _messageController;

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
              AllAppBar(
                text: 'تواصل معنا',
                back: true,
                spaceAfterLogo: 0,
                spaceBeforeLogo: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left:30.w, right:30.w,top: 40.h,bottom: 30.h),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const TextFormLabel(icon: "assets/icons/profile.svg", label: 'اسمك'),
                          AppTextFormField(
                            controller: _fullNameController,
                            onChanged: (value) {},
                          ),
                          SizedBox(height: 15.h),
                          const TextFormLabel(icon: "assets/icons/email.svg", label: 'بريدك الإلكتروني'),
                          AppTextFormField(
                            controller: _emailController,
                            onChanged: (value) {},
                            textInputField: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 40.h),
                          AppTextFormField(
                            controller: _messageController,
                            onChanged: (value) {},
                            height: 250.h,maxLines: 10,hintText: 'أدخل نص لا يزيد عن 70 حرف',
                          ),
                          SizedBox(height: 40.h),
                          AppButton(text: 'إرسال',
                            onPressed: () async {
                              bool status = await sendMessage();
                              if(status){
                                Navigator.pushNamed(context, '/sent_successfully_screen');
                              }
                            },
                          ),
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

  Future<bool> sendMessage() async {
    if(checkData()){
      String email = _emailController.text.trim();
      String name = _fullNameController.text.trim();
      String message = _messageController.text.trim();

      bool status = await ContactUsApiController().sendApiMessage(email: email, name: name, message: message);
      if(status){
        return true;
      }else{
        return false;
      }
    }
    return false;
  }

  final RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)| (\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  final RegExp regExp = RegExp(r'(^(?:05[96])?[0-9]{7}$)');

  bool checkData() {
    if (_fullNameController.text.trim().isEmpty) {
      Get.snackbar('مهلاً', 'أدخل اسمك ', colorText: Colors.red);
      return false;
    } else if (_fullNameController.text.trim() != SharedPrefController().name) {
      Get.snackbar('مهلاً', 'اسمك الذي أدخلته غير صحيح', colorText: Colors.red);
      return false;
    }else if (_emailController.text.trim().isEmpty) {
      Get.snackbar('مهلاً', 'أدخل ايميلك ', colorText: Colors.red);
      return false;
    } else if (!regex.hasMatch(_emailController.text.trim())) {
      Get.snackbar('مهلاً', 'أدخل إيميل صحيح ', colorText: Colors.red);
      return false;
    }else if (_emailController.text.trim() != SharedPrefController().email) {
      Get.snackbar('مهلاً', 'الإيميل الذي أدخلته غير صحيح', colorText: Colors.red);
      return false;
    } else if (_messageController.text.trim().isEmpty) {
      Get.snackbar('مهلاً', 'أدخل رسالتك ', colorText: Colors.red);
      return false;
    }else if (_messageController.text.trim().length >= 70) {
      Get.snackbar('مهلاً', 'الحد الأقصى لطول الرسالة هو 70 حرف ', colorText: Colors.red);
      return false;
    }
    return true;
  }

}
