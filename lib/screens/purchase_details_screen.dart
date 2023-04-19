import 'package:flutter/material.dart';
import '../widgets/all_appBar.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_form_field.dart';
import '../widgets/text_form_label.dart';

class PurchaseDetails extends StatefulWidget {
  const PurchaseDetails({Key? key}) : super(key: key);

  @override
  State<PurchaseDetails> createState() => _PurchaseDetailsState();
}

class _PurchaseDetailsState extends State<PurchaseDetails> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _addressController;
  late TextEditingController _deliveryTimeController;
  late TextEditingController _deliveryDateController;
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _addressController.dispose();
    _deliveryTimeController.dispose();
    _deliveryDateController.dispose();
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
                      padding: const EdgeInsets.only(left: 30, right: 30,top: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 25),
                            const TextFormLabel(
                                icon: "assets/icons/address.svg", label: 'العنوان'),
                            const SizedBox(height: 5),
                            AppTextFormField(
                              controller: _addressController,
                              onChanged: (value) {
                                _address = value;
                              },
                              validator: validateName,
                              maxLines: 5,
                            ),
                            const SizedBox(height: 22),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const TextFormLabel(
                                          icon: "assets/icons/calendar.svg",
                                          label: 'تاريخ التوصيل'),
                                      const SizedBox(height: 5),
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
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const TextFormLabel(
                                          icon: "assets/icons/time.svg",
                                          label: 'وقت التوصيل'),
                                      const SizedBox(height: 5),
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
                            const SizedBox(height: 22),
                            const TextFormLabel(
                                icon: "assets/icons/pay_method.svg", label: 'وسيلة الدفع'),
                            const SizedBox(height: 5),
                            AppTextFormField(
                              controller: _addressController,
                              onChanged: (value) {
                                _payMethod = value;
                              },
                              validator: validateName,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('المجموع'),
                        Text('60\$'),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('التوصيل'),
                        Text('4\$'),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('الإجمالي'),
                        Text('64\$'),
                      ],
                    ),
                    const SizedBox(height: 60,),
                    AppButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          Navigator.pushNamed(context, '/sent_successfully_screen');
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
                        // Navigator.pushReplacementNamed(context, '/sent_successfully_screen');
                      },
                      text: 'تأكيد الطلب',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'الرجاء ملء الحقل';
    } else {
      return null;
    }
  }

}
