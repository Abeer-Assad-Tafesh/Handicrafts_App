import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/cart_controller.dart';
import 'package:handcrafts/api/get/order_getx_controller.dart.dart';
import 'package:handcrafts/api/get/store_getx_controller.dart.dart';
import 'package:handcrafts/widgets/statistics_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../api/get/favorite_product_getx_controller.dart';
import '../../../api/get/product_getx_controller.dart.dart';
import '../../../prefs/shared_pref_controller.dart';


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
              GetBuilder<OrderGetXController>(builder: (controller){
                return StatisticsCard(
                    image: 'assets/icons/orders.svg',
                    text:  'الطلبات',
                    total: '${OrderGetXController.to.ordersList.length}');
              },),
              SizedBox(width: 8.w),
              const StatisticsCard(image: 'assets/icons/profits.svg',text:  'الأرباح',total: '₪0'),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15.h,left: 10.w,right: 10.w),
          child: Row(
            children: [
              GetX<ProductGetXController>(builder: (controller){
                return StatisticsCard(
                    image: 'assets/icons/products.svg',
                      text:  'المنتجات',
                      total: '${ProductGetXController.to.storeProductsList.length}');
                },),
              SizedBox(width: 8.w),
              GetBuilder<FavoriteGetXController>(builder: (controller){
                return StatisticsCard(
                    image: 'assets/icons/likes.svg',
                    text:  'الإعجابات',
                    total: '${FavoriteGetXController.to.numOfFavProductsPerStore}');

              })
            ],
          ),
        ),
      ],
    );
  }
}


