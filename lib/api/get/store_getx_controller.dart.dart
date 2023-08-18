import 'package:get/get.dart';
import 'package:handcrafts/api/controllers/home_api_controller.dart';
import 'package:handcrafts/api/controllers/store_api_controller.dart.dart';
import 'package:handcrafts/api/models/product.dart';
import 'package:handcrafts/api/models/store.dart';

import '../models/user.dart';

class StoreGetXController extends GetxController {
  List<Store> storesList = <Store>[];
  Store? store ;
  bool isLoading = false;
  final StoreApiController _apiController = StoreApiController();

  static StoreGetXController get to => Get.find<StoreGetXController>();

  @override
  void onInit() {
    getStores();
    super.onInit();
  }

  Future<void> getStores() async {
    isLoading = true;
    storesList = await _apiController.showStores();
    isLoading = false;
    update();
  }

  Future<Store?> getStoreInfo(int storeId) async {
    isLoading = true;
    store = await _apiController.getStoreInfo(storeId);
    isLoading = false;
    update();
    return store;
  }

  Future<bool> addNewStore(Store store) async {
    isLoading = true;
    var status = await _apiController.addNewStore(store);
    isLoading = false;
    update();
    return status;
  }


  Future<bool> updateStoreInfo(Store store) async {
    isLoading = true;
    var status = await _apiController.updateStoreInfo(store);
    isLoading = false;
    update();
    return status;
  }

}
