import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/api/controllers/cart_controller.dart';
import 'package:handcrafts/models/cart_model.dart';
import 'package:handcrafts/widgets/small_text.dart';
import '../widgets/all_appBar.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_form_field.dart';
import '../widgets/text_form_label.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PurchaseDetails extends StatefulWidget {
  double? productsPrice;
  PurchaseDetails({Key? key,this.productsPrice}) : super(key: key);

  @override
  State<PurchaseDetails> createState() => _PurchaseDetailsState();
}

class _PurchaseDetailsState extends State<PurchaseDetails> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _addressController;
  late TextEditingController _deliveryTimeController;
  late TextEditingController _deliveryDateController;
   TextEditingController _payMethodController = TextEditingController(text: 'عند الإستلام');
  late String _address;
  late String _deliveryTime;
  late String _deliveryDate;
  late String _payMethod;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addressController = TextEditingController();
    _deliveryTimeController = TextEditingController();
    _deliveryDateController = TextEditingController();
    // _payMethodController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _addressController.dispose();
    _deliveryTimeController.dispose();
    _deliveryDateController.dispose();
    _payMethodController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  AllAppBar(back: true, text: 'شراء',),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.w, right: 30.w,top: 20.h),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 25.h),
                            const TextFormLabel(
                                icon: "assets/icons/address.svg", label: 'العنوان'),
                            SizedBox(height: 5.h),
                            AppTextFormField(
                              controller: _addressController,
                              onChanged: (value) {
                                _address = value;
                              },
                              validator: validateName,
                              maxLines: 3,
                            ),
                            SizedBox(height: 22.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const TextFormLabel(
                                          icon: "assets/icons/calendar.svg",
                                          label: 'تاريخ التوصيل'),
                                       SizedBox(height: 5.h),
                                      AppTextFormField(
                                        controller: _deliveryDateController,
                                        onChanged: (value) {
                                          _deliveryDate = value;
                                        },
                                        validator: validateName,
                                        hintText: '22/10/2023',
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const TextFormLabel(
                                          icon: "assets/icons/time.svg",
                                          label: 'وقت التوصيل'),
                                      SizedBox(height: 5.h),
                                      AppTextFormField(
                                        controller: _deliveryTimeController,
                                        onChanged: (value) {
                                          _deliveryTime = value;
                                        },
                                        validator: validateName,
                                        hintText: '2:30 Am',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 22.h),
                            const TextFormLabel(
                                icon: "assets/icons/pay_method.svg", label: 'وسيلة الدفع'),
                            SizedBox(height: 5.h),
                            AppTextFormField(
                              controller: _payMethodController,
                              enabled: false,
                              onChanged: (value) {
                                _payMethod = value;
                              },
                              validator: validateName,
                              maxLines: 1,
                            ),
                            SizedBox(height: 12.h),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: const EdgeInsets.all(10).r,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: 'المجموع',
                          size: 14.sp,
                          color: Colors.grey,
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '16',
                                style: TextStyle(fontSize: 20.0,
                                  color: kPrimaryColor,
                                ),
                              ),
                              TextSpan(
                                text: '₪',
                                style: TextStyle(fontSize: 14.0,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: 'التوصيل',
                          size: 14.sp,
                          color: Colors.grey,
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '20',
                                style: TextStyle(fontSize: 20.0,                                  color: kPrimaryColor,
                                ),
                              ),
                              TextSpan(
                                text: '₪',
                                style: TextStyle(fontSize: 14.0,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: 'الإجمالي',
                          size: 14.sp,
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '38',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor
                                ),
                              ),
                              TextSpan(
                                text: '₪',
                                style: TextStyle(fontSize: 16.0,
                                    color: kPrimaryColor
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                  ],
                ),
              ),
              GetBuilder<CartController>(builder: (controller){
                return AppButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      double productsPrice = controller.totalCartProductsPrice;
                      List<CartModel> products = controller.getItems;
                      confirmOrder(products,productsPrice);
                      controller.addItemsToHistory();
                    }
                  },
                  text:
                  'تأكيد الطلب',
                );
              })
            ],
          ),
        ),
      ),
    );
  }


  confirmOrder(List<CartModel> products, double productsPrice){
    print('$products    $productsPrice');
    // ارسال كل الحقول مع البارميترات باستخدام api
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'الرجاء ملء الحقل';
    } else {
      return null;
    }
  }

}
