import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/get/product_getx_controller.dart.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:handcrafts/screens/seller/basic_seller/more_screen.dart';
import 'package:handcrafts/screens/seller/basic_seller/products_operation_screen.dart';
import 'package:handcrafts/screens/seller/basic_seller/seller_orders_screen.dart';
import 'package:handcrafts/screens/seller/basic_seller/statistics_screen.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_tab_bar.dart';
import 'package:handcrafts/widgets/nav_btn_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicSellerScreens extends StatefulWidget {
  int? storeId;
  BasicSellerScreens({Key? key, this.storeId,}) : super(key: key);

  @override
  State<BasicSellerScreens> createState() => _BasicSellerScreensState();
}

class _BasicSellerScreensState extends State<BasicSellerScreens>
    with TickerProviderStateMixin {

  final ProductGetXController _productGetXController = Get.put(
      ProductGetXController());

  late final TabController _tabController;
  int pageIndex = 0;
  int currentPage = 0;

  Future<void> getStoreProducts() async {
    print('22222    ${int.parse(SharedPrefController().craftsmanStoreId)}');
    await ProductGetXController.to.getStoreProducts(storeId: int.parse(SharedPrefController().craftsmanStoreId));
  }

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.animation!.addListener(
          () {
        final value = _tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AllAppBar(
                  back: false,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      StatisticsScreen(),
                      ProductsOperationsScreen(),
                      SellerOrdersScreen(),
                      MoreScreen(),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: 1.w,
              right: 1.w,
              bottom: 5.h,
              child: AppTabBar(
                tabController: _tabController,
                currentPage: currentPage,
                icon1: 'assets/icons/statistics_home.svg',
                icon2: 'assets/icons/product_home.svg',
                icon3: 'assets/icons/orders_home.svg',
                icon4: 'assets/icons/category.svg',
              ),
            )
          ],
        ),
      ),
    );
  }
}
