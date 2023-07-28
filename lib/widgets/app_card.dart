import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/api/models/all_products.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/models/product_model.dart';
import 'package:handcrafts/widgets/small_text.dart';
import '../utils/app_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCard extends StatefulWidget {
  const AppCard({
    super.key,
    required this.product,
    this.topMargin = 0,
  });

  final AllProducts product;
  final double topMargin;

  @override
  State<AppCard> createState() => AppCardState();
}

class AppCardState extends State<AppCard> {
  Color _favoriteColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 180,
      margin: EdgeInsets.fromLTRB(10, widget.topMargin, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.green.shade100,
        boxShadow: [
          // BoxShadow(color: Colors.grey,spreadRadius: 0.1,blurRadius: 3),
          // BoxShadow(color: Colors.grey,spreadRadius: 0.1,blurRadius: 5),
          // BoxShadow(color: Colors.grey,spreadRadius: 0.1,blurRadius: 5),
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            widget.product.imageUrl,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 10,
            top: 10,
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                icon: Icon(Icons.favorite_rounded,
                    color: _favoriteColor, size: 30),
                onPressed: () {
                  setState(() {
                    if (_favoriteColor == Colors.white) {
                      _favoriteColor = Colors.red.shade900;
                    } else {
                      _favoriteColor = Colors.white;
                    }
                  });
                },
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
            right: 10.w,
            bottom: 10.h,
            child: SmallText(
              text: '...${widget.product.name.substring(0, 8)}',
              size: 13,
              color: Colors.white,
            ),
          ),
          Positioned(
            left: 10.w,
            bottom: 10.h,
            child: SmallText(
              text: '₪${widget.product.price}',
              size: 13,
              color: Colors.white,
            ),
          ),
          /*Positioned(
              left: 8.w,
              right: 8.w,
              bottom: 10.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(
                    text: "اسم المنتج",
                    size: 14,
                    color: Colors.white,
                  ),
                  SmallText(
                    text: "₪20",
                    size: 14,
                    color: Colors.white,
                  ),
                ],
              )),*/
        ],
      ),
    );

  }
}

class AppCard2 extends StatefulWidget {
  const AppCard2({
    super.key,
    this.topMargin = 0,
  });

  // final ProductModel product;
  final double topMargin;

  @override
  State<AppCard2> createState() => AppCard2State();
}

class AppCard2State extends State<AppCard2> {
  Color _favoriteColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 200,
      margin: EdgeInsets.fromLTRB(10, widget.topMargin, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.green.shade100,
        boxShadow: [
          // BoxShadow(color: Colors.grey,spreadRadius: 0.1,blurRadius: 3),
          // BoxShadow(color: Colors.grey,spreadRadius: 0.1,blurRadius: 5),
          // BoxShadow(color: Colors.grey,spreadRadius: 0.1,blurRadius: 5),
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            'widget.product.imageUrl!',
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
              right: 10,
              top: 10,
              child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.favorite_rounded,
                        color: _favoriteColor, size: 30),
                    onPressed: () {
                      setState(() {
                        if (_favoriteColor == Colors.white) {
                          _favoriteColor = Colors.red.shade900;
                        } else {
                          _favoriteColor = Colors.white;
                        }
                      });
                    },
                  ))),
          Positioned(
            right: 10,
            bottom: 10,
            child: SmallText(
              text: '...{widget.product.name.substring(0, 8)}',
              size: 13,
            ),
          ),
          Positioned(
            left: 10,
            bottom: 10,
            child: SmallText(
              text: '₪{widget.product.price}',
              size: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class AppCard3 extends StatefulWidget {
  const AppCard3({
    super.key,
    this.topMargin = 0,
  });

  // final ProductModel product;
  final double topMargin;

  @override
  State<AppCard3> createState() => AppCard3State();
}

class AppCard3State extends State<AppCard3> {
  Color _favoriteColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 260,
      margin: EdgeInsets.fromLTRB(10, widget.topMargin, 10, 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          // BoxShadow(color: Colors.grey,spreadRadius: 0.1,blurRadius: 3),
          // BoxShadow(color: Colors.grey,spreadRadius: 0.1,blurRadius: 5),
          // BoxShadow(color: Colors.grey,spreadRadius: 0.1,blurRadius: 5),
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 120,
            margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: Colors.green.shade100,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/product1.png'),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SmallText(
                text: "اسم المتجر",
                size: 16,
                maxLines: 1,
              ),
              SmallText(
                text: "تطريز",
                size: 14,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/yellow_star.svg",
                    color: kPrimaryColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SmallText(
                    text: "4.5",
                    size: 14,
                    color: kPrimaryColor,
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/location.svg",
                    color: kPrimaryColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SmallText(
                    text: "فلسطين_غزة",
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

//            child: Stack(
//               children: [
//                 Positioned(
//                   right: 10,
//                   top: 10,
//                   child: Container(
//                     height: 45,
//                     width: 45,
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade300,
//                       borderRadius: BorderRadius.circular(100),
//                     ),
//                     child: IconButton(
//                       icon: Icon(Icons.favorite_rounded,
//                           color: _favoriteColor, size: 30),
//                       onPressed: () {
//                         setState(() {
//                           if (_favoriteColor == Colors.white) {
//                             _favoriteColor = Colors.red.shade900;
//                           } else {
//                             _favoriteColor = Colors.white;
//                           }
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 Positioned(left: 10, bottom: 10, child: Text('\$ 5')),
//                 Positioned(
//                   top: 0,
//                   left: 0,
//                   right: 0,
//                   bottom: 0,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15).r,
//                       // color: Colors.transparent,
//                       gradient: LinearGradient(
//                         begin: AlignmentDirectional.bottomCenter,
//                         end: Alignment.center,
//                         colors: [
//                           Colors.black,
//                           Colors.black.withOpacity(0.5),
//                           Colors.black12,
//                           Colors.white.withOpacity(0.1),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                     left: 8.w,
//                     right: 8.w,
//                     bottom: 10.h,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SmallText(
//                           text: "اسم المنتج",
//                           size: 14,
//                           color: Colors.white,
//                         ),
//                         SmallText(
//                           text: "\$20",
//                           size: 14,
//                           color: Colors.white,
//                         ),
//                       ],
//                     )),
//               ],
//             ),
