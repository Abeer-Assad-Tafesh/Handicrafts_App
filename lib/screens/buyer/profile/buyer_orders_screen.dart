import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/big_text.dart';
import 'package:handcrafts/widgets/small_text.dart';
import 'package:handcrafts/widgets/timeline.dart';

import '../../../api/api_settings.dart';
import '../../../api/get/order_getx_controller.dart.dart';
import '../../../api/models/order.dart';

class BuyerOrdersScreen extends StatefulWidget {
  const BuyerOrdersScreen({Key? key}) : super(key: key);

  @override
  State<BuyerOrdersScreen> createState() => _BuyerOrdersScreenState();
}

class _BuyerOrdersScreenState extends State<BuyerOrdersScreen> {

  final OrderGetXController _orderController = Get.find();

  final List<String> pages = [
    "طلب 1",
    "طلب 2",
    "طلب 3",
    "طلب 4",
    "طلب 5",
    "طلب 6",
  ];
  final List<String> items = [
    "اختر حالة الطلب",
    "قيد المراجعة",
    "قيد التجهيز",
    " قيد التوصيل",
    "مكتملة",
  ];

  int current = 0;
  String selectedOption = "اختر حالة الطلب";

  @override
  void initState() {
    super.initState();
    // selectedOption = items[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AllAppBar(
              text: 'طلباتي',
              back: true,
              spaceBeforeLogo: 45,
            ),
            Expanded(
              child: GetBuilder<OrderGetXController>(builder: (controller) {
                var ordersList = controller.userOrdersList;
                print(ordersList);
                return ordersList.isEmpty ?
                Container()
                    : Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Container(
                        height: 60.h,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: ordersList.length,
                          scrollDirection: Axis.horizontal,
                          // physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  current = index;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5).r,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 2.h),
                                decoration: BoxDecoration(
                                    color: current == index
                                        ? Colors.white
                                        : kSecondaryColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(10).r,
                                        topRight: const Radius.circular(10).r),
                                    boxShadow: current == index
                                        ? [
                                      const BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 1,
                                          spreadRadius: 0),
                                      const BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 10,
                                          spreadRadius: 9),
                                    ]
                                        : [
                                      const BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 0.5,
                                        spreadRadius: 1,
                                      ),
                                    ]),
                                child: Center(
                                  child: BigText(
                                    text: 'طلب ${index + 1}',
                                    size: 14.sp,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Body
                      BuyerOrderDetails(
                        current: current, order: ordersList[current]!,items: items,),
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class BuyerOrderDetails extends StatelessWidget {
  final int current;
  final Orderr order;
  final List<String> items;

  const BuyerOrderDetails(
      {Key? key, required this.current, required this.order, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.0.r,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: NetworkImage(
                      ApiSettings.getImageUrl(order.store?.logoImage?.replaceFirst('uploads/', '')?? ''),
                    ),
                  ),
                  SizedBox(width: 10.0.w),
                  SmallText(
                    text: '${order.store?.storeOwner}',
                    size: 14,
                  ),
                ],
              ),
              DeliveryTimeline(
                  currentStep: items.indexOf(order.orderStatus.toString()) - 1),
              const Divider(thickness: 1.5),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: order.orderItems?.length, //_cartList.length,
                itemBuilder: (context, i) =>
                    Container(
                      height: 130.h,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.only(
                          right: 10, left: 10, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                // product image
                                Container(
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: Colors.grey.shade100,
                                  ),
                                  child: Image.network(
                                    ApiSettings.getImageUrl(order.orderItems?[i].product?.productImages?[0]?.imageUrl.replaceFirst('uploads/', '') ?? ''),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    SmallText(
                                      text: '${order.orderItems?[i].productName}',
                                      color: Colors.grey,
                                      size: 14.sp,
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/calendar.svg'),
                                        SizedBox(width: 10.w),
                                        SmallText(
                                          text: 'يومين عمل',
                                          color: Colors.grey,
                                          size: 12.sp,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    SmallText(
                                      text: 'عدد المنتج: ${order.orderItems?[i].quantity}',
                                      color: Colors.grey,
                                      size: 12.sp,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: DefaultTextStyle
                                            .of(context)
                                            .style,
                                        children:  <TextSpan>[
                                          TextSpan(
                                            text: '${order.orderItems?[i].price}',
                                            style: const TextStyle(fontSize: 24.0),
                                          ),
                                          const TextSpan(
                                            text: '₪',
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // SmallText(text: '20₪',size: 20,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: const EdgeInsets.all(10).r,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: 'المجموع',
                          size: 14.sp,
                        ),
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle
                                .of(context)
                                .style,
                            children:  <TextSpan>[
                              TextSpan(
                                text: '${order.total}',
                                style: const TextStyle(fontSize: 20.0),
                              ),
                              const TextSpan(
                                text: '₪',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: 'التوصيل',
                          size: 14.sp,
                        ),
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle
                                .of(context)
                                .style,
                            children: const <TextSpan>[
                              TextSpan(
                                text: '4',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              TextSpan(
                                text: '₪',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: 'الإجمالي',
                          size: 14.sp,
                        ),
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle
                                .of(context)
                                .style,
                            children:  <TextSpan>[
                              TextSpan(
                                text: '${(order.total)! + 4}',
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(
                                text: '₪',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
