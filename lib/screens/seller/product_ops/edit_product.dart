import 'package:flutter/material.dart';
import 'package:handcrafts/screens/full_image_screen.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/app_text_form_field.dart';
import 'package:handcrafts/widgets/text_form_label.dart';


class EditProductPage extends StatefulWidget {
  const EditProductPage({Key? key}) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _productNameController;
  late TextEditingController _productDescriptionController;
  late TextEditingController _productPriceController;
  late TextEditingController _productDelivaryTimeController;

  late String _productName;
  late String _productDisc;
  late String _productPrice;
  late String _productDelivaryTime;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productNameController = TextEditingController();
    _productDescriptionController = TextEditingController();
    _productPriceController = TextEditingController();
    _productDelivaryTimeController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _productNameController.dispose();
    _productDescriptionController.dispose();
    _productPriceController.dispose();
    _productDelivaryTimeController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AllAppBar(text: 'تعديل منتج',back: true,logo: false,),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 350,
                          width: MediaQuery.of(context).size.width / 3.4,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => FullImageScreen(
                                      image: 'assets/images/product2.png',
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 107,
                                margin: const EdgeInsets.only(
                                    left: 15, bottom: 14.5),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'assets/images/product2.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FullImageScreen(
                                  image: 'assets/images/product2.png',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 350,
                            width:
                            MediaQuery.of(context).size.width / 1.58,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset('assets/images/product2.png',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const TextFormLabel(
                            icon: "assets/icons/product.svg",
                            label: 'اسم المنتج',
                            fontSize: 16,
                          ),
                          AppTextFormField(
                            controller: _productNameController,
                            onChanged: (value) {
                              _productName = value;
                            },
                            validator: validateName,
                            hintText: 'أدخل اسم المنتج',
                          ),
                          const SizedBox(height: 10),
                          const TextFormLabel(
                            icon: "assets/icons/descreption.svg",
                            label: 'الوصف',
                            fontSize: 16,
                          ),
                          AppTextFormField(
                            controller: _productDescriptionController,
                            onChanged: (value){
                              _productDisc = value;
                            },
                            validator: validateName,
                            height: 150,maxLines: 10,hintText: 'أدخل نص لا يزيد عن 70 حرف',
                          ),
                          const SizedBox(height: 10),
                          const TextFormLabel(
                            icon: "assets/icons/price.svg",
                            label: 'السعر',
                            fontSize: 16,
                          ),
                          AppTextFormField(
                            controller: _productPriceController,
                            onChanged: (value){
                              _productPrice = value;
                            },
                            validator: validateName,
                            hintText: 'أدخل سعر المنتج',
                          ),
                          const SizedBox(height: 10),
                          const TextFormLabel(
                            icon: "assets/icons/timer.svg",
                            label: 'مدة التسليم',
                            fontSize: 16,
                          ),
                          AppTextFormField(
                            hintText: 'مثال 2 يوم',
                            controller: _productDelivaryTimeController,
                            onChanged: (value){
                              _productDelivaryTime = value;
                            },
                            validator: validateName,
                          ),

                          const SizedBox(height: 40),
                          AppButton(
                            text: 'تعديل المنتج',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushNamed(context, '/basic_seller_screens');
                              }
                            },
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
}
