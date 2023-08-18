import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/get/product_getx_controller.dart.dart';
import 'package:handcrafts/screens/seller/product_ops/edit_product.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/big_text.dart';
import 'package:handcrafts/widgets/not_yet.dart';
import 'package:handcrafts/widgets/small_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsOperationsScreen extends StatefulWidget {
  const ProductsOperationsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOperationsScreen> createState() =>
      _ProductsOperationsScreenState();
}

class _ProductsOperationsScreenState extends State<ProductsOperationsScreen> {
  bool hideProduct = false;

  @override
  Widget build(BuildContext context) {
    return GetX<ProductGetXController>(builder: (controller) {
      if (controller.storeProductsList.isNotEmpty) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/add_product_page');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10).r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10).r,
                      border: Border.all(color: kPrimaryColor),
                      color: kSecondaryColor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/icons/add_circle.svg'),
                        SizedBox(width: 8.w),
                        SmallText(
                          text: 'إضافة المنتج',
                          size: 12.sp,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                SingleChildScrollView(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200.h,
                      childAspectRatio: 3 / 6.4,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: controller.storeProductsList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15).r),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15).r,
                                  child: Container(
                                    height: 250,
                                    width: 200,
                                    child: Image.network(
                                      controller.storeProductsList[index]!
                                          .productImages![0].imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15).r,
                                      // color: Colors.transparent,
                                      gradient: LinearGradient(
                                        begin:
                                            AlignmentDirectional.bottomCenter,
                                        end: Alignment.center,
                                        colors: [
                                          Colors.black,
                                          Colors.black.withOpacity(0.5),
                                          Colors.black12,
                                          Colors.white.withOpacity(0.1),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    left: 8.w,
                                    right: 8.w,
                                    bottom: 10.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SmallText(
                                          text: controller
                                              .storeProductsList[index]!.name,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                        SmallText(
                                          text:
                                              "₪${controller.storeProductsList[index]!.price}",
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          SmallText(
                            text: 'معتمد',
                            size: 12,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/edit_product_page');
                                  /*Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                EditProductPage(product: controller.storeProductsList[index]!,)));*/
                                },
                                child:
                                    SvgPicture.asset('assets/icons/edit.svg'),
                              ),
                              const SizedBox(width: 25),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          insetPadding:
                                              const EdgeInsets.all(10).r,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  const Radius.circular(10.0)
                                                      .r)),
                                          content: Padding(
                                            padding:
                                                const EdgeInsets.all(8.0).r,
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.all(10.0).r,
                                              width: 400.w,
                                              // height: 400,
                                              child: Column(
                                                children: [
                                                  BigText(
                                                      text:
                                                          'هل تريد حذف المنتج؟'),
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          // _deleteProduct(controller.storeProductsList[index]!.id);
                                                        },
                                                        child: AppButton(
                                                          text: 'حذف',
                                                          width: 150,
                                                          color: kRedColor,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {},
                                                        child: const AppButton(
                                                          text: 'إلغاء',
                                                          width: 150,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child:
                                    SvgPicture.asset('assets/icons/delete.svg'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          InkWell(
                            onTap: () {
                              if (hideProduct) {
                                setState(() {
                                  hideProduct = false;
                                });
                                print('if hideProduct====> $hideProduct');
                              } else {
                                setState(() {
                                  hideProduct = true;
                                });
                              }
                              print('else hideProduct====> $hideProduct');
                            },
                            child: Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15).r,
                                // color: Colors.transparent,
                                color: Colors.green.shade50.withOpacity(0.7),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  hideProduct
                                      ? SvgPicture.asset(
                                          'assets/icons/unshow.svg',
                                          color: kPrimaryColor,
                                          width: 20.w,
                                          height: 20.h,
                                        )
                                      : SvgPicture.asset(
                                          'assets/icons/show.svg'),
                                  SizedBox(width: 8.w),
                                  SmallText(
                                    text: hideProduct
                                        ? 'إظهار المنتج'
                                        : 'إخفاء المنتج',
                                    size: 12,
                                    color: kPrimaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        );
      } else {
        return const NotYet(
          image: 'assets/images/verif_code.svg',
          text: 'لا يوجد منتجات حتى الآن!',
          textButton: 'أضف منتجات إلى متجرك',
          route: '/add_product_page',
        );
      }
    });
  }

  Future<void> _deleteProduct(int productId) async {
    await ProductGetXController.to.deleteProduct(productId: productId);
  }
}
