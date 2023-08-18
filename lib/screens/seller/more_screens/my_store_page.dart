import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/app_text_form_field.dart';
import 'package:handcrafts/widgets/small_text.dart';
import 'package:handcrafts/widgets/text_form_label.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../prefs/shared_pref_controller.dart';


class MyStorePage extends StatefulWidget {
  const MyStorePage({Key? key}) : super(key: key);

  @override
  State<MyStorePage> createState() => _MyStorePageState();
}

class _MyStorePageState extends State<MyStorePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _whoUsController;
  late TextEditingController _facebookController;
  late TextEditingController _instagramController;
  late TextEditingController _tiktokController;

  File? _imageFile;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _whoUsController = TextEditingController();
    _facebookController = TextEditingController();
    _instagramController = TextEditingController();
    _tiktokController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
              text: 'معلومات المتجر',
              back: true,
              logo: false,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20).r,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // SizedBox(
                        //   height: 100.h,
                        //   width: 100.w,
                        //   child: user!.profile?.imgProfile == null ?
                        //   CircleAvatar(
                        //     backgroundColor: Colors.indigo,
                        //     foregroundColor: Colors.deepPurpleAccent,
                        //     backgroundImage: _imageFile != null
                        //         ? FileImage(File(_imageFile!.path))
                        //         : null,
                        //     child: _imageFile == null ? Text(
                        //       SharedPrefController().name.substring(0, 1).toUpperCase(),
                        //       style: TextStyle(fontSize: 40.0.sp, fontWeight: FontWeight.bold, color: Colors.white),
                        //     ): null,
                        //   )
                        //       : CircleAvatar(
                        //     backgroundColor: Colors.grey.shade300,
                        //     foregroundColor: Colors.grey,
                        //     backgroundImage: _imageFile != null
                        //         ? FileImage(File(_imageFile!.path))
                        //         : FileImage(File(user.profile!.imgProfile!)),
                        //   ),
                        //
                        // ),
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
                            icon: "assets/icons/who_us.svg",
                            label: 'من نحن'),
                        AppTextFormField(
                          controller: _whoUsController,
                          maxLines: 15,
                          height: 200,
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
                            icon: "assets/icons/instagram.svg", label: 'الانستجرام'),
                        AppTextFormField(
                          controller: _instagramController,
                          hintText: 'قم بإدخال رابط إن وجد',
                          onChanged: (value) {},
                        ),
                        SizedBox(height: 40.h),
                        AppButton(
                          text: 'حفظ',
                          onPressed: () {
                              Navigator.pushNamed(
                                  context, '/basic_seller_screens');
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

  bool checkData() {
    if (_whoUsController.text.isEmpty) {
      Get.snackbar('مهلاً', 'أدخل ايميلك ', colorText: Colors.red);
      return false;
    } else if (_imageFile == null) {
      Get.snackbar('مهلاً', 'اختر صورة للبروفايل', colorText: Colors.red);
      return false;
    }
    return true;
  }

}