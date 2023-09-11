import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/models/order.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/big_text.dart';
import 'package:handcrafts/widgets/seller_orders_list_page.dart';
import 'package:handcrafts/widgets/small_text.dart';
import 'package:handcrafts/widgets/timeline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../api/get/order_getx_controller.dart.dart';
import '../../product_ops/request_details_page.dart';


class CompletedOrdersPage extends StatefulWidget {
  List<String> items;
  String selectedOption;
  CompletedOrdersPage({
    Key? key,
    required this.items,
    required this.selectedOption,
  }) : super(key: key);

  @override
  State<CompletedOrdersPage> createState() => _CompletedOrdersPageState();
}

class _CompletedOrdersPageState extends State<CompletedOrdersPage> {
  final OrderGetXController _orderGetXController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: GetBuilder<OrderGetXController>(builder: (controller){
          var orderList = controller.completedOrdersList;
          // print(orderList[0]?.orderStatus);
          return OrdersSellerList( orderList: orderList, items: widget.items, selectedOption: widget.selectedOption,);
        }),
      ),
    );
  }

}
