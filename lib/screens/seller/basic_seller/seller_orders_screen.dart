import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/constants.dart';
import 'package:handcrafts/screens/seller/basic_seller/seller_orders_pages/all_orders_page.dart';
import 'package:handcrafts/widgets/big_text.dart';
import 'package:handcrafts/widgets/small_text.dart';
import 'package:handcrafts/widgets/timeline.dart';

class SellerOrdersScreen extends StatefulWidget {
  const SellerOrdersScreen({Key? key}) : super(key: key);

  @override
  State<SellerOrdersScreen> createState() => _SellerOrdersScreenState();
}

class _SellerOrdersScreenState extends State<SellerOrdersScreen> {
  final List<String> items = [
    "اختر حالة الطلب",
    "قيد المراجعة",
    "قيد التجهيز",
    " قيد التوصيل",
    "مكتملة",
  ];
  int current = 0;
  late String selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = items[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          // Tab bar
          Container(
            height: 60,
            width: double.infinity,
            margin: const EdgeInsets.only(right: 10),
            child: ListView.builder(
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      current = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color:
                            current == index ? Colors.white : kSecondaryColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
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
                        text: items[index],
                        size: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Body
          current == 0
              ? AllOrdersPage(items: items,selectedOption: selectedOption)
              : current == 1 ? AllOrdersPage(items: items,selectedOption: selectedOption)
              : current == 2 ? AllOrdersPage(items: items,selectedOption: selectedOption)
              : AllOrdersPage(items: items,selectedOption: selectedOption)
        ],
      ),
    );
  }
}
