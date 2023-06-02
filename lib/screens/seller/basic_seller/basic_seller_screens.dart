import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:handcrafts/screens/seller/basic_seller/more_screen.dart';
import 'package:handcrafts/screens/seller/basic_seller/products_operation_screen.dart';
import 'package:handcrafts/screens/seller/basic_seller/seller_orders_screen.dart';
import 'package:handcrafts/screens/seller/basic_seller/statistics_screen.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/nav_btn_item.dart';

class BasicSellerScreens extends StatefulWidget {
  const BasicSellerScreens({Key? key}) : super(key: key);

  @override
  State<BasicSellerScreens> createState() => _BasicSellerScreensState();
}

class _BasicSellerScreensState extends State<BasicSellerScreens>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  int pageIndex = 0;
  int currentPage = 0;

  final pages = [
    const StatisticsScreen(),
    ProductsOperationsScreen(),
    SellerOrdersScreen(),
    MoreScreen(),
  ];

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
        child: Stack(children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AllAppBar(back: false,),
              SizedBox(
                height: 749,
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children:  [
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
            left: 1,
            right: 1,
            bottom: 5,
            child: Container(
              height: 65,
              margin: const EdgeInsets.fromLTRB(35, 0, 35, 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300.withOpacity(0.9),
                    spreadRadius: 0.3,
                    blurRadius: 3,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: TabBar(
                    indicatorColor: Colors.transparent,
                    controller: _tabController,
                    onTap: (int selectedTabIndex) {},
                    tabs: [
                      NavBtnItem(
                        iconImage: 'assets/icons/statistics_home.svg',
                        selected: currentPage == 0 ? true : false,
                        dotVisibility: currentPage == 0 ? true : false,
                      ),
                      NavBtnItem(
                        iconImage: 'assets/icons/product_home.svg',
                        selected: currentPage == 1 ? true : false,
                        dotVisibility: currentPage == 1 ? true : false,
                      ),
                      NavBtnItem(
                        iconImage: 'assets/icons/orders_home.svg',
                        selected: currentPage == 2 ? true : false,
                        dotVisibility: currentPage == 2 ? true : false,
                      ),
                      NavBtnItem(
                        iconImage: 'assets/icons/category_home.svg',
                        selected: currentPage == 3 ? true : false,
                        dotVisibility: currentPage == 3 ? true : false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
