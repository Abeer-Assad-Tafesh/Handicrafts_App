import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import '../utils/constants.dart';
import 'package:handcrafts/widgets/small_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuyerNotificationsScreen extends StatelessWidget {
  const BuyerNotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AllAppBar(
              back: true,
              text: 'الإشعارات',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 8,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(left: 10.w, right: 10.w),
                          child: Column(
                            children: [
                              SizedBox(height: 10.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(500).r,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 4,
                                            blurRadius: 6,
                                            offset: const Offset(
                                                0, 3) // changes position of shadow
                                        ),
                                      ],
                                      color: Colors.grey,
                                    ),
                                    child: SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.grey,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 10.w,
                                              right: 10.w,
                                              top: 8.h,
                                              bottom: 4.h),
                                          child: SvgPicture.asset(
                                            'assets/images/logo_image.svg',
                                            height: 70,
                                            width: 70,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SmallText(
                                          text:'تحديث جديد',
                                          size: 16, color: kPrimaryColor
                                      ),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      SmallText(
                                          text:'قم بتحديث التطبيق',
                                          size: 16, color: kPrimaryColor
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              const Divider(),
                            ],
                          ),
                        ),
                      ),
                    ],
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
