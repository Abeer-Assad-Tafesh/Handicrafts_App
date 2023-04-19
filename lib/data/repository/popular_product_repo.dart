
import 'package:get/get.dart';

import '../../utils/app_constant.dart';
import '../api/api_client.dart';

//2- repositories is to call methods from Api client to get response of request
class PopularProductRepo extends GetxService{

  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }

}