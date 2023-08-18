import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/popular_product_controller.dart';
import 'package:handcrafts/api/get/store_getx_controller.dart.dart';
import 'package:handcrafts/screens/buyer/home/sub_home/handicrafts_stors_screen.dart';
import 'package:handcrafts/screens/buyer/home/sub_home/most_requested_screen.dart';
import 'package:handcrafts/screens/buyer/home/sub_home/product_details_screen.dart';
import 'package:handcrafts/screens/buyer/shop/shop_screen.dart';
import 'package:handcrafts/widgets/app_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handcrafts/widgets/small_text.dart';

class HomeStores extends StatelessWidget {
   HomeStores({Key? key}) : super(key: key);

  final StoreGetXController _storeGetXController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5.w,top: 20.h,right: 10.w,bottom: 10.h),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                          builder: (context) => HandicraftsStoresScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(
                      text:'الحرفيين',
                      size: 16
                  ),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: GetBuilder<StoreGetXController>(
              builder: (controller) {
                return ListView.builder(
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.storesList.length,
                  itemBuilder: (BuildContext context, int index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShopScreen(
                              store: controller.storesList[index],
                          ),
                        ),
                      );
                    },
                    child:
                    StoreCard(
                      store: controller.storesList[index],
                      topMargin: 5,
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
