import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/constants.dart';
import 'package:handcrafts/controller/cart_controller.dart';
import 'package:handcrafts/controller/popular_product_controller.dart';
import 'package:handcrafts/models/product_model.dart';
import 'package:handcrafts/screens/full_image_screen.dart';
import 'package:handcrafts/utils/app_constant.dart';
import 'package:handcrafts/widgets/all_appBar.dart';
import 'package:handcrafts/widgets/app_button.dart';


class ProductDetailsScreen extends StatelessWidget {
  final ProductModel? product;
  const ProductDetailsScreen({
    Key? key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductControllers>()
        .initProduct(product!, Get.find<CartController>());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AllAppBar(
              back: true,
            ),
            Expanded(
              child: SingleChildScrollView(
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
                                            image: AppConstants.BASE_URL +
                                                AppConstants.Upload_URI +
                                                product!.img!,
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
                                          AppConstants.BASE_URL +
                                              AppConstants.Upload_URI +
                                              product!.img!,
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
                                        image: AppConstants.BASE_URL +
                                            AppConstants.Upload_URI +
                                            product!.img!,
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
                                      AppConstants.BASE_URL +
                                          AppConstants.Upload_URI +
                                          product!.img!,
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
                                  Navigator.pushNamed(context, '/shop_screen');
                                },
                                child: Text(
                                  'اسم المتجر',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: kPrimaryColor,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              const SizedBox(),
                            ],
                          ),
                          const SizedBox(height: 15),
                          // product name, share, favorite
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'اسم المنتج',
                                style: TextStyle(
                                    fontSize: 14, color: kPrimaryColor),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/share.svg",
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
                              Text(
                                'تطريز',
                                style: TextStyle(
                                    fontSize: 14, color: kPrimaryColor),
                              ),
                              const Text(
                                "ID: 4678",
                              ),
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
                                  Text(
                                    'يومين عمل',
                                    style: TextStyle(
                                        fontSize: 14, color: kPrimaryColor),
                                  ),
                                ],
                              ),
                              // product rating
                              Row(
                                children: [
                                  const Text(
                                    "4.5",
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.asset(
                                    "assets/icons/yellow_star.svg",
                                  )
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
                          Text(
                            'الوصف',
                            style:
                                TextStyle(fontSize: 14, color: kPrimaryColor),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5)),
                              ),
                            ),
                            child: const Text(
                              '20 \$',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
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
                              const Text(
                                'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى،'
                                ' حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.'
                                'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى،'
                                'حيث يمكنك أن تولد مثل هذا النص.',
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'عدد المنتج',
                                    style: TextStyle(
                                        fontSize: 14, color: kPrimaryColor),
                                  ),
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
                                    Text(
                                      controller.inCartSameProductItems
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
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
                                onPressed: () {
                                  controller.addItem(product!);
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
