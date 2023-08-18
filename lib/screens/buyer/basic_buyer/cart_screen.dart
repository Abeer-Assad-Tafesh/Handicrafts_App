import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/models/cart_model.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/api/controllers/cart_controller.dart';
import 'package:handcrafts/api/controllers/popular_product_controller.dart';
import 'package:handcrafts/api/controllers/recommended_product_controller.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:handcrafts/screens/purchase_details_screen.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/big_text.dart';
import 'package:handcrafts/widgets/not_yet.dart';
import '../home/sub_home/product_details_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartController cartController = Get.find();

  bool isLoading = false;

  void startLoading() {
    setState(() {
      isLoading = true;
    });

    // Simulate a loading delay of 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      var itemsByStore = controller.getItemsByStore();
      return SharedPrefController().loggedIn
          ? isLoading == false
              ? controller.getItems.isEmpty
                  ? const Center(
                      child: NotYet(
                        image: 'assets/images/no_cart.svg',
                        text: 'عذرًا! لا يوجد منتجات',
                        textButton: 'تسوق الآن',
                        route: '/basic_buyer_screens',
                      ),
                    )
                  : SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                            itemCount: itemsByStore.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              String storeId = itemsByStore.keys.toList()[index];
                              List<CartModel> itemsInStore = itemsByStore[storeId]!;

                              return ExpansionTile(
                                // collapsedBackgroundColor: kPrimaryColor,
                                textColor: kPrimaryColor,
                                iconColor: kPrimaryColor,
                                collapsedIconColor: Colors.black,
                                title: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/store_logo.png',
                                      // Replace with the store's image path
                                      width: 80,
                                      height: 60,
                                    ),
                                    const SizedBox(width: 10),
                                    Text('${itemsInStore[index].product!.store.name}'),
                                    // Replace with the actual store name
                                  ],
                                ),
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: itemsInStore.length,
                                    itemBuilder: (context, index) {
                                      // Display individual items in the store
                                      // CartModel item = itemsInStore[index];
                                      return Container(
                                        height: 170,
                                        width: double.infinity,
                                        margin: const EdgeInsets.only(top: 10),
                                        padding:
                                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  // product image
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductDetailsScreen(
                                                                  product: itemsInStore[index].product,
                                                                  productId: itemsInStore[index].product!.id),
                                                        ),
                                                      );

                                                    },
                                                    child: Container(
                                                      width: 130,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        color: Colors.grey.shade100,
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              itemsInStore[index].img!),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Container(
                                                    height: 150,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        color: Colors.grey.shade100),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceAround,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            controller.addItemToCart(
                                                                itemsInStore[index].product!, 1);
                                                          },
                                                          child: SvgPicture.asset(
                                                              'assets/icons/plus.svg'),
                                                        ),
                                                        Text(
                                                          itemsInStore[index].quantity.toString(),
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                        InkWell(
                                                            onTap: () {
                                                              controller.addItemToCart(
                                                                  itemsInStore[index].product!,
                                                                  -1);
                                                            },
                                                            child: SvgPicture.asset(
                                                                'assets/icons/minus.svg')),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 120,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        BigText(
                                                            text: itemsInStore[index].product!.name,
                                                            size: 15
                                                        ),
                                                        BigText(
                                                            text: itemsInStore[index].product!.category.name!,
                                                            size: 12,
                                                            color: Colors.grey
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5, top: 8, bottom: 8),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller.addItemToCart(
                                                          itemsInStore[index].product!,
                                                          -(itemsInStore[index].quantity!));
                                                    },
                                                    child: const Icon(
                                                      Icons.delete_outline_rounded,
                                                      color: Colors.red,
                                                      size: 26,
                                                    ),
                                                  ),
                                                  Text('${itemsInStore[index].price}₪'),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            }),
                        const SizedBox(height: 60),
                        AppButton(
                          onPressed: () {
                            if (!isLoading) {
                              startLoading();
                              Future.delayed(const Duration(seconds: 3), () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) =>
                                        PurchaseDetails(

                                        )
                                    ));
                              });
                            }
                          },
                          text:
                          ' اطلب الآن | ₪${controller.totalCartProductsPrice.toDouble()}',
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  )
              : Center(
                  child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ))
          : const NotYet(
              image: 'assets/images/no_cart.svg',
              text: 'عذرًا! لم تسجل دخول',
              textButton: 'سجل دخول لإضافة عناصرك إلى السلة',
              route: '/login_register_screen',
            );
    });
  }
}

/*SingleChildScrollView(
                  child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _cartList.length,
                      itemBuilder: (context, index) => Container(
                        height: 170,
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 10),
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  // product image
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailsScreen(
                                                  product: _cartList[index].product,
                                                  productId: _cartList[index].product!.id),
                                        ),
                                      );

                                    },
                                    child: Container(
                                      width: 130,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey.shade100,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                                  _cartList[index].img!),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    height: 150,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey.shade100),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            controller.addItemToCart(
                                                _cartList[index].product!, 1);
                                          },
                                          child: SvgPicture.asset(
                                              'assets/icons/plus.svg'),
                                        ),
                                        Text(
                                          _cartList[index].quantity.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              controller.addItemToCart(
                                                  _cartList[index].product!,
                                                  -1);
                                            },
                                            child: SvgPicture.asset(
                                                'assets/icons/minus.svg')),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 120,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BigText(
                                          text: _cartList[index].product!.name,
                                          size: 15
                                        ),
                                        BigText(
                                          text: _cartList[index].product!.store.name,
                                         size: 12,
                                         color: Colors.grey
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 5, top: 8, bottom: 8),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.addItemToCart(
                                          _cartList[index].product!,
                                          -(_cartList[index].quantity!));
                                    },
                                    child: const Icon(
                                      Icons.delete_outline_rounded,
                                      color: Colors.red,
                                      size: 26,
                                    ),
                                  ),
                                  Text('${_cartList[index].price}₪'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    AppButton(
                        onPressed: () {
                          if (!isLoading) {
                            startLoading();
                            Future.delayed(const Duration(seconds: 3), () {
                              print(controller.getItems);
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) =>
                                      PurchaseDetails()
                              ));
                            });
                          }
                        },
                        text:
                            ' اطلب الآن | ₪${controller.totalCartProductsPrice.toDouble()}',
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ))*/




/*var popularIndex =
                                          Get.find<PopularProductControllers>()
                                              .popularProductList
                                              .indexOf(
                                                  _cartList[index].product!);
                                      if (popularIndex >= 0) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailsScreen(
                                                    product: Get.find<
                                                        PopularProductControllers>()
                                                        .popularProductList[
                                                    popularIndex],
                                                    productId: Get.find<
                                                                PopularProductControllers>()
                                                            .popularProductList[
                                                        popularIndex].id),
                                          ),
                                        );
                                      } else {
                                        var recommendedIndex = Get.find<
                                                RecommendedProductControllers>()
                                            .recommendedProductList
                                            .indexOf(_cartList[index].product!);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductDetailsScreen(
                                                product: Get.find<
                                                    RecommendedProductControllers>()
                                                    .recommendedProductList[
                                                recommendedIndex],
                                                productId: Get.find<
                                                            RecommendedProductControllers>()
                                                        .recommendedProductList[
                                                    recommendedIndex].id),
                                          ),
                                        );
                                      }*/