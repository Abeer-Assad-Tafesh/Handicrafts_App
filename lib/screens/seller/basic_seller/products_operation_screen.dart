import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/constants.dart';
import 'package:handcrafts/widgets/app_button.dart';
import 'package:handcrafts/widgets/big_text.dart';
import 'package:handcrafts/widgets/small_text.dart';

class ProductsOperationsScreen extends StatefulWidget {
  const ProductsOperationsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOperationsScreen> createState() =>
      _ProductsOperationsScreenState();
}

class _ProductsOperationsScreenState extends State<ProductsOperationsScreen> {
  Color _favoriteColor = Colors.white;
  final List<Map> myProducts =
      List.generate(10, (index) => {"id": index, "name": "Product $index"})
          .toList();

  bool hideProduct = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/add_product_page');
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kPrimaryColor),
                  color: kSecondaryColor,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset('assets/icons/add_circle.svg'),
                    SizedBox(width: 8),
                    SmallText(
                      text: 'إضافة المنتج',
                      size: 12,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 6.4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: myProducts.length,
              itemBuilder: (BuildContext ctx, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 4,
                      // margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: 250,
                              width: 200,
                              child: Image.asset(
                                'assets/images/product3.png',
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
                                borderRadius: BorderRadius.circular(15),
                                // color: Colors.transparent,
                                gradient: LinearGradient(
                                  begin: AlignmentDirectional.bottomCenter,
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
                              left: 8,
                              right: 8,
                              bottom: 10,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SmallText(
                                    text: "اسم المنتج",
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                  SmallText(
                                    text: "\$20",
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    SmallText(
                      text: 'معتمد',
                      size: 12,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/edit_product_page');
                          },
                          child: SvgPicture.asset('assets/icons/edit.svg'),
                        ),
                        SizedBox(width: 25),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    scrollable: true,
                                    insetPadding: const EdgeInsets.all(10),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        margin: const EdgeInsets.all(10.0),
                                        width: 400,
                                        // height: 400,
                                        child: Column(
                                          children: [
                                            BigText(
                                                text: 'هل تريد حذف المنتج؟'),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                InkWell(
                                                  onTap: (){},
                                                  child: AppButton(
                                                    text: 'حذف',
                                                    width: 150,
                                                    color: kRedColor,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: (){},
                                                  child: AppButton(
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
                          child: SvgPicture.asset('assets/icons/delete.svg'),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        if(hideProduct){
                          setState(() {
                            hideProduct = false;
                          });
                          print('if hideProduct====> $hideProduct');
                        }else{
                          setState(() {
                            hideProduct = true;
                          });
                        }
                        print('else hideProduct====> $hideProduct');
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          // color: Colors.transparent,
                          color: Colors.green.shade50.withOpacity(0.7),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            hideProduct
                                ? SvgPicture.asset('assets/icons/unshow.svg',color: kPrimaryColor,width: 20,height: 20,)
                                : SvgPicture.asset('assets/icons/show.svg'),
                            SizedBox(width: 8),
                            SmallText(
                              text: hideProduct ? 'إظهار المنتج' : 'إخفاء المنتج',
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
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
