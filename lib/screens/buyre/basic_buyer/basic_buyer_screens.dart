import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/api_helper.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/api/controllers/popular_product_controller.dart';
import 'package:handcrafts/api/controllers/recommended_product_controller.dart';
import 'package:handcrafts/screens/buyre/basic_buyer/cart_screen.dart';
import 'package:handcrafts/screens/buyre/basic_buyer/favorite_screen.dart';
import 'package:handcrafts/screens/buyre/home/home_screen.dart';
import 'package:handcrafts/screens/buyre/profile/account_screen.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_tab_bar.dart';
import 'package:handcrafts/widgets/not_yet.dart';

class BasicBuyerScreens extends StatefulWidget {
  const BasicBuyerScreens({Key? key}) : super(key: key);

  @override
  State<BasicBuyerScreens> createState() => _BasicBuyerScreensState();
}

class _BasicBuyerScreensState extends State<BasicBuyerScreens>
    with TickerProviderStateMixin, ApiHelper {
  PopularProductControllers _popularProductControllers =
      Get.put(PopularProductControllers());
  RecommendedProductControllers _recommendedProductControllers =
      Get.put(RecommendedProductControllers());

  late final TabController _tabController;
  int pageIndex = 0;
  int currentPage = 0;

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
                  child: FutureBuilder<bool>(
                    future: checkInternetConnectivity(),
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.connectionState == ConnectionState.none) {
                        return const NotYet(
                          image: 'assets/images/verif_code.svg',
                          title: 'لا يتوفرانترنت!',
                          text: ' أعد محاولة الاتصال بالانترنت',
                        );
                      } else {
                        if (_recommendedProductControllers.isLoaded &&
                            _popularProductControllers.isLoaded) {
                          // Display content when both conditions are met
                          return Center(
                            child: InteractiveViewer(
                              child: SvgPicture.asset(
                                'assets/images/hand_loading.svg',
                                height: 300.h,
                                width: 300.w,
                              ),
                            ),
                          );
                        } else {
                          return TabBarView(
                            controller: _tabController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: const [
                              HomeScreen(),
                              CartScreen(),
                              FavoriteScreen(),
                              AccountScreen(),
                            ],
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              left: 1,
              right: 1,
              bottom: 5,
              child: AppTabBar(
                tabController: _tabController,
                currentPage: currentPage,
                icon1: 'assets/icons/home.svg',
                icon2: 'assets/icons/buy.svg',
                icon3: 'assets/icons/heart.svg',
                icon4: 'assets/icons/category.svg',
              ),
            )
          ],
        ),
      ),
    );
  }
}

