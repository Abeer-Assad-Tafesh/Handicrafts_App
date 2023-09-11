import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/popular_product_controller.dart';
import 'package:handcrafts/api/controllers/recommended_product_controller.dart';
import 'package:handcrafts/api/get/store_getx_controller.dart.dart';
import 'package:handcrafts/screens/buyer/home/sub_home/product_details_screen.dart';
import 'package:handcrafts/screens/buyer/shop/shop_page.dart';
import 'package:handcrafts/screens/buyer/shop/shop_screen.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_card.dart';

class HandicraftsStoresScreen extends StatefulWidget {
  const HandicraftsStoresScreen({Key? key}) : super(key: key);

  @override
  State<HandicraftsStoresScreen> createState() =>
      _HandicraftsStoresScreenState();
}

class _HandicraftsStoresScreenState extends State<HandicraftsStoresScreen> {

  // final StoreGetXController _storeGetXController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AllAppBar(
              back: true,
              text: 'الحرفيين',
              spaceBeforeLogo: 40,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GetBuilder<StoreGetXController>(
                  builder: (controller) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              // maxCrossAxisExtent: 300,
                              childAspectRatio: 6 / 3,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2),
                      itemCount: controller.storesList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShopScreen(
                                   store: controller.storesList[index],
                                  ),
                                ));
                          },
                          child: StoreCard(
                            topMargin: 10,
                            store: controller.storesList[index],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
