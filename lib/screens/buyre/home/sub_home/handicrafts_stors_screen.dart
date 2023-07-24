import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/popular_product_controller.dart';
import 'package:handcrafts/api/controllers/recommended_product_controller.dart';
import 'package:handcrafts/screens/buyre/home/sub_home/product_details_screen.dart';
import 'package:handcrafts/utils/app_constant.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_card.dart';

class HandicraftsStoresScreen extends StatefulWidget {
  const HandicraftsStoresScreen({Key? key}) : super(key: key);

  @override
  State<HandicraftsStoresScreen> createState() => _HandicraftsStoresScreenState();
}

class _HandicraftsStoresScreenState extends State<HandicraftsStoresScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AllAppBar(
              back: true,
              text: 'الحرفيين',
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GetBuilder<RecommendedProductControllers>(
                  builder: (controller) {
                    return GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          // maxCrossAxisExtent: 300,
                          childAspectRatio: 6 / 3,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2),
                      itemCount: /*controller.recommendedProductList.length != 0
                          ? controller.recommendedProductList.length
                          : */5,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                    product: controller
                                        .recommendedProductList[index],
                                  ),
                                ));*/
                          },
                          child:/* controller.recommendedProductList.length != 0
                              ? AppCard(
                            product:
                            controller.recommendedProductList[index],
                            topMargin: 10,
                          )
                              : */AppCard3(
                            topMargin: 10,
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
