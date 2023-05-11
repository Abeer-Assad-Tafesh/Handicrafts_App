import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handcrafts/widgets/no_products_yet.dart';
import 'package:intl/intl.dart';
import '../../controller/cart_controller.dart';
import '../../utils/app_constant.dart';
import '../../widgets/all_appBar.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class BuyerCartHistoryScreen extends StatelessWidget {
  const BuyerCartHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartHistoryList =
        Get.find<CartController>().getHistoryCartItems().reversed.toList();

    Map<String, int> cartItemsPerOrderMap = {};

    for (int i = 0; i < cartHistoryList.length; i++) {
      if (cartItemsPerOrderMap.containsKey(cartHistoryList[i].time)) {
        cartItemsPerOrderMap.update(
            cartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrderMap.putIfAbsent(cartHistoryList[i].time!, () => 1);
      }
    }
    // value
    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrderMap.entries.map((e) => e.value).toList();
    }

    //key
    List<String> cartOrderTimeToList() {
      return cartItemsPerOrderMap.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList(); // ex. [3,1,3]
    var counter = 0;

    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < cartHistoryList.length) {
        DateTime parseDate = DateFormat('yyy-MM-dd HH:mm:ss')
            .parse(cartHistoryList[index].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat('dd-MM-yyy hh:mm a');
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(
        text: outputDate,
        color: Colors.black,
        size: 16,
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AllAppBar(
              text: 'طلباتي',
              back: true,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: GetBuilder<CartController>(builder: (controller) {
                  var cartItems = controller.getHistoryCartItems().length;
                  return cartItems <= 0
                      ? Center(
                          child:
                              NoProductsYet(image: 'assets/images/no_cart.svg'))
                      : Container(
                          margin: const EdgeInsets.only(
                            top: 20,
                            left: 20,
                            right: 20,
                          ),
                          child: MediaQuery.removePadding(
                            removeTop: true,
                            context: context,
                            child: ListView(
                              children: [
                                for (int i = 0; i < itemsPerOrder.length; i++)
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        timeWidget(counter),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 250,
                                              height: 200,
                                              color: Colors.red,
                                              child: GridView.builder(
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4,
                                                    crossAxisSpacing: 2,
                                                    mainAxisSpacing: 5,
                                                    childAspectRatio: 1,
                                                  ),
                                                  itemCount: itemsPerOrder[i],
                                                  itemBuilder:
                                                      (context, index) {
                                                    if (counter <
                                                        cartHistoryList
                                                            .length) {
                                                      counter++;
                                                    }
                                                    return Container(
                                                      height: 60,
                                                      width: 60 ,
                                                      margin: EdgeInsets.only(
                                                          right: 5),
                                                      decoration:
                                                          BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              image:
                                                                  DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(AppConstants.BASE_URL +
                                                                    AppConstants
                                                                        .Upload_URI +
                                                                    cartHistoryList[counter -
                                                                            1]
                                                                        .img!),
                                                              )),
                                                    );
                                                  }),
                                            ),
                                            SizedBox(
                                              height: 80,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SmallText(
                                                    text: 'المجموع',
                                                    color: Colors.black,
                                                  ),
                                                  BigText(
                                                    text:
                                                        '${itemsPerOrder[i].toString()} عنصر ',
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ),
                        );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
