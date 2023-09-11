import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/home_api_controller.dart';
import 'package:handcrafts/api/controllers/product_api_controller.dart.dart.dart';
import 'package:handcrafts/api/controllers/store_api_controller.dart.dart';
import 'package:handcrafts/api/models/product.dart';
import 'package:handcrafts/api/models/store.dart';

import '../../prefs/shared_pref_controller.dart';
import '../controllers/order_api_controller.dart';
import '../models/order.dart';

class OrderGetXController extends GetxController {
  List<Orderr?> ordersList = <Orderr>[];
  List<Orderr?> underReviewOrdersList = <Orderr>[];
  List<Orderr?> underPreparationOrdersList = <Orderr>[];
  List<Orderr?> underDeliverOrdersList = <Orderr>[];
  List<Orderr?> completedOrdersList = <Orderr>[];
  List<Orderr?> userOrdersList = <Orderr>[];

  bool loading = false;
  final OrderApiController _apiController = OrderApiController();

  static OrderGetXController get to => Get.find<OrderGetXController>();

  @override
  void onInit() {
    showOrders();
    showUserOrders();
    super.onInit();
  }

  Future<void> showOrders() async {
    loading = true;
    ordersList = await _apiController.showOrders();
    loading = false;
    print('############## hre => ${ordersList.length}');
    await showUnderReviewOrders();
    await underPreparationOrders();
    await underDeliverOrders();
    await completedOrders();
    update();
  }


  Future<void> showUserOrders() async {

    loading = true;
    userOrdersList = await _apiController.showUserOrders();
    print('=====>>>  ${userOrdersList}');

    loading = false;
    update();
  }

  Future<void> showUnderReviewOrders({int? storeId}) async {
    loading = true;
    // underReviewOrdersList = await _apiController.showOrders();
    underReviewOrdersList = ordersList.where((element) => element?.orderStatus == 'قيد المراجعة').toList();
    // print('############## hre2 => ${ordersList.length}');
    loading = false;
    update();
  }

  Future<void> underPreparationOrders({int? storeId}) async {
    loading = true;
    // underPreparationOrdersList = await _apiController.showOrders();
    underPreparationOrdersList = ordersList.where((element) => element?.orderStatus == 'قيد التجهيز').toList();
    loading = false;
    update();
  }

  Future<void> underDeliverOrders({int? storeId}) async {
    loading = true;
    // underDeliverOrdersList = await _apiController.showOrders();
    underDeliverOrdersList = ordersList.where((element) => element?.orderStatus == 'قيد التوصيل').toList();
    loading = false;
    update();
  }

  Future<void> completedOrders({int? storeId}) async {
    loading = true;
    // completedOrdersList = await _apiController.showOrders();
    completedOrdersList = ordersList.where((element) => element?.orderStatus == 'مكتملة').toList();
    loading = false;
    update();
  }

  Future<Orderr?> getOrder({required int orderId}) async {
    loading = true;
    Orderr? order = await _apiController.getOrder(orderId);
    loading = false;
    update();
    return order;
  }


  Future<bool> deleteOrder({required int orderId}) async {
    loading = true;
    bool deleted = await _apiController.deleteOrder(orderId);
    loading = false;
    if (deleted) {
      await showOrders();
      update();
    }
    return deleted;
  }

/*  Future<bool> addOrder({required Orderr order}) async {
    loading = true;
    bool added = await _apiController.addOrder(order);
    loading = false;
    update();
    return added;
  }*/

}
