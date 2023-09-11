import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/api_settings.dart';
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

class StoreInfoPage extends StatefulWidget {
  const StoreInfoPage({Key? key}) : super(key: key);

  @override
  State<StoreInfoPage> createState() => _StoreInfoPageState();
}

class _StoreInfoPageState extends State<StoreInfoPage> {
  final StoreGetXController _storeController = Get.find();

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController =
      TextEditingController(text: _storeController.store?.name ?? '');
  late TextEditingController _emailController =
      TextEditingController(text: _storeController.store?.email ?? '');
  late TextEditingController _phoneNumController =
      TextEditingController(text: _storeController.store?.phoneWhatsapp ?? '');
  late TextEditingController _storeNameController =
      TextEditingController(text: _storeController.store?.storeOwner ?? '');
  late TextEditingController _categoryNameController =
      TextEditingController(text: _storeController.store?.category ?? '');
  late TextEditingController _countryNameController =
      TextEditingController(text: 'فلسطين');
  late TextEditingController _cityNameController =
      TextEditingController(text: 'غزة');
  late TextEditingController _whoUsController =
      TextEditingController(text: _storeController.store?.description ?? '');
  late TextEditingController _facebookController =
      TextEditingController(text: _storeController.store?.urlFacebook ?? '');
  late TextEditingController _instagramController =
      TextEditingController(text: _storeController.store?.urlInstagram ?? '');

