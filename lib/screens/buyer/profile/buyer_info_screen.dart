import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/auth_api_controller.dart';
import 'package:handcrafts/api/models/user.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/app_text_form_field.dart';
import 'package:handcrafts/widgets/text_form_label.dart';
import 'package:image_picker/image_picker.dart';

import '../../../api/api_settings.dart';
import '../../../api/get/auth_getx_controller.dart';

class BuyerInfoScreen extends StatefulWidget {
  const BuyerInfoScreen({Key? key,}) : super(key: key);

  @override
  State<BuyerInfoScreen> createState() => _BuyerInfoScreenState();
}

class _BuyerInfoScreenState extends State<BuyerInfoScreen> {

  final AuthGetXController _authGetXController = Get.find();
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? phone;
  String? image;
  File? _imageFile;

  bool isLoading = false;

  late TextEditingController _fullNameController = TextEditingController(text: _authGetXController.userApi?.name ?? '');
  late TextEditingController _emailController  = TextEditingController(text: _authGetXController.userApi?.email ?? '');
  late TextEditingController _phoneNumController = TextEditingController(text: _authGetXController.userApi?.phoneNumber ?? '');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumController.dispose();
    super.dispose();
  }

  void _updateTextControllers(UserApi updatedUser) {
    _fullNameController.text = updatedUser.name;
    _emailController.text = updatedUser.email;
    _phoneNumController.text = updatedUser.phoneNumber ?? '';
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
              spaceBeforeLogo: 30,
            ),
            Expanded(
              child: Stack(
                children : [
                  SingleChildScrollView(
                    child: GetBuilder<AuthGetXController>(
                      builder: (controller) {
                        var user = controller.userApi;
                        print(user!.id);
                        if(controller.userApi != null){
                          return Padding(
                            padding: const EdgeInsets.all(30),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 100.h,
                                    width: 100.w,
                                    child: user!.profile?.imgProfile == null ?
                                    CircleAvatar(
                                      backgroundColor: Colors.indigo,
                                      foregroundColor: Colors.deepPurpleAccent,
                                      backgroundImage: _imageFile != null
                                          ? FileImage(File(_imageFile!.path))
                                          : null,
                                      child: _imageFile == null ? Text(
                                        SharedPrefController().name.substring(0, 1).toUpperCase(),
                                        style: TextStyle(fontSize: 40.0.sp, fontWeight: FontWeight.bold, color: Colors.white),
                                      ): null,
                                    )
                                        : CircleAvatar(
                                      backgroundColor: Colors.grey.shade300,
                                      foregroundColor: Colors.grey,
                                      backgroundImage: _imageFile != null
                                          ? FileImage(File(_imageFile!.path))
                                          : FileImage(File(user.profile!.imgProfile!)),
                                    ),

                                  ),
                                  const SizedBox(height: 20),
                                  InkWell(
                                    onTap: () {
                                      // open gallery to reset the photo
                                      _pickImage();
                                    },
                                    child: Text(
                                      'إعادة تعيين الصورة',
                                      style: TextStyle(
                                          color: kPrimaryColor, fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                  const TextFormLabel(
                                      icon: "assets/icons/profile.svg",
                                      label: 'الاسم بالكامل'),
                                  AppTextFormField(
                                    controller: _fullNameController,
                                    onChanged: (value) {},
                                  ),
                                  const SizedBox(height: 10),
                                  const TextFormLabel(
                                      icon: "assets/icons/email.svg",
                                      label: 'البريد الإلكتروني'),
                                  AppTextFormField(
                                    controller: _emailController,
                                    onChanged: (value) {},
                                    textInputField: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: 10),
                                  const TextFormLabel(
                                      icon: "assets/icons/call.svg",
                                      label: 'رقم الجوال'),
                                  AppTextFormField(
                                    controller: _phoneNumController,
                                    hintText: '059/056',
                                    onChanged: (value) {},
                                  ),
                                  const SizedBox(height: 10),
                                  const SizedBox(height: 40),
                                  AppButton(
                                    text: 'تعديل',
                                    onPressed: () async {
                                      await _updateProfile();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }else{
                          return Center(
                            child: CircularProgressIndicator(color: kPrimaryColor,),
                          );
                        }
                      },
                    ),
                  ),
                  isLoading ? Positioned.fill(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    ),
                  ): Container()
                ] ,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateProfile() async {
    if (checkData()) {
      UserApi userApi = UserApi();
      userApi.name = _fullNameController.text.trim();
      userApi.email = _emailController.text.trim();
      userApi.profile?.imgProfile = _imageFile!.path;
      userApi.phoneNumber = _phoneNumController.text.trim();
      setState(() {
        isLoading = true;
      });
      bool status = await AuthApiController().updateUserProfile(user: userApi);
      if (status) {
        final User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          try {
            final AuthCredential credential = EmailAuthProvider.credential(
              email: SharedPrefController().email,
              password: SharedPrefController().password,
            );
            await user.reauthenticateWithCredential(credential);
            await user.updateEmail(_emailController.text.trim());
            SharedPrefController().updateEmail(email: _emailController.text.trim());
            // Update the controllers with the new data after successful update
            setState(() {
              _authGetXController.userApi!.name = userApi.name;
              _authGetXController.userApi!.email = userApi.email;
              _authGetXController.userApi!.phoneNumber = userApi.phoneNumber;
              _authGetXController.userApi!.profile?.imgProfile = userApi.profile?.imgProfile;
            });
            _updateTextControllers(userApi);
            setState(() {
              isLoading = false;
            });
            Get.snackbar('نجحت العملية!', 'تم تحديث معلومات الحساب بنجاح', colorText: kPrimaryColor);
            Navigator.pushReplacementNamed(context, '/basic_buyer_screens');
          } catch (e) {
            print('error: $e');
            Get.snackbar('خطأ!', 'حاول مرة أخرى', colorText: Colors.red);
          }
        }
      }
      (e) {
        print('error ====> $e');
      };
    }
  }

  // Function to handle image selection from gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {
    }
  }

  final RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)| (\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  final RegExp regExp = RegExp(r'(^(?:05[96])?[0-9]{7}$)');

  bool checkData() {
    if (_fullNameController.text.trim().isEmpty) {
      Get.snackbar('مهلاً', 'أدخل اسمك ', colorText: Colors.red);
      return false;
    } else if (_fullNameController.text.trim().length < 3) {
      Get.snackbar('مهلاً', 'أدخل اسم لا يقل عن 3 حروف ',
          colorText: Colors.red);
      return false;
    } else if (_emailController.text.trim().isEmpty) {
      Get.snackbar('مهلاً', 'أدخل ايميلك ', colorText: Colors.red);
      return false;
    } else if (!regex.hasMatch(_emailController.text.trim()!)) {
      Get.snackbar('مهلاً', 'أدخل إيميل صحيح ', colorText: Colors.red);
      return false;
    } else if (_phoneNumController.text.trim().isEmpty) {
      Get.snackbar('مهلاً', 'أدخل رقم هاتفك ', colorText: Colors.red);
      return false;
    } else if (!regExp.hasMatch(_phoneNumController.text.trim())) {
      Get.snackbar('مهلاً', 'أدخل رقم هاتف صحيح', colorText: Colors.red);
      return false;
    } else if (_imageFile == null) {
      Get.snackbar('مهلاً', 'اختر صورة للبروفايل', colorText: Colors.red);
      return false;
    }
    return true;
  }
}
