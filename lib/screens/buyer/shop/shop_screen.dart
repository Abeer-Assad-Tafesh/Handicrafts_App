import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/get/home_getx_controller.dart';
import 'package:handcrafts/api/get/store_getx_controller.dart.dart';
import 'package:handcrafts/api/models/product.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/screens/buyer/shop/about_shop_page.dart';
import 'package:handcrafts/screens/buyer/shop/shop_page.dart';

import '../../../api/models/store.dart';


class ShopScreen extends StatefulWidget {
   Product? product;
   Store? store;
   ShopScreen({Key? key,this.product,this.store}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with TickerProviderStateMixin {
  StoreGetXController _shopPageController = Get.put(StoreGetXController());
  HomeGetXController _homeGetXController = Get.find<HomeGetXController>();
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
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    Text(
                      'نبذة عنا',
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ]
              ),
            ),
            Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children:  [
                    ShopPage(product: widget.product,store: widget.store),
                    AboutShopPage(product: widget.product,store: widget.store)
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
