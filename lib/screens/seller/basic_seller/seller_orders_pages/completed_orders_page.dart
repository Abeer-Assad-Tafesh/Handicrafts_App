import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/big_text.dart';
import 'package:handcrafts/widgets/small_text.dart';
import 'package:handcrafts/widgets/timeline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CompletedOrdersPage extends StatefulWidget {
  List<String> items;
  String selectedOption;

  CompletedOrdersPage({
    Key? key,
    required this.items,
    required this.selectedOption,
  }) : super(key: key);

  @override
  State<CompletedOrdersPage> createState() => _CompletedOrdersPageState();
}

class _CompletedOrdersPageState extends State<CompletedOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: 5,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(13).r,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)).r,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 3,
                            spreadRadius: 2,
                            offset: const Offset(-3, 3)),
                        BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 3,
                            spreadRadius: 2,
                            offset: const Offset(1, -1)),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                        EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmallText(
                                  text: '20.Dec,2022',
                                  color: Colors.grey,
                                  size: 12.sp,
                                ),
                                SmallText(
                                  text: '2:15 Am',
                                  color: Colors.grey,
                                  size: 12.sp,
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/request_details_page');
                                  },
                                  child: SizedBox(
                                      width: 20.w,
                                      height: 20.h,
                                      child: SvgPicture.asset(
                                          'assets/icons/red_info_circle.svg')),
                                ),
                                SmallText(
                                  text: 'ID: 276332',
                                  size: 18.sp,
                                  color: kPrimaryColor,
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20).r,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallText(
                                text: widget.items[1], color: kPrimaryColor, size: 10.sp),
                            SmallText(
                                text: widget.items[2], color: kPrimaryColor, size: 10.sp),
                            SmallText(
                                text: widget.items[3], color: kPrimaryColor, size: 10.sp),
                            SmallText(
                                text: widget.items[4], color: kPrimaryColor, size: 10.sp),
                          ],
                        ),
                      ),
                      DeliveryTimeline(
                          currentStep: widget.items.indexOf(widget.selectedOption) - 1),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15.w, right: 15.w, bottom: 15.h),
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(const Radius.circular(10).w),
                                      border: Border.all(
                                          color: Colors.grey.shade300)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
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
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            BigText(
                                              text: 'اسم المنتج',
                                              size: 18.sp,
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/icons/calendar.svg",
                                                ),
                                                SizedBox(
                                                  width: 6.w,
                                                ),
                                                Text(
                                                  'يومين عمل',
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: kPrimaryColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
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
                                    value: widget.selectedOption,
                                    iconSize: 35.w,
                                    icon: Icon(
                                      Icons.arrow_drop_down_sharp,
                                      color: kPrimaryColor,
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            const Radius.circular(10).w),
                                      ),
                                      contentPadding: EdgeInsets.only(right: 8.w),
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        widget.selectedOption = newValue!;
                                      });
                                    },
                                    items: widget.items.map((String option) {
                                      return DropdownMenuItem<String>(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: 100.h,
            )
          ],
        ),
      ),
    );
  }
}
