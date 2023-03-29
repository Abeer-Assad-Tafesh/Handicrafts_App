import 'package:flutter/material.dart';
import '../widgets/all_appBar.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_form_field.dart';
import '../widgets/text_form_label.dart';

class PurchaseDetails extends StatelessWidget {
  const PurchaseDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  const AllAppBar(),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30,top: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 25),
                          const TextFormLabel(
                              icon: Icons.home_outlined, label: 'العنوان'),
                          const SizedBox(height: 5),
                          const AppTextFormField(
                            maxLines: 5,
                          ),
                          const SizedBox(height: 22),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  children: const [
                                    TextFormLabel(
                                        icon: Icons.calendar_month_rounded,
                                        label: 'تاريخ التوصيل'),
                                    SizedBox(height: 5),
                                    AppTextFormField(),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  children: const [
                                    TextFormLabel(
                                        icon: Icons.access_time_rounded,
                                        label: 'وقت التوصيل'),
                                    SizedBox(height: 5),
                                    AppTextFormField(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          const TextFormLabel(
                              icon: Icons.money, label: 'وسيلة الدفع'),
                          const SizedBox(height: 5),
                          const AppTextFormField(
                            maxLines: 5,
                          ),
                          const SizedBox(height: 12),
                        ],
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
                        Navigator.pushReplacementNamed(context, '/sent_successfully');
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
}
