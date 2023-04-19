import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/controller/popular_product_controller.dart';
import 'package:handcrafts/screens/home/sub_home/most_requested_screen.dart';
import 'package:handcrafts/screens/home/sub_home/product_details_screen.dart';

import '../../widgets/app_card.dart';

class HomeMostRequested extends StatelessWidget {
  const HomeMostRequested({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5,top: 20,right: 10,bottom: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MostRequestedScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'الأكثر طلباً',
                    style: TextStyle(fontSize: 18),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 300,
            child: GetBuilder<PopularProductControllers>(
              builder: (controller) {
                return ListView.builder(
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.popularProductList.length,
                  itemBuilder: (BuildContext context, int index) => GestureDetector(
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
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
