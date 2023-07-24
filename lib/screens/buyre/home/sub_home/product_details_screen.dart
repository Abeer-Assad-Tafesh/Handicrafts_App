import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/get/home_getx_controller.dart';
import 'package:handcrafts/api/models/all_products.dart';
import 'package:handcrafts/deepLink/dynamic_link_service.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/api/controllers/cart_controller.dart';
import 'package:handcrafts/api/controllers/popular_product_controller.dart';
import 'package:handcrafts/models/product_model.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:handcrafts/screens/buyre/shop/shop_screen.dart';
import 'package:handcrafts/screens/full_image_screen.dart';
import 'package:handcrafts/utils/app_constant.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/small_text.dart';

class ProductDetailsScreen extends StatefulWidget {
  final AllProducts? product;
  final int? productId;

  const ProductDetailsScreen({
    Key? key,
    this.product,
    this.productId
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  double _userRating = 0.0;
  HomeGetXController _homeGetXController = Get.find<HomeGetXController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AllAppBar(
              back: true,
            ),
            Expanded(
              child: GetBuilder<HomeGetXController>(builder: (controller){
                print('99999999${controller.productsList.first}9999999');
                AllProducts? product = controller.productsList.
                firstWhere((product) => product.id == widget.productId);
                if(product != null){
                  Get.find<PopularProductControllers>()
                      .initProduct(product, Get.find<CartController>());
                }
                print('333333333333333');
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 20, bottom: 0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 350,
                                  width: MediaQuery.of(context).size.width / 3.2,
                                  child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: 3,
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => FullImageScreen(
                                              image: product.imageUrl,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 107,
                                        margin: const EdgeInsets.only(
                                            left: 15, bottom: 14.5),
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            product.imageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => FullImageScreen(
                                          image: product.imageUrl,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 350,
                                    width:
                                    MediaQuery.of(context).size.width / 1.58,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        product.imageUrl!,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // shop name
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => ShopScreen(
                                          product: product,
                                        )));
                                  },
                                  child: SmallText(
                                      text: product.store.name,
                                      size: 14,
                                      color: kPrimaryColor,
                                      decoration: TextDecoration.underline),
                                ),
                                const SizedBox(),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // shop name
                                InkWell(
                                  onTap: () {
                                    _showRatingDialog(context); // Show the rating dialog when the user presses the button
                                  },
                                  child: SmallText(
                                      text: 'اضغط لتقييم المنتج',
                                      size: 14,
                                      color: kPrimaryColor,
                                      decoration: TextDecoration.underline),
                                ),
                                const SizedBox(),
                              ],
                            ),
                            const SizedBox(height: 15),

                            // product name, share, favorite
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmallText(
                                    text: product.name,
                                    size: 14,
                                    color: kPrimaryColor),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        DynamicLinksService.createDynamicLink(product.id,0,image: product.imageUrl).then((value){
                                          //Sharing the content on other applications
                                          DynamicLinksService.shareData(context, product.imageUrl, value);
                                        });
                                      },
                                      child: SvgPicture.asset(
                                        "assets/icons/share.svg",
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SvgPicture.asset(
                                      "assets/icons/white_heart.svg",
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            // product type, id
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmallText(
                                    text: product.category.name,
                                    size: 14,
                                    color: kPrimaryColor),
                                SmallText(
                                    text: "ID: ${product.id}", size: 16),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // product work days
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/calendar.svg",
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SmallText(
                                        text: product.slug,
                                        size: 14,
                                        color: kPrimaryColor),
                                  ],
                                ),
                                // product rating
                                Row(
                                  children: [
                                    SmallText(
                                      text: "${product.rating}",
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SvgPicture.asset(
                                      "assets/icons/yellow_star.svg",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                      // product description, price
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallText(
                                text: 'الوصف', size: 14, color: kPrimaryColor),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                ),
                              ),
                              child: SmallText(
                                  text: '${product.price} ₪',
                                  size: 18,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 30),
                        child: GetBuilder<PopularProductControllers>(
                          builder: (controller) {
                            return Column(
                              children: [
                                const SizedBox(height: 5),
                                SmallText(
                                    text: product.description, size: 12),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    SmallText(
                                        text: 'عدد المنتج',
                                        size: 14,
                                        color: kPrimaryColor),
                                    const SizedBox(),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey.shade100),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.setQuantity(true);
                                        },
                                        child: SvgPicture.asset(
                                            'assets/icons/plus.svg'),
                                      ),
                                      SmallText(
                                          text: controller.inCartSameProductItems
                                              .toString(),
                                          fontWeight: FontWeight.bold,
                                        size: 15,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            controller.setQuantity(false);
                                          },
                                          child: SvgPicture.asset(
                                              'assets/icons/minus.svg')),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30),
                                AppButton(
                                  text: 'إضافة إلى السلة',
                                  color: kPrimaryColor,
                                  onPressed: () {
                                    SharedPrefController().loggedIn
                                        ? controller.addItem(product)
                                        : Get.snackbar('عذرًا',
                                        ' يجب عليك تسجيل الدخول أولاً :)');
                                    /*showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        // insetPadding: const EdgeInsets.all(10),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                        content: Center(
                                          child: Text(
                                            'تم إضافة العنصر إلى السلة',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: kDefaultColor),
                                          ),
                                        ),
                                      );
                                    },
                                  );*/
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              })
            ),
          ],
        ),
      ),
    );
  }
  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: SmallText(text: 'تقييم المنتج',size: 16,),
            content: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h,vertical: 10),
              child: RatingBar.builder(
                initialRating: _userRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => SvgPicture.asset(
                  "assets/icons/yellow_star.svg",
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _userRating = rating;
                  });
                },
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  //_saveRatingToApi(_userRating); // Save the rating to the API when the user closes the dialog
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('حفظ التقييم'),
              ),
            ],
          ),
        );
      },
    );
  }

/*
  Future<void> _saveRatingToApi(double rating) async {
    // Perform the API call here to save the rating
    try {
      // Replace 'YOUR_API_ENDPOINT' with your actual API endpoint
      final response = await http.post(
        Uri.parse('YOUR_API_ENDPOINT'),
        body: {
          'product_id': 'YOUR_PRODUCT_ID', // Replace with the product's ID
          'rating': rating.toString(),
        },
      );

      if (response.statusCode == 200) {
        // Successfully saved rating to the API
        // You can update the local product rating if needed
        setState(() {
          widget.product.rating = rating;
        });
        // Show a confirmation or success message to the user if needed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم حفظ التقييم!')),
        );
      } else {
        // Handle API error if needed
        print('Failed to save rating to the API. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
      print('Error saving rating to API: $e');
    }
  }
*/
}
