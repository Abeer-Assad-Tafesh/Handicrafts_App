import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/recommended_product_controller.dart';
import 'package:handcrafts/screens/buyer/home/home_most_rated.dart';
import 'package:handcrafts/screens/buyer/home/home_most_requested.dart';
import 'package:handcrafts/screens/buyer/home/home_stores.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/not_yet.dart';

import '../../../api/controllers/popular_product_controller.dart';
import '../../../api/get/store_getx_controller.dart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PopularProductControllers _popularProductControllers = Get.find();
  final RecommendedProductControllers _recommendedProductControllers =
      Get.find();
  final StoreGetXController _storeGetXController = Get.find();

  @override
  Widget build(BuildContext context) {
  /*  if (_popularProductControllers.isLoading ||
        _recommendedProductControllers.isLoading ||
        _storeGetXController.isLoading) {
      print(_popularProductControllers.isLoading ||
          _recommendedProductControllers.isLoading ||
          _storeGetXController.isLoading);
      return Center(
          child: CircularProgressIndicator(
        color: kPrimaryColor,
      ));
    } else {*/
      print("hhhhhhhhhhh ${
            _popularProductControllers.isLoading ||
                _recommendedProductControllers.isLoading ||
                _storeGetXController.isLoading
          }");
      return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            HomeStores(),
            HomeMostRequested(),
            HomeMostRated(),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      );
    }
}
