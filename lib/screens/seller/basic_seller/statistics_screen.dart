import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/controller/cart_controller.dart';
import 'package:handcrafts/controller/popular_product_controller.dart';
import 'package:handcrafts/controller/recommended_product_controller.dart';
import 'package:handcrafts/utils/app_constant.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/big_text.dart';
import 'package:handcrafts/widgets/no_products_yet.dart';
import 'package:handcrafts/widgets/small_text.dart';
import 'package:handcrafts/widgets/statistics_card.dart';

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
            children: const [
              StatisticsCard(image: 'assets/icons/orders.svg',text:  'الطلبات',total: '300'),
              SizedBox(width: 8),
              StatisticsCard(image: 'assets/icons/profits.svg',text:  'الأرباح',total: '\$2,4343,33'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15,left: 10,right: 10),
          child: Row(
            children: const [
              StatisticsCard(image: 'assets/icons/products.svg',text:  'المنتجات',total: '439'),
              SizedBox(width: 8),
              StatisticsCard(image: 'assets/icons/likes.svg',text:  'الإعجابات',total: '250K'),
            ],
          ),
        ),
      ],
    );
  }
}


