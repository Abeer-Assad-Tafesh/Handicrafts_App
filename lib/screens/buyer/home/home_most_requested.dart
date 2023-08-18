import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/popular_product_controller.dart';
import 'package:handcrafts/screens/buyer/home/sub_home/most_requested_screen.dart';
import 'package:handcrafts/screens/buyer/home/sub_home/product_details_screen.dart';
import 'package:handcrafts/widgets/app_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handcrafts/widgets/small_text.dart';

import '../../../utils/constants.dart';
import '../../../widgets/not_yet.dart';

class HomeMostRequested extends StatefulWidget {
  const HomeMostRequested({Key? key}) : super(key: key);

  @override
  State<HomeMostRequested> createState() => _HomeMostRequestedState();
}

class _HomeMostRequestedState extends State<HomeMostRequested> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 5.w, top: 20.h, right: 10.w, bottom: 10.h),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MostRequestedScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(text: 'الأكثر طلباً', size: 16),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 250.h,
            child: GetBuilder<PopularProductControllers>(
              builder: (controller) {
                print(
                    '==>_popularProductList ${controller.popularProductList.length}');
                if (controller.popularProductList.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: false,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.popularProductList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                      onTap: () {
                        print(
                            '========here====>${controller.popularProductList.length}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                              product: controller.popularProductList[index],
                              productId:
                                  controller.popularProductList[index].id,
                            ),
                          ),
                        );
                      },
                      child: ProductCard(
                        product: controller.popularProductList[index],
                      ),
                    ),
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(color: kPrimaryColor));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