  File? _imageFile;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    _instagramController.dispose();
    super.dispose();
  }

  void _updateTextControllers(Store updatedUStore) {
    _fullNameController.text = updatedUStore.name!;
    _emailController.text = updatedUStore.email!;
    _phoneNumController.text = updatedUStore.phoneWhatsapp! ?? '';
    _storeNameController.text = updatedUStore.storeOwner! ?? '';
    _categoryNameController.text = updatedUStore.category! ?? '';
    _whoUsController.text = updatedUStore.description! ?? '';
    _facebookController.text = updatedUStore.urlFacebook! ?? '';
    _instagramController.text = updatedUStore.urlInstagram! ?? '';
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
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: GetBuilder<StoreGetXController>(
                      builder: (controller) {
                        var store = controller.store;
                        print('${store}');
                        print('${SharedPrefController().craftsmanStoreId}');
                        return Padding(
                          padding: const EdgeInsets.all(30).r,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                    height: 100.h,
                                    width: 100.w,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey.shade300,
                                      foregroundColor: Colors.grey,
                                      backgroundImage: _imageFile != null
                                          ? FileImage(File(_imageFile!.path))
                                          : null,
                                      child: _imageFile == null
                                          ? ClipOval(
                                        child: Image.network(
                                          ApiSettings.getImageUrl(store!
                                              .logoImage!
                                              .replaceFirst('uploads/', '')),
                                          fit: BoxFit.cover,
                                          width: 100.0,
                                          height: 100.0,
                                        ),
                                      )
                                          : Container(), // Empty container when _imageFile is not null
                                    )),
                                SizedBox(height: 15.h),
                                InkWell(
                                  onTap: () {
                                    _pickImage();
                                  },
                                  child: SmallText(
                                      text: 'تغيير صورة المتجر',
                                      color: kPrimaryColor,
                                      size: 14),
                                ),
                                SizedBox(height: 20.h),
                                const TextFormLabel(
                                    icon: "assets/icons/profile.svg",
                                    label: 'الاسم بالكامل'),
                                AppTextFormField(
                                  controller: _fullNameController,
                                  onChanged: (value) {},
                                ),
                                SizedBox(height: 10.h),
                                const TextFormLabel(
                                    icon: "assets/icons/add_user.svg",
                                    label: 'الاسم التجاري'),
                                AppTextFormField(
                                  controller: _storeNameController,
                                  onChanged: (value) {},
                                ),
                                SizedBox(height: 10.h),
                                const TextFormLabel(
                                    icon: "assets/icons/email.svg",
                                    label: 'البريد الإلكتروني'),
                                AppTextFormField(
                                  controller: _emailController,
                                  onChanged: (value) {},
                                ),
                                SizedBox(height: 10.h),
                                const TextFormLabel(
                                    icon: "assets/icons/call.svg",
                                    label: 'رقم الجوال'),
                                AppTextFormField(
                                  controller: _phoneNumController,
                                  hintText: '059/056',
                                  onChanged: (value) {},
                                ),
                                SizedBox(height: 10.h),
                                const TextFormLabel(
                                    icon: "assets/icons/open_category.svg",
                                    label: 'التصنيف'),
                                AppTextFormField(
                                  hintText: 'تطريز، منحوتات ....',
                                  controller: _categoryNameController,
                                  onChanged: (value) {},
                                ),
                                SizedBox(height: 10.h),
                                const TextFormLabel(
                                  icon: "assets/icons/country.svg",
                                  label: 'الدولة',
                                ),
                                AppTextFormField(
                                  controller: _countryNameController,
                                  enabled: false,
                                  onChanged: (value) {},
                                ),
                                SizedBox(height: 10.h),
                                const TextFormLabel(
                                    icon: "assets/icons/location.svg",
                                    label: 'المدينة'),
                                AppTextFormField(
                                  controller: _cityNameController,
                                  enabled: false,
                                  onChanged: (value) {},
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
                                    icon: "assets/icons/instagram.svg",
                                    label: 'الانستجرام'),
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
                                  text: 'تعديل',
                                  onPressed: () {
                                    // Navigator.pushNamed(context, '/basic_seller_screens');
                                    updateStoreInfo();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  isLoading ? Container(
                    // color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
                    child:  Center(
                      child: CircularProgressIndicator(color:  kPrimaryColor,),
                    ),
                  ): Container()
                ],
              )
            ),
          ],
        ),
      ),
    );
  }



  Store get store {
    Store store = Store();
    store.name = _fullNameController.text.trim();
    store.phoneWhatsapp = _phoneNumController.text.trim();
    store.email =SharedPrefController().email;
    store.category = _categoryNameController.text.trim();
    store.storeOwner = _storeNameController.text.trim();
    store.urlInstagram = _instagramController.text.trim();
    store.urlFacebook = _facebookController.text.trim();
    store.description = _whoUsController.text.trim();
    store.id = int.parse(SharedPrefController().craftsmanStoreId);
    store.logoImage = _imageFile?.path != null ? _imageFile!.path
        : _storeController.store?.logoImage?.replaceFirst('uploads/assets/images/stores/', '')  ;
    print('logo:   ${store.logoImage}');
    return store;
  }

  UserApi get userApi {
    UserApi user = UserApi();
    user.name = _fullNameController.text.trim();
    user.email = _emailController.text.trim();
    user.phoneNumber = _phoneNumController.text.trim();
    user.id = int.parse(SharedPrefController().id);
    user.typeUser = SharedPrefController().typeUser;
    print('====> ${SharedPrefController().email}');
    return user;
  }

  String manipulateString(String input) {
    if (input.contains('متجر')) {
      return input;
    } else {
      return 'متجر ' + input;
    }
  }

  Future<void> updateStoreInfo() async {
    if (checkData()) {
      setState(() {
        isLoading = true;
      });
      bool status = await StoreGetXController.to.updateStoreInfo(store, userApi);
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
            SharedPrefController()
                .save(user: userApi, token: SharedPrefController().token.replaceFirst('Bearer ', ''));
            // Update the controllers with the new data after successful update
            setState(() {
              _storeController.store!.name = store.name;
              _storeController.store!.email = store.email;
              _storeController.store!.phoneWhatsapp = store.phoneWhatsapp;
              // _storeController.store!.logoImage = store.logoImage;
              _storeController.store!.urlInstagram = store.urlInstagram;
              _storeController.store!.urlFacebook = store.urlFacebook;
              _storeController.store!.storeOwner = store.storeOwner;
              _storeController.store!.category = store.category;
              _storeController.store!.description = store.description;
              // _storeController.store!.deliveryPrice = store.deliveryPrice;
            });
            _updateTextControllers(store);
            setState(() {
              isLoading = false;
            });
            Navigator.pop(context);
            // Navigator.pushNamed(context, '/basic_seller_screens');
          } catch (e) {
            print('error: $e');
            Get.snackbar('خطأ!', 'حاول مرة أخرى', colorText: Colors.red);
            setState(() {
              isLoading = false;
            });
          }
        } else {
          /*Get.snackbar('فشل التعديل', 'حاول مرة أخرى',
              duration: const Duration(seconds: 2));*/
        }
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
    } else {}
  }

  final RegExp regex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)| (\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
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
    } else if (_categoryNameController.text.isEmpty) {
      Get.snackbar('مهلاً', 'أدخل اسمك ', colorText: Colors.red);
      return false;
    } else if (!regExp.hasMatch(_phoneNumController.text)) {
      Get.snackbar('مهلاً', 'أدخل رقم هاتف صحيح', colorText: Colors.red);
      return false;
    } else if (_whoUsController.text.isEmpty) {
      Get.snackbar('مهلاً', 'أدخل ايميلك ', colorText: Colors.red);
      return false;
    }
    return true;
  }
}
