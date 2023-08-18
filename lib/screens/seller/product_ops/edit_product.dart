import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/get/product_getx_controller.dart.dart';
import 'package:handcrafts/api/models/product.dart';
import 'package:handcrafts/screens/full_image_screen.dart';
import 'package:handcrafts/screens/sent_successfully_screen.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/app_text_form_field.dart';
import 'package:handcrafts/widgets/text_form_label.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../api/models/product_images.dart';


class EditProductPage extends StatefulWidget {

  Product? product;
  EditProductPage({Key? key, this.product}) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productDescriptionController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();
  TextEditingController _productDeliveryTimeController = TextEditingController();

  List<XFile?> _imageList = List.generate(4, (index) => null);

  final picker = ImagePicker();

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
    super.initState();
    _productNameController.text = widget.product?.name ?? '';
    _productDescriptionController.text = widget.product?.description ?? '';
    _productPriceController.text = widget.product?.price?.toString() ?? '';
    _productDeliveryTimeController.text = widget.product?.deliveryPeriod.toString() ?? '';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _productNameController.dispose();
    _productDescriptionController.dispose();
    _productPriceController.dispose();
    _productDeliveryTimeController.dispose();
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
                padding: const EdgeInsets.all(15.0).r,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      : Image.file(
                                          File(
                                              widget.product!.productImages![3].imageUrl),
                                          fit: BoxFit.cover,
                                        ),
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
                                      : Image.file(
                                    File(widget.product!.productImages![2].imageUrl),
                                    fit: BoxFit.cover,
                                  ),
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
                                      : Image.file(
                                    File(widget.product!.productImages![1].imageUrl),
                                    fit: BoxFit.cover,
                                  ),
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
                                fit: BoxFit.fitWidth,
                              )
                                  :Image.file(
                                File(widget.product!.productImages![0].imageUrl),
                                fit: BoxFit.cover,
                              ),
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
                            onChanged: (value) {
                            },
                            hintText: 'أدخل اسم المنتج',
                          ),
                          SizedBox(height: 10.h),
                          const TextFormLabel(
                            icon: "assets/icons/descreption.svg",
                            label: 'الوصف',
                            fontSize: 16,
                          ),
                          AppTextFormField(
                            controller: _productDescriptionController,
                            onChanged: (value){
                            },
                            height: 150,maxLines: 10,hintText: 'أدخل نص لا يزيد عن 70 حرف',
                          ),
                          SizedBox(height: 10.h),
                          const TextFormLabel(
                            icon: "assets/icons/price.svg",
                            label: 'السعر',
                            fontSize: 16,
                          ),
                          AppTextFormField(
                            controller: _productPriceController,
                            onChanged: (value){
                            },
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
                            controller: _productDeliveryTimeController,
                            onChanged: (value){
                            },
                          ),

                          SizedBox(height: 40.h),
                          AppButton(
                            text: 'تعديل المنتج',
                            onPressed: () {
                              _updateProduct();
                                // Navigator.pushNamed(context, '/basic_seller_screens');
                            },
                          ),
                          SizedBox(height: 40.h),
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
    Get.snackbar('مهلاً', 'الرجاء ملء باقي الحقول', colorText: kPrimaryColor);
    return false;
  }

  Product get product {
    Product newProduct = Product();
    newProduct.name = _productNameController.text;
    newProduct.description = _productDescriptionController.text;
    newProduct.price = double.parse(_productPriceController.text);
    newProduct.quantity = int.parse('0');
    // newProduct.: int.parse(_productDeliveryTimeController.text);
    newProduct.productImages = _imageList.map((image) => ProductImage(imageUrl: image!.path)).toList();
    return newProduct;
  }

  Future<void> _updateProduct() async {
    if (checkData()) {
      bool created =
      await ProductGetXController.to.updateProduct(product: product);
      if (created) {
        navigate();
      }
    }
  }

  void navigate(){
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


}
