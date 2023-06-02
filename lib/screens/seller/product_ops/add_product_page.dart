import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/constants.dart';
import 'package:handcrafts/screens/sent_successfully_screen.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/app_text_form_field.dart';
import 'package:handcrafts/widgets/text_form_label.dart';



class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
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
                AllAppBar(text: 'إضافة منتج',back: true,logo: false,),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              InkWell(
                                onTap: (){

                                },
                                child: DottedBorder(
                                  color: kPrimaryColor,
                                  strokeWidth: 2,
                                  radius: Radius.circular(20),
                                  dashPattern: [7,7,7,7],
                                  padding: EdgeInsets.symmetric(horizontal: 40,vertical: 40),
                                  child: Center(child: SvgPicture.asset('assets/icons/cloud.svg',height: 25,width: 25,)),
                                ),
                              ),
                              SizedBox(height: 12,),
                              InkWell(
                                onTap: (){},
                                child: DottedBorder(
                                  color: kPrimaryColor,
                                  strokeWidth: 2,
                                  radius: Radius.circular(20),
                                  dashPattern: [7,7,7,7],
                                  padding: EdgeInsets.symmetric(horizontal: 40,vertical: 40),
                                  child: Center(child: SvgPicture.asset('assets/icons/cloud.svg',height: 25,width: 25,)),
                                ),
                              ),
                              SizedBox(height:12,),
                              InkWell(
                                onTap: (){
                                },
                                child: DottedBorder(
                                  color: kPrimaryColor,
                                  strokeWidth: 2,
                                  radius: Radius.circular(20),
                                  dashPattern: [7,7,7,7],
                                  padding: EdgeInsets.symmetric(horizontal: 40,vertical: 40),
                                  child: Center(child: SvgPicture.asset('assets/icons/cloud.svg',height: 25,width: 25,)),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: (){
                            },
                            child: DottedBorder(
                              color: kPrimaryColor,
                              strokeWidth: 2,
                              radius: Radius.circular(20),
                              dashPattern: [10,10,10,10],
                              padding: EdgeInsets.symmetric(horizontal: 100,vertical: 150),
                              child: Center(child: SvgPicture.asset('assets/icons/cloud.svg',height: 40,width: 40,)),
                            ),
                          )
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
                              text: 'تقديم المنتج',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder:
                                      (context) => const SentSuccessfullyScreen(
                                        mainText: 'تم تقديم طلب الاعتماد',
                                        subText: 'سيتم مراجعة الطلب خلال 24 ساعة',
                                      )));
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
