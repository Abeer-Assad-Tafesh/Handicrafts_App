import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/app_text_form_field.dart';
import 'package:handcrafts/widgets/big_text.dart';
import 'package:handcrafts/widgets/small_text.dart';
import 'package:handcrafts/widgets/text_form_label.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
                  padding: EdgeInsets.only(left: 20.w,
                  right: 20.w,top: 5.h),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallText(text: '20.Dec,2022',color: Colors.grey,size: 12,),
                            SmallText(text: '2:15 Am',color: Colors.grey,size: 12,),
                          ],
                        ),
                        SizedBox(
                          height: 100.h,
                          width: 100.w,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            foregroundColor: Colors.grey,
                            child: Icon(
                              Icons.person_outline_rounded,
                              size: 40.w,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SmallText(
                          text:'محمود أحمد منصور',
                          color: kPrimaryColor, size: 14,
                        ),
                        SmallText(text: 'ID: 276332',size: 14,color: kPrimaryColor,),
                        SizedBox(height: 20.h),
                        AppTextFormField(
                          controller: _fullNameController,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(13).r,
                              child: SvgPicture.asset("assets/icons/profile.svg"),
                          ),
                          onChanged: (value) {
                            _name = value;
                          },
                        ),
                        SizedBox(height: 10.h),
                        AppTextFormField(
                          controller: _emailController,
                          prefixIcon: Padding(
                              padding: const EdgeInsets.all(13).r,
                              child: SvgPicture.asset("assets/icons/email.svg")),
                          onChanged: (value) {
                            _email = value;
                          },
                        ),
                        SizedBox(height: 10.h),
                        AppTextFormField(
                          controller: _phoneNumController,
                          prefixIcon: Padding(
                              padding: const EdgeInsets.all(13).r,
                              child: SvgPicture.asset("assets/icons/call.svg")),
                          onChanged: (value) {
                            _phone = value;
                          },
                        ),
                        SizedBox(height: 10.h),
                        AppTextFormField(
                          controller: _fullNameController,
                          prefixIcon: Padding(
                              padding: const EdgeInsets.all(13).r,
                              child: SvgPicture.asset("assets/icons/calendar.svg")
                          ),
                          onChanged: (value) {
                            _name = value;
                          },
                        ),
                        SizedBox(height: 5.h),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(top: 15.h),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(const Radius.circular(10).r),
                                  border: Border.all(color: Colors.grey.shade300)
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex:2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0).r,
                                      child: Image.asset(
                                        'assets/images/product5.png',
                                        fit: BoxFit.fill,
                                        height: 90.h,
                                        width: 100.w,
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
                                            SizedBox(
                                              width: 6.w,
                                            ),
                                            SmallText(
                                              text:'يومين عمل',
                                                size: 13, color: kPrimaryColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex:2,
                                    child: Container(
                                      height: 100.h,
                                      alignment: Alignment.center,
                                      color: kSecondaryColor,
                                      child: BigText(text: '20₪'),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                        Align(
                          alignment: Alignment.topRight,
                          child: DropdownButtonHideUnderline(
                            child: Container(
                              width: 180.w,
                              alignment: Alignment.center,
                              child: DropdownButtonFormField<String>(
                                value: selectedOption,
                                iconSize: 35,
                                icon: Icon(Icons.arrow_drop_down_sharp,color: kPrimaryColor,),
                                decoration:  InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(const Radius.circular(10).r),
                                  ),
                                  contentPadding: EdgeInsets.only(right: 8.w),
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
                        SizedBox(height: 30.h),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                SmallText(text:'المجموع',size: 16,),
                                SmallText(text:'60₪',size: 16,),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmallText(text:'التوصيل',size: 16,),
                                SmallText(text:'4₪',size: 16,),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmallText(text:'الإجمالي',size: 16,),
                                SmallText(text:'64₪',size: 16,),
                              ],
                            ),
                            SizedBox(height: 10.h,),
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
