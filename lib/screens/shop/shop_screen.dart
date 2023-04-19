import 'package:flutter/material.dart';
import 'package:handcrafts/screens/shop/about_shop_page.dart';
import 'package:handcrafts/screens/shop/shop_page.dart';

import '../../constants.dart';


class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(40, 30, 40, 0),
              height: 65,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(40),
              ),

              child: TabBar(
                  controller: _tabController,
                  onTap: (int selectedTabIndex) {},
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      // border: Border.all(color: kDefaultColor),
                    color: Colors.green.shade50
                  ),
                  tabs: [
                    Text(
                      'المتجر',
                      style: TextStyle(color: kDefaultColor),
                    ),
                    Text(
                      'نبذة عنا',
                      style: TextStyle(color: kDefaultColor),
                    ),
                  ]),
            ),
            Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [ShopPage(), AboutShopPage()],
                ))
          ],
        ),
      ),
    );
  }
}
