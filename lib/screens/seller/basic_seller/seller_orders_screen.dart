import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/screens/seller/basic_seller/seller_orders_pages/all_orders_page.dart';
import 'package:handcrafts/screens/seller/basic_seller/seller_orders_pages/completed_orders_page.dart';
import 'package:handcrafts/screens/seller/basic_seller/seller_orders_pages/under_deliver_orders_page.dart';
import 'package:handcrafts/screens/seller/basic_seller/seller_orders_pages/under_preparation_orders_page.dart';
import 'package:handcrafts/screens/seller/basic_seller/seller_orders_pages/under_review_orders_page.dart';
import 'package:handcrafts/widgets/big_text.dart';
import 'package:handcrafts/widgets/small_text.dart';
import 'package:handcrafts/widgets/timeline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SellerOrdersScreen extends StatefulWidget {
  const SellerOrdersScreen({Key? key}) : super(key: key);

  @override
  State<SellerOrdersScreen> createState() => _SellerOrdersScreenState();
}

class _SellerOrdersScreenState extends State<SellerOrdersScreen> {
  final List<String> pages = [
    "كل الطلبات",
    "قيد المراجعة",
    "قيد التجهيز",
    " قيد التوصيل",
    "مكتملة",
  ];
  final List<String> items = [
    "اختر حالة الطلب",
    "قيد المراجعة",
    "قيد التجهيز",
    " قيد التوصيل",
    "مكتملة",
  ];
  int current = 0;
  String selectedOption = "اختر حالة الطلب";

  @override
  void initState() {
    super.initState();
    // selectedOption = items[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: EdgeInsets.only(top: 10.h),
      child: Column(
        children: [
          // Tab bar
          Container(
            height: 60.h,
            width: double.infinity,
            margin: EdgeInsets.only(right: 10.w),
            child: ListView.builder(
              itemCount: pages.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      current = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5).r,
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                    decoration: BoxDecoration(
                        color:
                            current == index ? Colors.white : kSecondaryColor,
                        borderRadius:  BorderRadius.only(
                            topLeft: const Radius.circular(10).r,
                            topRight: const Radius.circular(10).r),
                        boxShadow: current == index
                            ? [
                                const BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 1,
                                    spreadRadius: 0),
                                const BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 10,
                                    spreadRadius: 9),
                              ]
                            : [
                                const BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 0.5,
                                  spreadRadius: 1,
                                ),
                              ]),
                    child: Center(
                      child: BigText(
                        text: pages[index],
                        size: 14.sp,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Body
          current == 0
              ? AllOrdersPage(items: items,selectedOption: items[0])
              : current == 1 ? UnderReviewOrdersPage(items: items,selectedOption: items[1])
              : current == 2 ? UnderPreparationOrdersPage(items: items,selectedOption: items[2])
              : current == 3 ?  UnderDeliverOrdersPage(items: items,selectedOption: items[3])
              : CompletedOrdersPage(items: items,selectedOption: items[4])
        ],
      ),
    );
  }
}
