import 'package:flutter/material.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/app_text_form_field.dart';
import 'package:handcrafts/widgets/text_form_label.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class StoreInfoPage extends StatefulWidget {
  const StoreInfoPage({Key? key}) : super(key: key);

  @override
  State<StoreInfoPage> createState() => _StoreInfoPageState();
}

class _StoreInfoPageState extends State<StoreInfoPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumController;
  late TextEditingController _passwordController;
  late TextEditingController _storeNameController;
  late TextEditingController _categoryNameController;
  late TextEditingController _countryNameController;
  late TextEditingController _cityNameController;

  late String _name;
  late String _email;
  late String _password;
  late String _phone;
  late String _storeName;
  late String _categoryName;
  late String _countryName;
  late String _cityName;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumController = TextEditingController();
    _passwordController = TextEditingController();
    _storeNameController = TextEditingController();
    _categoryNameController = TextEditingController();
    _countryNameController = TextEditingController();
    _cityNameController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumController.dispose();
    _storeNameController.dispose();
    _categoryNameController.dispose();
    _countryNameController.dispose();
    _cityNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AllAppBar(
              text: 'معلومات المتجر',
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
                        SizedBox(height: 10.h),
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
                        SizedBox(height: 10.h),
                        const TextFormLabel(
                            icon: "assets/icons/call.svg", label: 'رقم الجوال'),
                        AppTextFormField(
                          controller: _phoneNumController,
                          hintText: '059/056',
                          onChanged: (value) {
                            _phone = value;
                          },
                          validator: validatePhoneNum,
                        ),
                        SizedBox(height: 10.h),
                        const TextFormLabel(
                            icon: "assets/icons/add_user.svg",
                            label: 'الاسم التجاري'),
                        AppTextFormField(
                          controller: _storeNameController,
                          onChanged: (value){
                            _storeName = value;
                          },
                          validator: validateName,
                        ),
                        SizedBox(height: 10.h),
                        const TextFormLabel(
                            icon: "assets/icons/open_category.svg",
                            label: 'التصنيف'),
                        AppTextFormField(
                          hintText: 'تطريز، منحوتات ....',
                          controller: _categoryNameController,
                          onChanged: (value){
                            _categoryName = value;
                          },
                          validator: validateName,
                        ),
                        SizedBox(height: 10.h),
                        const TextFormLabel(
                            icon: "assets/icons/country.svg",
                            label: 'الدولة'),
                        AppTextFormField(
                          controller: _countryNameController,
                          onChanged: (value){
                            _countryName = value;
                          },
                          validator: validateName,
                        ),
                        SizedBox(height: 10.h),
                        const TextFormLabel(
                            icon: "assets/icons/location.svg",
                            label: 'المدينة'),
                        AppTextFormField(
                          controller: _cityNameController,
                          onChanged: (value){
                            _cityName = value;
                          },
                          validator: validateName,
                        ),
                        SizedBox(height: 40.h),
                        AppButton(
                          text: 'تعديل',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushNamed(context, '/basic_seller_screens');
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
      return 'أدخل النص المطلوب';
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
    } else if (!regExp.hasMatch(value)) {
      return 'أدخل رقم هاتف صحيح';
    }
    return null;
  }
}
