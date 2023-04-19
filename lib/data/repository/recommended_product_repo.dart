
import 'package:get/get.dart';

import '../../utils/app_constant.dart';
import '../api/api_client.dart';

//2- repositories is to call methods from Api client to get response of request
class RecommendedProductRepo extends GetxService{

  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }

}