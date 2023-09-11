import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/get/product_getx_controller.dart.dart';
import 'package:handcrafts/api/models/product.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/screens/sent_successfully_screen.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/app_text_form_field.dart';
import 'package:handcrafts/widgets/text_form_label.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../api/models/product_images.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final ProductGetXController _productGetXController = Get.find();

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _productNameController;
  late TextEditingController _productDescriptionController;
  late TextEditingController _productPriceController;
  late TextEditingController _productDelivaryTimeController;

  List<XFile?> _imageList = List.generate(4, (index) => null);

  final picker = ImagePicker();
  bool isLoading = false;

  Future getImage(int index) async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageList[index] = pickedFile;
      });
    }
  }

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
              AllAppBar(
                text: 'إضافة منتج',
                back: true,
                logo: false,
              ),
              Stack(
                children : [
                  Padding(
                      padding: const EdgeInsets.all(15.0).r,
                      child: GetBuilder<ProductGetXController>(
                        builder: (controller) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          getImage(3);
                                        },
                                        child: DottedBorder(
                                          color: kPrimaryColor,
                                          strokeWidth: 2,
                                          radius: const Radius.circular(20).r,
                                          dashPattern: const [7, 7, 7, 7],
                                          // padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 40.h),
                                          child: SizedBox(
                                            height: 102,
                                            width: 130,
                                            child: _imageList[3] != null
                                                ? Image.file(
                                              File(_imageList[3]!.path),
                                              fit: BoxFit.cover,
                                            )
                                                : Center(
                                                child: SvgPicture.asset(
                                                  'assets/icons/cloud.svg',
                                                  height: 25.h,
                                                  width: 25.w,
                                                )),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          getImage(2);
                                        },
                                        child: DottedBorder(
                                          color: kPrimaryColor,
                                          strokeWidth: 2,
                                          radius: const Radius.circular(20).r,
                                          dashPattern: const [7, 7, 7, 7],
                                          // padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 40.h),
                                          child: SizedBox(
                                            height: 102,
                                            width: 130,
                                            child: _imageList[2] != null
                                                ? Image.file(
                                              File(_imageList[2]!.path),
                                              fit: BoxFit.cover,
                                            )
                                                : Center(
                                                child: SvgPicture.asset(
                                                  'assets/icons/cloud.svg',
                                                  height: 25.h,
                                                  width: 25.w,
                                                )),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          getImage(1);
                                        },
                                        child: DottedBorder(
                                          color: kPrimaryColor,
                                          strokeWidth: 2,
                                          radius: const Radius.circular(20).r,
                                          dashPattern: const [7, 7, 7, 7],
                                          // padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 40.h),
                                          child: SizedBox(
                                            height: 102,
                                            width: 130,
                                            child: _imageList[1] != null
                                                ? Image.file(
                                              File(_imageList[1]!.path),
                                              fit: BoxFit.cover,
                                            )
                                                : Center(
                                                child: SvgPicture.asset(
                                                  'assets/icons/cloud.svg',
                                                  height: 25.h,
                                                  width: 25.w,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      getImage(0);
                                    },
                                    child: DottedBorder(
                                      color: kPrimaryColor,
                                      strokeWidth: 2,
                                      radius: const Radius.circular(20).r,
                                      dashPattern: [10.w, 10.w, 10.w, 10.w],
                                      // padding: EdgeInsets.symmetric(horizontal: 100.w,vertical: 150.h),
                                      child: SizedBox(
                                        height: 335.h,
                                        width: 225.w,
                                        child: _imageList[0] != null
                                            ? Image.file(
                                          File(_imageList[0]!.path),
                                          fit: BoxFit.cover,
                                        )
                                            : Center(
                                            child: SvgPicture.asset(
                                              'assets/icons/cloud.svg',
                                              height: 40.h,
                                              width: 40.w,
                                            )),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 20.h),
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
                                      onChanged: (value) {},
                                      hintText: 'أدخل اسم المنتج',
                                    ),
                                    SizedBox(height: 10.h),
                                    const TextFormLabel(
                                      icon: "assets/icons/descreption.svg",
                                      label: 'الوصف',
                                      fontSize: 16,
                                    ),
                                    AppTextFormField(
                                      controller:
                                      _productDescriptionController,
                                      onChanged: (value) {},
                                      height: 150,
                                      maxLines: 10,
                                      hintText: 'أدخل نص لا يزيد عن 70 حرف',
                                    ),
                                    SizedBox(height: 10.h),
                                    const TextFormLabel(
                                      icon: "assets/icons/price.svg",
                                      label: 'السعر',
                                      fontSize: 16,
                                    ),
                                    AppTextFormField(
                                      controller: _productPriceController,
                                      onChanged: (value) {},
                                      hintText: 'أدخل سعر المنتج',
                                    ),
                                    SizedBox(height: 10.h),
                                    const TextFormLabel(
                                      icon: "assets/icons/timer.svg",
                                      label: 'مدة التسليم',
                                      fontSize: 16,
                                    ),
                                    AppTextFormField(
                                      hintText: 'مثال 2 يوم',
                                      controller:
                                      _productDelivaryTimeController,
                                      onChanged: (value) {},
                                    ),
                                    SizedBox(height: 40.h),
                                    AppButton(
                                      text: 'تقديم المنتج',
                                      onPressed: () {
                                        _createProduct();
                                      },
                                    ),
                                    SizedBox(height: 40.h),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      )),
                  isLoading ? Positioned.fill(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    ),
                  ): Container()
                ]
              ),
            ],
          ),
        ),
      ),
    );
  }


  Product get product {
    Product newProduct = Product();
    newProduct.name = _productNameController.text.trim();
    newProduct.description = _productDescriptionController.text.trim();
    newProduct.price = double.parse(_productPriceController.text.trim());
    newProduct.quantity = int.parse('0');
    newProduct.deliveryPeriod = int.parse(_productDelivaryTimeController.text.trim());
    newProduct.productImages =
        _imageList.map((image) => ProductImage(imageUrl: image!.path)).toList();
    return newProduct;
  }

  Future<void> _createProduct() async {
    if (checkData()) {
      setState(() {
        isLoading = true;
      });
      bool created =
          await ProductGetXController.to.createProduct(product: product);
      if (created) {
        navigate();
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  void navigate() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SentSuccessfullyScreen(
          mainText: 'تم تقديم طلب الاعتماد',
          subText: 'سيتم مراجعة الطلب خلال 24 ساعة',
        ),
      ),
    );
  }

  bool checkData() {
    for (int i = 0; i < _imageList.length; i++) {
      if (_imageList[i] == null) {
        Get.snackbar('مهلاً', 'الرجاء ملء حقل الصور رقم ${i + 1} ',
            colorText: kPrimaryColor);
        return false;
      }
    }
    if (_productNameController.text.isNotEmpty &&
        _productDescriptionController.text.isNotEmpty &&
        _productPriceController.text.isNotEmpty) {
      return true;
    }
    for (var char in _productPriceController.text.runes) {
      if (String.fromCharCode(char).isAlphabetOnly) {
        Get.snackbar('مهلاً', 'أدخل رقم فقط في حقل مدة التسليم', colorText: Colors.red);
        return false;
      }
    }
    for (var char in _productDelivaryTimeController.text.runes) {
      if (String.fromCharCode(char).isAlphabetOnly) {
        Get.snackbar('مهلاً', 'أدخل رقم فقط في حقل مدة التسليم', colorText: Colors.red);
        return false;
      }
    }
    Get.snackbar('مهلاً', 'الرجاء ملء باقي الحقول', colorText: kPrimaryColor);
    return false;
  }

}
