import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/get/store_getx_controller.dart.dart';
import 'package:handcrafts/api/models/store.dart';
import 'package:handcrafts/api/models/user.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/app_text_form_field.dart';
import 'package:handcrafts/widgets/text_form_label.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/small_text.dart';


class AddStorePage extends StatefulWidget {
  const AddStorePage({Key? key}) : super(key: key);

  @override
  State<AddStorePage> createState() => _AddStorePageState();
}

class _AddStorePageState extends State<AddStorePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController(text: SharedPrefController().name);
  final TextEditingController _emailController = TextEditingController(text: SharedPrefController().email);
  final TextEditingController _phoneNumController = TextEditingController(text: SharedPrefController().phone);
  late TextEditingController _storeNameController;
  late TextEditingController _categoryNameController;
  final TextEditingController _countryNameController = TextEditingController(text: 'فلسطين');
  final TextEditingController _cityNameController = TextEditingController(text: 'غزة');
  late TextEditingController _whoUsController;
  late TextEditingController _facebookController;
  late TextEditingController _instagramController;
  late TextEditingController _tiktokController;

  File? _imageFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _storeNameController = TextEditingController();
    _categoryNameController = TextEditingController();
    _whoUsController = TextEditingController();
    _facebookController = TextEditingController();
    _instagramController = TextEditingController();
    _tiktokController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumController.dispose();
    _storeNameController.dispose();
    _categoryNameController.dispose();
    _countryNameController.dispose();
    _cityNameController.dispose();
    _whoUsController.dispose();
    _facebookController.dispose();
    _tiktokController.dispose();
    _instagramController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AllAppBar(
              text: 'إنشاء متجر',
              back: true,
              logo: false,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30).r,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100.h,
                          width: 100.w,
                          child:
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                            foregroundColor: Colors.grey,
                            backgroundImage: _imageFile != null
                                ? FileImage(File(_imageFile!.path))
                                : null,
                            child: _imageFile == null ? const Icon(Icons.person,size: 30,): null,
                          )
                        ),
                        SizedBox(height: 15.h),
                        InkWell(
                          onTap: () {
                            _pickImage();
                          },
                          child: SmallText(
                              text:'تعيين صورة المتجر',
                              color: kPrimaryColor, size: 14
                          ),
                        ),
                        SizedBox(height: 20.h),
                        const TextFormLabel(
                            icon: "assets/icons/profile.svg",
                            label: 'الاسم بالكامل'),
                        AppTextFormField(
                          controller: _fullNameController,
                          enabled: false,
                          onChanged: (value) {},
                        ),
                        SizedBox(height: 10.h),
                        const TextFormLabel(
                            icon: "assets/icons/add_user.svg",
                            label: 'الاسم التجاري'),
                        AppTextFormField(
                          controller: _storeNameController,
                          onChanged: (value){},
                        ),
                        SizedBox(height: 10.h),
                        const TextFormLabel(
                            icon: "assets/icons/email.svg",
                            label: 'البريد الإلكتروني'),
                        AppTextFormField(
                          controller: _emailController,
                          enabled: false,
                          onChanged: (value) {},
                        ),
                        SizedBox(height: 10.h),
                        const TextFormLabel(
                            icon: "assets/icons/call.svg", label: 'رقم الجوال'),
                        AppTextFormField(
                          controller: _phoneNumController,
                          hintText: '059/056',
                          enabled: false,
                          onChanged: (value) {},
                        ),

                        SizedBox(height: 10.h),
                        const TextFormLabel(
                            icon: "assets/icons/open_category.svg",
                            label: 'التصنيف'),
                        AppTextFormField(
                          hintText: 'تطريز، منحوتات ....',
                          controller: _categoryNameController,
                          onChanged: (value){},
                        ),
                        SizedBox(height: 10.h),
                        const TextFormLabel(
                            icon: "assets/icons/country.svg",
                            label: 'الدولة',
                        ),
                        AppTextFormField(
                          controller: _countryNameController,
                          enabled: false,
                          onChanged: (value){},
                        ),
                        SizedBox(height: 10.h),
                        const TextFormLabel(
                            icon: "assets/icons/location.svg",
                            label: 'المدينة'),
                        AppTextFormField(
                          controller: _cityNameController,
                          enabled: false,
                          onChanged: (value){},
                        ),

                        SizedBox(height: 10.h),
                        const TextFormLabel(
                            icon: "assets/icons/facebook.svg",
                            label: 'الفيس بوك'),
                        AppTextFormField(
                          controller: _facebookController,
                          onChanged: (value) {},
                          hintText: 'قم بإدخال رابط إن وجد',
                        ),
                        SizedBox(height: 10.h),
                        const TextFormLabel(
                            icon: "assets/icons/instagram.svg", label: 'الانستجرام'),
                        AppTextFormField(
                          controller: _instagramController,
                          hintText: 'قم بإدخال رابط إن وجد',
                          onChanged: (value) {},
                        ),
                        SizedBox(height: 10.h),
                        const TextFormLabel(
                            icon: "assets/icons/who_us.svg",
                            label: 'من نحن'),
                        AppTextFormField(
                          controller: _whoUsController,
                          maxLines: 15,
                          height: 200,
                          onChanged: (value) {},
                        ),
                        SizedBox(height: 40.h),
                        AppButton(
                          text: 'إنشاء متجر',
                          onPressed: () async {
                            print('Hi');
                            await _addNewStore();
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


  Store get store {
    Store store = Store();
    store.name = manipulateString(_fullNameController.text.trim());
    store.category = _categoryNameController.text.trim();
    store.storeOwner = _storeNameController.text.trim();
    store.urlInstagram = _instagramController.text.trim();
    store.urlFacebook = _facebookController.text.trim();
    store.description = _whoUsController.text.trim();
    store.logoImage = _imageFile!.path;
    return store;
  }

  UserApi get user {
    UserApi user = UserApi();
    user.email = _emailController.text.trim();
    user.phoneNumber = _phoneNumController.text.trim();
    user.name = _fullNameController.text.trim();
    return user;
  }

    String manipulateString(String input) {
      if (input.contains('متجر')) {
        return input;
      } else {
        return 'متجر $input';
      }
    }

    Future<void> _addNewStore() async {
    if(checkData()){
      print('SUCCESS 1');
      bool status = await StoreGetXController.to.addNewStore(store,user);
      if(status){
        print('SUCCESS 2');
        Get.snackbar('متجرك جاهز', 'سجل دخول لرؤية متجرك الخاص',
            duration: const Duration(seconds: 2));
        Navigator.pushNamed(context, '/login_register_screen');
      }else {

      }
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
    if (_fullNameController.text.isEmpty) {
      Get.snackbar('مهلاً', 'أدخل اسمك ', colorText: Colors.red);
      return false;
    } else if (_fullNameController.text.length < 3) {
      Get.snackbar('مهلاً', 'أدخل اسم لا يقل عن 3 حروف ',
          colorText: Colors.red);
      return false;
    } else if (_storeNameController.text.isEmpty) {
      Get.snackbar('مهلاً', 'أدخل اسمك ', colorText: Colors.red);
      return false;
    } else if (_storeNameController.text.length < 3) {
    Get.snackbar('مهلاً', 'أدخل اسم لا يقل عن 3 حروف ', colorText: Colors.red);
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
    } else if (_categoryNameController.text.isEmpty) {
      Get.snackbar('مهلاً', 'أدخل اسمك ', colorText: Colors.red);
      return false;
    }  else if (!regExp.hasMatch(_phoneNumController.text)) {
      Get.snackbar('مهلاً', 'أدخل رقم هاتف صحيح', colorText: Colors.red);
      return false;
    }else if (_whoUsController.text.isEmpty) {
      Get.snackbar('مهلاً', 'أدخل ايميلك ', colorText: Colors.red);
      return false;
    } else if (_imageFile == null) {
      Get.snackbar('مهلاً', 'اختر صورة للبروفايل', colorText: Colors.red);
      return false;
    }
    return true;
  }

}
