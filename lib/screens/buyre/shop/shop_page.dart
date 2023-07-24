import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/get/home_getx_controller.dart';
import 'package:handcrafts/api/models/all_products.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/screens/buyre/home/sub_home/product_details_screen.dart';
import 'package:handcrafts/widgets/app_card.dart';
import 'package:handcrafts/widgets/not_yet.dart';
import 'package:handcrafts/widgets/small_text.dart';

class ShopPage extends StatefulWidget {
  AllProducts? product;
   ShopPage({Key? key,this.product}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  HomeGetXController _shopPageController = Get.find<HomeGetXController>();

  Color _favoriteColor = Colors.white;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<HomeGetXController>(
        builder: (controller) {
          int targetStoreId = widget.product!.storeId;
          List<AllProducts>? productsOfStore = controller.productsList.where((product) => product.storeId == targetStoreId).toList();
          double totalRating = 0; // Default value for totalRating
          if (productsOfStore.isNotEmpty) {
            totalRating = productsOfStore.map((product) => product.rating).reduce((a, b) => a + b);
            totalRating = totalRating / productsOfStore.length;
          }
          if (controller.loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              );
            } else if (productsOfStore.isNotEmpty) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 40),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(500),
                              color: Colors.grey,
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  widget.product!.store.logoImage,
                                  fit: BoxFit.cover, // You can adjust the fit mode as per your requirement
                                  height: 100,
                                  width: 100,
                                ),
                              )
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                 widget.product!.store.name,
                                  style: TextStyle(
                                      fontSize: 18, color: kPrimaryColor),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/yellow_star.svg",
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                     SmallText(
                                       text: totalRating.toString(),
                                        size: 12,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/location.svg",
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    const Text(
                                      "غزة_فلسطين",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 800,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 300,
                                childAspectRatio: 2.2 / 3,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 10),
                        itemCount: productsOfStore.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsScreen(
                                      product: productsOfStore[index],
                                      productId: productsOfStore[index].id,
                                    ),
                                  ));
                            },
                              child: AppCard(product: productsOfStore[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const NotYet(
                image: 'assets/images/verif_code.svg',
                title: 'عذراً!',
                text: 'لا يوجد بيانات',
              );
            }
          },
        ),
      ),
    );
  }
}
