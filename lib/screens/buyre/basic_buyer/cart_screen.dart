import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/controller/cart_controller.dart';
import 'package:handcrafts/controller/popular_product_controller.dart';
import 'package:handcrafts/controller/recommended_product_controller.dart';
import 'package:handcrafts/utils/app_constant.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/no_products_yet.dart';
import '../home/sub_home/product_details_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return cartController.getItems.isEmpty
        ? const Center(
            child: NoProductsYet(
              image: 'assets/images/no_cart.svg',
            ),
          )
        : SingleChildScrollView(
            child: GetBuilder<CartController>(
              builder: (controller) {
                var _cartList = controller.getItems;
                return Column(
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
                                      var popularIndex =
                                          Get.find<PopularProductControllers>()
                                              .popularProductList
                                              .indexOf(
                                                  _cartList[index].product);
                                      if (popularIndex >= 0) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailsScreen(
                                                    product: Get.find<
                                                                PopularProductControllers>()
                                                            .popularProductList[
                                                        popularIndex]),
                                          ),
                                        );
                                      } else {
                                        var recommendedIndex = Get.find<
                                                RecommendedProductControllers>()
                                            .recommendedProductList
                                            .indexOf(_cartList[index].product);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductDetailsScreen(
                                                product: Get.find<
                                                            RecommendedProductControllers>()
                                                        .recommendedProductList[
                                                    recommendedIndex]),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      width: 130,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey.shade100,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              AppConstants.BASE_URL +
                                                  AppConstants.Upload_URI +
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
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'اسم المنتج',
                                        style: TextStyle(fontSize: 18),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'المتجر',
                                        style: TextStyle(color: Colors.grey),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 10, top: 8, bottom: 8),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  Text('\$${_cartList[index].price}'),
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
                          controller.addItemsToHistory();
                          Navigator.pushNamed(
                              context, '/purchase_details_screen');
                          // وخلي الليست صفر (نصفرها)
                        },
                        text:
                            ' اطلب الآن | ${controller.totalCartProductsPrice.toInt()}\$'),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                );
              },
            ),
          );
  }
}
