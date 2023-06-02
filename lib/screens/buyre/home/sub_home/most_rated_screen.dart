import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/controller/popular_product_controller.dart';
import 'package:handcrafts/controller/recommended_product_controller.dart';
import 'package:handcrafts/screens/buyre/home/sub_home/product_details_screen.dart';
import 'package:handcrafts/utils/app_constant.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_card.dart';


class MostRatedScreen extends StatefulWidget {
  const MostRatedScreen({Key? key}) : super(key: key);

  @override
  State<MostRatedScreen> createState() => _MostRatedScreenState();
}

class _MostRatedScreenState extends State<MostRatedScreen> {
  Color _favoriteColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AllAppBar(back: true, text: 'الأعلى تقييماً',),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: SizedBox(
                height: 749,
                child: GetBuilder<RecommendedProductControllers>(builder: (controller){
                  return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          childAspectRatio: 3 / 4,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2),
                      itemCount: controller.recommendedProductList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return  GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                      product: controller
                                          .recommendedProductList[index],
                                  ),
                                ));
                          },
                          child: AppCard(
                            product: controller.recommendedProductList[index],
                            topMargin: 20,
                          ),
                        );
                      },);
                },),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
