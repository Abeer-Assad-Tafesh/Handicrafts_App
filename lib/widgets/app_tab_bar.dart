import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:handcrafts/widgets/nav_btn_item.dart';

class AppTabBar extends StatelessWidget {

   final TabController tabController;
   final int currentPage;
   final String icon1;
   final String icon2;
   final String icon3;
   final String icon4;

  const AppTabBar(
      {Key? key,
        required this.tabController,
        required this.currentPage,
        required this.icon1,
        required this.icon2,
        required this.icon3,
        required this.icon4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            controller: tabController,
            onTap: (int selectedTabIndex) {},
            tabs: [
              NavBtnItem(
                iconImage: icon1,
                selected: currentPage == 0 ? true : false,
                dotVisibility: currentPage == 0 ? true : false,
              ),
              NavBtnItem(
                iconImage: icon2,
                selected: currentPage == 1 ? true : false,
                dotVisibility: currentPage == 1 ? true : false,
              ),
              NavBtnItem(
                iconImage: icon3,
                selected: currentPage == 2 ? true : false,
                dotVisibility: currentPage == 2 ? true : false,
              ),
              NavBtnItem(
                iconImage: icon4,
                selected: currentPage == 3 ? true : false,
                dotVisibility: currentPage == 3 ? true : false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
