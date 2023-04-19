import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/controller/popular_product_controller.dart';
import 'package:handcrafts/screens/home/sub_home/product_details_screen.dart';
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
              text: 'الأعلى طلباً',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 749,
                child: GetBuilder<PopularProductControllers>(
                  builder: (controller) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              childAspectRatio: 3 / 4,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2),
                      itemCount: controller.popularProductList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                  product: controller.popularProductList[index],
                                ),
                              ),
                            );
                          },
                          child: AppCard(
                            product: controller.popularProductList[index],
                            topMargin: 20,
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
