
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:handcrafts/widgets/big_text.dart';
import 'package:handcrafts/widgets/small_text.dart';
import 'package:handcrafts/widgets/timeline.dart';
import '../api/api_settings.dart';
import '../api/controllers/order_api_controller.dart';
import '../api/get/order_getx_controller.dart.dart';
import '../api/models/order.dart';
import '../screens/seller/product_ops/request_details_page.dart';
import '../utils/constants.dart';

class OrdersSellerList extends StatefulWidget {
  List<String> items;
  String selectedOption;
  List<Orderr?> orderList;

  OrdersSellerList({
    super.key,
    required this.orderList, required this.items, required  this.selectedOption
  });

  @override
  State<OrdersSellerList> createState() => _OrdersSellerListState();
}

class _OrdersSellerListState extends State<OrdersSellerList> {
  final OrderGetXController _orderGetXController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.orderList.isNotEmpty ?
        ListView.builder(
          itemCount: widget.orderList.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) =>
                    RequestDetailsPage(orderId: widget.orderList[index]!.id,)
                ));
              },
              child: Container(
                margin: const EdgeInsets.all(13).r,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)).r,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 3,
                          spreadRadius: 2,
                          offset: const Offset(-3, 3)),
                      BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 3,
                          spreadRadius: 2,
                          offset: const Offset(1, -1)),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                      EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SmallText(
                                text: '${widget.orderList[index]?.deliveryDate?? ''}',
                                color: Colors.grey,
                                size: 12.sp,
                              ),
                              SmallText(
                                text: '${widget.orderList[index]?.deliveryTime?.replaceFirst(':00', '')??''}',
                                color: Colors.grey,
                                size: 12.sp,
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 20.w,
                                height: 20.h,
                                child: SvgPicture.asset(
                                    'assets/icons/red_info_circle.svg'),
                              ),
                              SmallText(
                                text: 'رقم الطلب: ${widget.orderList[index]?.id}',
                                size: 12.sp,
                                color: kPrimaryColor,
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20).r,
                      child: Row(
                        children: [
                          SmallText(
                              text: widget.items[1], color: kPrimaryColor, size: 10),
                          SizedBox(width: 30.w),
                          SmallText(
                              text: widget.items[2], color: kPrimaryColor, size: 10),
                          SizedBox(width: 35.w),
                          SmallText(
                              text: widget.items[3], color: kPrimaryColor, size: 10),
                          SizedBox(width: 55.w),
                          SmallText(
                              text: widget.items[4], color: kPrimaryColor, size: 10),
                        ],
                      ),
                    ),
                    DeliveryTimeline(
                        currentStep: widget.items.indexOf(widget.selectedOption) - 1),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15.w, right: 15.w, bottom: 15.h),
                      child: Column(
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.orderList[index]?.orderItems?.length,
                            itemBuilder: (context, i) {
                              return Container(
                                margin: const EdgeInsets.only(top: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(const Radius.circular(10).w),
                                    border: Border.all(
                                        color: Colors.grey.shade300)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0).r,
                                         child: Image.network(
                                          ApiSettings.getImageUrl(widget.orderList[index]!
                                              .orderItems![i].product!.productImages![0]!
                                              .imageUrl
                                              .replaceFirst('uploads/', '')),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          BigText(
                                            text: '${widget.orderList[index]?.orderItems?[i].productName}',
                                            size: 18.sp,
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/calendar.svg",
                                              ),
                                              SizedBox(
                                                width: 6.w,
                                              ),
                                              Text(
                                                '${widget.orderList[index]?.orderItems?[i].product?.deliveryPeriod} يوم عمل ',
                                                // '${orderList[index]?.orderItems?[i].productName}'
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: kPrimaryColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 100.h,
                                        alignment: Alignment.center,
                                        color: kSecondaryColor,
                                        child: BigText(text: '${widget.orderList[index]?.orderItems?[i].price}₪'),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20.h),
                          Align(
                            alignment: Alignment.topRight,
                            child: DropdownButtonHideUnderline(
                              child: Container(
                                width: 180.w,
                                alignment: Alignment.center,
                                child: DropdownButtonFormField<String>(
                                  value: widget.orderList[index]!.orderStatus.toString(),
                                  iconSize: 35.w,
                                  icon: Icon(
                                    Icons.arrow_drop_down_sharp,
                                    color: kPrimaryColor,
                                  ),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          const Radius.circular(10).w),
                                    ),
                                    contentPadding: EdgeInsets.only(right: 8.w),
                                  ),
                                  onChanged: (String? newValue) async {
                                    if(newValue == 'مكتملة') {
                                      Get.snackbar('مهلاً', 'لا يمكنط تحديث حالة الطلب');
                                    }else{
                                      // نحدث حالة الطلب ب api ثم نطلب التحديثات
                                      await updateOrderStatus(orderId: widget.orderList[index]!.id!,status: newValue! );
                                      await _orderGetXController.showOrders();
                                      setState(() {
                                        // widget.selectedOption = newValue!;
                                      });
                                    }
                                  },
                                  items: widget.items.map((String option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(option),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        )
            : Container(),
        SizedBox(
          height: 100.h,
        )
      ],
    );
  }

  Future<void> updateOrderStatus({required int orderId, required String status}) async {
    bool updated = await OrderApiController().changeOrderState(orderId, status);
  }
}



