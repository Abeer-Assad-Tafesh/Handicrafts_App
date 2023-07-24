import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/cart_controller.dart';
import 'package:handcrafts/widgets/statistics_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15,left: 10,right: 10),
          child: Row(
            children: [
              const StatisticsCard(image: 'assets/icons/orders.svg',text:  'الطلبات',total: '300'),
              SizedBox(width: 8.w),
              const StatisticsCard(image: 'assets/icons/profits.svg',text:  'الأرباح',total: '₪2,4343,33'),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15.h,left: 10.w,right: 10.w),
          child: Row(
            children: [
              const StatisticsCard(image: 'assets/icons/products.svg',text:  'المنتجات',total: '439'),
              SizedBox(width: 8.w),
              const StatisticsCard(image: 'assets/icons/likes.svg',text:  'الإعجابات',total: '250K'),
            ],
          ),
        ),
      ],
    );
  }
}


