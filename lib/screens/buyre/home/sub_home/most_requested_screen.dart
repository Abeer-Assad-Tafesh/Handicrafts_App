import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/popular_product_controller.dart';
import 'package:handcrafts/screens/buyre/home/sub_home/product_details_screen.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_card.dart';

class MostRequestedScreen extends StatefulWidget {
  const MostRequestedScreen({Key? key}) : super(key: key);

  @override
  State<MostRequestedScreen> createState() => _MostRequestedScreenState();
}

class _MostRequestedScreenState extends State<MostRequestedScreen> {
  Color _favoriteColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AllAppBar(
              back: true,
              text: 'الأكثر طلباً',
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GetBuilder<PopularProductControllers>(
                  builder: (controller) {
                    return GridView.builder(
                      // shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 230,
                              childAspectRatio: 3 / 4,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2),
                      itemCount: controller.popularProductList.length != 0 ?
                      controller.popularProductList.length : 8,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                  product: controller.popularProductList[index],
                                  productId: controller.popularProductList[index].id,
                                ),
                              ),
                            );
                          },
                          child: controller.popularProductList.length != 0 ?
                          AppCard(
                            product: controller.popularProductList[index],
                            topMargin: 10,
                          ):
                          AppCard2(
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
