import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/recommended_product_controller.dart';
import 'package:handcrafts/screens/buyer/home/sub_home/most_rated_screen.dart';
import 'package:handcrafts/screens/buyer/home/sub_home/product_details_screen.dart';
import 'package:handcrafts/widgets/app_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeMostRated extends StatefulWidget {
  const HomeMostRated({Key? key}) : super(key: key);

  @override
  State<HomeMostRated> createState() => _HomeMostRatedState();
}

class _HomeMostRatedState extends State<HomeMostRated> {
  // RecommendedProductControllers _recommendedProductControllers = Get.put(RecommendedProductControllers());
  final RecommendedProductControllers _recommendedProductControllers =
      Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320.h,
      child: GetBuilder<RecommendedProductControllers>(
        builder: (controller) {
          if(controller.recommendedProductList.isNotEmpty){
            print('controller.recommendedProductList.length=> ${controller.recommendedProductList.length}');
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5, top: 20, right: 10, bottom: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MostRatedScreen(),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الأعلى تقييماً',
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 250.h,
                  child: ListView.builder(
                    shrinkWrap: false,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.recommendedProductList.length,
                    itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                  product:
                                  controller.recommendedProductList[index],
                                  productId: controller
                                      .recommendedProductList[index].id)),
                        );
                      },
                      child: controller.recommendedProductList.isNotEmpty
                          ? ProductCard(
                        product: controller.recommendedProductList[index],
                      )
                          : const AppCard2(),
                    ),
                  ),
                ),
              ],
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
