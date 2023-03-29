import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:handcrafts/screens/account_screen.dart';
import 'package:handcrafts/screens/cart_screen.dart';
import 'package:handcrafts/screens/favorite_screen.dart';
import 'package:handcrafts/screens/home_screen.dart';
import 'package:handcrafts/screens/login_register_screen.dart';
import 'package:handcrafts/screens/regiser_as_screen.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import '../widgets/nav_btn_item.dart';

class BasicScreens extends StatefulWidget {
  const BasicScreens({Key? key}) : super(key: key);

  @override
  State<BasicScreens> createState() => _BasicScreensState();
}

class _BasicScreensState extends State<BasicScreens>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  int pageIndex = 0;
  int currentPage = 0;

  final pages = [
    const HomeScreen(),
    const FavoriteScreen(),
    const CartScreen(),
    const AccountScreen(),
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
              const AllAppBar(),
              SizedBox(
                height: 749,
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    HomeScreen(),
                    FavoriteScreen(),
                    CartScreen(),
                    RegisterAsScreen(),
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
                    color: Colors.grey.withOpacity(0.3),
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
                        iconImage: 'assets/icons/home.svg',
                        selected: currentPage == 0 ? true : false,
                        dotVisibility: currentPage == 0 ? true : false,
                      ),
                      NavBtnItem(
                        iconImage: 'assets/icons/heart.svg',
                        selected: currentPage == 1 ? true : false,
                        dotVisibility: currentPage == 1 ? true : false,
                      ),
                      NavBtnItem(
                        iconImage: 'assets/icons/buy.svg',
                        selected: currentPage == 2 ? true : false,
                        dotVisibility: currentPage == 2 ? true : false,
                      ),
                      NavBtnItem(
                        iconImage: 'assets/icons/category.svg',
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
