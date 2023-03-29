import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handcrafts/constants.dart';
import '../widgets/app_button.dart';
import '../widgets/no_products_yet.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map> myProducts =
  List.generate(100000, (index) => {"id": index, "name": "Product $index"})
      .toList();

  @override
  Widget build(BuildContext context) {
    return myProducts.isEmpty ?
    const Center(
      child: NoProductsYet(image: 'assets/images/no_cart.svg',),
    ) :
    SingleChildScrollView(
      child: Column(
        children: [
          Container(
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
                              color: Colors.grey.shade100
                          ),
                          child: SvgPicture.asset('assets/images/verif_code.svg',fit: BoxFit.fill,)
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
                            Icon(Icons.add,color: kDefaultColor,),
                            const Text('0',style: TextStyle(fontWeight: FontWeight.bold),),
                            Icon(Icons.remove,color: kDefaultColor,),
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
                      children: const [
                        Icon(Icons.delete_outline_rounded,color: Colors.red,size: 26,),
                        Text('30\$'),
                      ],
                    )
                ),
              ],
            ),
          ),
          Container(
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
                              color: Colors.grey.shade100
                          ),
                          child: SvgPicture.asset('assets/images/verif_code.svg',fit: BoxFit.fill,)
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
                            Icon(Icons.add,color: kDefaultColor,),
                            const Text('0',style: TextStyle(fontWeight: FontWeight.bold),),
                            Icon(Icons.remove,color: kDefaultColor,),
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
                      children: const [
                        Icon(Icons.delete_outline_rounded,color: Colors.red,size: 26,),
                        Text('30\$'),
                      ],
                    )
                ),
              ],
            ),
          ),
          const SizedBox(height: 60,),
          AppButton(
            onPressed: (){
              Navigator.pushNamed(context, '/purchase_details_screen');
              // وخلي الليست صفر (نصفرها)
            },
            text: 'اطلب الآن 60\$',
          ),
        ],
      ),
    )
    ;
  }
}

// Center(
//       child: NoProductsYet(image: 'assets/images/no_cart.svg',
//       ),
//     );
