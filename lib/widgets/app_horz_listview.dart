// import 'package:flutter/material.dart';
// import 'package:handcrafts/models/product.dart';
//
// import 'app_card.dart';
//
// class AppHorzListView extends StatefulWidget{
//    const AppHorzListView({Key? key,
//      required this.listTitle,
//      this.productName,
//      this.productItemImage,
//      this.productsItemCount,
//      this.onTap,}) : super(key: key);
//
//
//   final String listTitle;
//   final String? productName;
//   final String? productItemImage;
//   final int? productsItemCount;
//   final VoidCallback? onTap;
//
//    @override
//   State<AppHorzListView> createState() => _AppHorzListView();
// }
//
// class _AppHorzListView extends State<AppHorzListView> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 360,
//       // color: Colors.red,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: InkWell(
//               onTap: widget.onTap,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     widget.listTitle,
//                     style: const TextStyle(fontSize: 18),
//                   ),
//                   const Icon(Icons.arrow_forward_ios),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 300,
//             child: ListView.builder(
//               shrinkWrap: false,
//               scrollDirection: Axis.horizontal,
//               itemCount: demoProduct.length,
//               itemBuilder: (BuildContext context, int index) =>
//               Container()
//               /*AppCard(
//                  product: demoProduct[index],
//               ),*/
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
