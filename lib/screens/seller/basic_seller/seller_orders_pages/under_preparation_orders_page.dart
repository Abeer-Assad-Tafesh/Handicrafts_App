import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/big_text.dart';
import 'package:handcrafts/widgets/small_text.dart';
import 'package:handcrafts/widgets/timeline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../api/controllers/order_api_controller.dart';
import '../../../../api/get/order_getx_controller.dart.dart';
import '../../../../widgets/seller_orders_list_page.dart';
import '../../product_ops/request_details_page.dart';


class UnderPreparationOrdersPage extends StatefulWidget {
  List<String> items;
  String selectedOption;

  UnderPreparationOrdersPage({
    Key? key,
    required this.items,
    required this.selectedOption,
  }) : super(key: key);

  @override
  State<UnderPreparationOrdersPage> createState() => _UnderPreparationOrdersPageState();
}

class _UnderPreparationOrdersPageState extends State<UnderPreparationOrdersPage> {
  final OrderGetXController _orderGetXController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: GetBuilder<OrderGetXController>(builder: (controller){
          var orderList = controller.underPreparationOrdersList;
          return OrdersSellerList( orderList: orderList, items: widget.items, selectedOption: widget.selectedOption,);
        }),
      ),
    );
  }

}
