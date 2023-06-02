import 'package:flutter/material.dart';
import 'package:handcrafts/constants.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/app_text_form_field.dart';
import 'package:handcrafts/widgets/text_form_label.dart';

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


  late String _whoUs;
  late String _faceBook;
  late String _instagram;
  late String _tiktok;


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
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () {
                            // open gallery to reset the photo
                          },
                          child: Text(
                            'تعيين صورة المتجر',
                            style:
                            TextStyle(color: kPrimaryColor, fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const TextFormLabel(
                            icon: "assets/icons/who_us.svg",
                            label: 'من نحن'),
                        AppTextFormField(
                          controller: _whoUsController,
                          maxLines: 15,
                          height: 200,
                          onChanged: (value) {
                            _whoUs = value;
                          },
                          validator: validateName,
                        ),
                        const SizedBox(height: 10),
                        const TextFormLabel(
                            icon: "assets/icons/message.svg",
                            label: 'البريد الإلكتروني'),
                        AppTextFormField(
                          controller: _facebookController,
                          onChanged: (value) {
                            _faceBook = value;
                          },
                          validator: validateName,
                        ),
                        const SizedBox(height: 10),
                        const TextFormLabel(
                            icon: "assets/icons/call.svg", label: 'رقم الجوال'),
                        AppTextFormField(
                          controller: _instagramController,
                          onChanged: (value) {
                            _tiktok = value;
                          },
                          validator: validateName,
                        ),
                        const SizedBox(height: 40),
                        AppButton(
                          text: 'حفظ',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushNamed(
                                  context, '/basic_seller_screens');
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
      return null;
    } else {
      return null;
    }
  }
}