import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/constants.dart';
import 'package:handcrafts/controller/cart_controller.dart';
import '../../utils/app_constant.dart';
import '../../widgets/app_button.dart';
import '../../widgets/no_products_yet.dart';

class CartScreen extends StatefulWidget {

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  CartController cartController = Get.find();

  final List<Map> myProducts =
  List.generate(100000, (index) => {"id": index, "name": "Product $index"})
      .toList();

  @override
  Widget build(BuildContext context) {
    return cartController.getItems.isEmpty ?
    const Center(
      child: NoProductsYet(image: 'assets/images/no_cart.svg',),
    ) :
    SingleChildScrollView(
      child: GetBuilder<CartController>(builder: (controller){
        var _cartList = controller.getItems;
        return Column(
          children: [
            Container(
              height: 550,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _cartList.length,
                itemBuilder: (context, index)=> Container(
                  height: 170,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(right: 10,left: 10,top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                                width: 130,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey.shade100,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        AppConstants.BASE_URL+AppConstants.Upload_URI+_cartList[index].img!
                                    ),
                                  ),
                                ),
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              height: 150,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.shade100
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      controller.addItemToCart(_cartList[index].product!, 1);
                                    },
                                    child: SvgPicture.asset('assets/icons/plus.svg'),
                                  ),
                                  Text(_cartList[index].quantity.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.bold),),
                                  InkWell(
                                      onTap: (){
                                        controller.addItemToCart(_cartList[index].product!, -1);
                                      },
                                      child: SvgPicture.asset('assets/icons/minus.svg')
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('اسم المنتج',
                                  style: TextStyle(fontSize: 18),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text('المتجر',
                                  style: TextStyle(color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 10,top: 8,bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  controller.addItemToCart(_cartList[index].product!, -(_cartList[index].quantity!));
                                },
                                  child: const Icon(Icons.delete_outline_rounded,color: Colors.red,size: 26,),),
                              const Text('30\$'),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 0,),
            AppButton(
              onPressed: (){
                Navigator.pushNamed(context, '/purchase_details_screen');
                // وخلي الليست صفر (نصفرها)
              },
              text: 'اطلب الآن 60\$',
            ),
            const SizedBox(height: 80,),
          ],
        );
      },)
    )
    ;
  }
}

// Center(
//       child: NoProductsYet(image: 'assets/images/no_cart.svg',
//       ),
//     );
