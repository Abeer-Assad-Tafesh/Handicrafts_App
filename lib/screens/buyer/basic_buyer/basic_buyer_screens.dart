import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/api_helper.dart';
import 'package:handcrafts/screens/buyer/basic_buyer/cart_screen.dart';
import 'package:handcrafts/screens/buyer/basic_buyer/favorite_screen.dart';
import 'package:handcrafts/screens/buyer/home/home_screen.dart';
import 'package:handcrafts/screens/buyer/profile/account_screen.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_tab_bar.dart';
import 'package:handcrafts/widgets/not_yet.dart';

import '../../../api/controllers/popular_product_controller.dart';
import '../../../api/controllers/recommended_product_controller.dart';
import '../../../api/get/auth_getx_controller.dart';
import '../../../api/get/common_question_getx_controller.dart';
import '../../../api/get/favorite_product_getx_controller.dart';
import '../../../api/get/store_getx_controller.dart.dart';


class BasicBuyerScreens extends StatefulWidget {
   const BasicBuyerScreens({Key? key,}) : super(key: key);
  @override
  State<BasicBuyerScreens> createState() => _BasicBuyerScreensState();
}

class _BasicBuyerScreensState extends State<BasicBuyerScreens>
    with TickerProviderStateMixin, ApiHelper {


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
              // mainAxisSize: MainAxisSize.min,
              children: [
                AllAppBar(
                  back: false,
                ),
                Expanded(
                  child: FutureBuilder<bool>(
                    future: checkInternetConnectivity(),
                    builder: (BuildContext context,
                        AsyncSnapshot<bool> snapshot) {
                      if (snapshot.connectionState == ConnectionState.none) {
                        return const NotYet(
                          image: 'assets/images/verif_code.svg',
                          title: 'لا يتوفرانترنت!',
                          text: 'أعد محاولة الاتصال بالانترنت',
                        );
                      } else {
                        return TabBarView(
                          controller: _tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          children:  const [
                            HomeScreen(),
                            CartScreen(),
                            FavoriteScreen(),
                            AccountScreen(),
                          ],
                        );
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
