import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/controller/recommended_product_controller.dart';
import 'package:handcrafts/screens/home/sub_home/most_rated_screen.dart';
import 'package:handcrafts/screens/home/sub_home/product_details_screen.dart';
import '../../widgets/app_card.dart';

class HomeMostRated extends StatelessWidget {
  const HomeMostRated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 370,
      child: GetBuilder<RecommendedProductControllers>(
        builder: (controller) {
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
                        builder: (context) => MostRatedScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
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
                height: 300,
                child: ListView.builder(
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.recommendedProductList.length,
                  itemBuilder: (BuildContext context, int index) =>
                      // Container()
                      GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(
                            product: controller.recommendedProductList[index],
                          ),
                        ),
                      );
                    },
                    child: AppCard(
                      product: controller.recommendedProductList[index],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
