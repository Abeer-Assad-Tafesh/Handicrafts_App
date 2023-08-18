import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/popular_product_controller.dart';
import 'package:handcrafts/api/controllers/recommended_product_controller.dart';
import 'package:handcrafts/screens/buyer/home/sub_home/product_details_screen.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_card.dart';

class MostRatedScreen extends StatefulWidget {
  const MostRatedScreen({Key? key}) : super(key: key);

  @override
  State<MostRatedScreen> createState() => _MostRatedScreenState();
}

class _MostRatedScreenState extends State<MostRatedScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AllAppBar(
              back: true,
              text: 'الأعلى تقييماً',
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GetBuilder<RecommendedProductControllers>(
                  builder: (controller) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 230,
                              childAspectRatio: 3 / 4,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2),
                      itemCount: controller.recommendedProductList.isNotEmpty
                          ? controller.recommendedProductList.length
                          : 5,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                    product: controller
                                        .recommendedProductList[index],
                                    productId: controller
                                      .recommendedProductList[index].id,
                                  ),
                                ));
                          },
                          child: controller.recommendedProductList.isNotEmpty
                              ? ProductCard(
                                  product:
                                      controller.recommendedProductList[index],
                                  topMargin: 10,
                                )
                              : const AppCard2(
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
