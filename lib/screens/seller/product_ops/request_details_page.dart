import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/constants.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/app_text_form_field.dart';
import 'package:handcrafts/widgets/big_text.dart';
import 'package:handcrafts/widgets/small_text.dart';
import 'package:handcrafts/widgets/text_form_label.dart';

class RequestDetailsPage extends StatefulWidget {
  const RequestDetailsPage({Key? key}) : super(key: key);

  @override
  State<RequestDetailsPage> createState() => _RequestDetailsPageState();
}

class _RequestDetailsPageState extends State<RequestDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumController;
  late TextEditingController _passwordController;
  late String _name;
  late String _email;
  late String _password;
  late String _phone;


  final List<String> items = [
    "اختر حالة الطلب",
    "قيد المراجعة",
    "قيد التجهيز",
    "قيد التوصيل",
    "مكتملة",
  ];

  int current = 0;

  late String selectedOption;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumController = TextEditingController();
    _passwordController = TextEditingController();
    selectedOption = items[0];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AllAppBar(
              text: 'تفاصيل الطلب',
              back: true,
              logo: false,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,
                  right: 20,top: 5),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallText(text: '20.Dec,2022',color: Colors.grey,size: 12,),
                            SmallText(text: '2:15 Am',color: Colors.grey,size: 12,),
                          ],
                        ),
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
                        const SizedBox(height: 10),
                        Text(
                          'محمود أحمد منصور',
                          style: TextStyle(color: kPrimaryColor, fontSize: 14),
                        ),
                        SmallText(text: 'ID: 276332',size: 14,color: kPrimaryColor,),
                        const SizedBox(height: 20),
                        AppTextFormField(
                          controller: _fullNameController,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(13),
                              child: SvgPicture.asset("assets/icons/profile.svg"),
                          ),
                          onChanged: (value) {
                            _name = value;
                          },
                        ),
                        const SizedBox(height: 10),
                        AppTextFormField(
                          controller: _emailController,
                          prefixIcon: Padding(
                              padding: EdgeInsets.all(13),
                              child: SvgPicture.asset("assets/icons/message.svg")),
                          onChanged: (value) {
                            _email = value;
                          },
                        ),
                        const SizedBox(height: 10),
                        AppTextFormField(
                          controller: _phoneNumController,
                          prefixIcon: Padding(
                              padding: EdgeInsets.all(13),
                              child: SvgPicture.asset("assets/icons/call.svg")),
                          onChanged: (value) {
                            _phone = value;
                          },
                        ),
                        const SizedBox(height: 10),
                        AppTextFormField(
                          controller: _fullNameController,
                          prefixIcon: Padding(
                              padding: EdgeInsets.all(13),
                              child: SvgPicture.asset("assets/icons/calendar.svg")
                          ),
                          onChanged: (value) {
                            _name = value;
                          },
                        ),
                        SizedBox(height: 5),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: Colors.grey.shade300)
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex:2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.asset(
                                        'assets/images/product5.png',
                                        fit: BoxFit.fill,
                                        height: 90,
                                        width: 100,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        BigText(text: 'اسم المنتج',size: 18,),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/calendar.svg",
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              'يومين عمل',
                                              style: TextStyle(
                                                  fontSize: 13, color: kPrimaryColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex:2,
                                    child: Container(
                                      height: 100,
                                      alignment: Alignment.center,
                                      color: kSecondaryColor,
                                      child: BigText(text: '20\$'),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.topRight,
                          child: DropdownButtonHideUnderline(
                            child: Container(
                              width: 180,
                              alignment: Alignment.center,
                              child: DropdownButtonFormField<String>(
                                value: selectedOption,
                                iconSize: 35,
                                icon: Icon(Icons.arrow_drop_down_sharp,color: kPrimaryColor,),
                                decoration:  const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  contentPadding: EdgeInsets.only(right: 8),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedOption = newValue!;
                                  });
                                },
                                items: items.map((String option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    child: Text(option),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Column(
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
                            const SizedBox(height: 10,),
                          ],
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
}
