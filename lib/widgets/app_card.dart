import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/api_settings.dart';
import 'package:handcrafts/api/get/favorite_product_getx_controller.dart';
import 'package:handcrafts/api/models/product.dart';
import 'package:handcrafts/api/models/store.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/small_text.dart';
import '../prefs/shared_pref_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.topMargin = 0,
  });

  final Product product;
  final double topMargin;

  @override
  State<ProductCard> createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    print('####################  ${widget.product.productImages![0].imageUrl}');
    return Container(
      height: 100,
      width: 180,
      margin: EdgeInsets.fromLTRB(10, widget.topMargin, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.green.shade100,
        boxShadow: [
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
            ApiSettings.getImageUrl(widget.product.productImages![0].imageUrl),
          ),
           /*NetworkImage(
            ApiSettings.getImageUrl(widget.product.imageUrl),
          ),*/
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
                icon: const Icon(
                    Icons.favorite_rounded,
                  // color: isFavorite ? Colors.red : Colors.white, size: 30,
                  color: Colors.white, size: 30,
                ),
                onPressed: () async {
                 if(SharedPrefController().loggedIn){
                   await updateFavorite();
                 }else{
                   Get.snackbar('مهلاً', 'سجل دخولك لإضافة عناصرك المفضلة الخاصة بك');
                   Navigator.pushNamed(context, '/login_register_screen');
                 }
                },
                // onPressed: () async => await updateFavorite(),
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
        ],
      ),
    );
  }

  Future<void> updateFavorite() async {
    bool status = await FavoriteGetXController.to.addFavorite(product: widget.product);
    if(status){
      setState(() {

        // widget.product.isFavorite =  !widget.product.isFavorite;
      });
    }else{
      await FavoriteGetXController.to.removeFavorite(product: widget.product);
    }
  }

/*  Future<void> updateFavorite() async {
    bool status = await FavoriteGetXController.to.updateFavorite(product: widget.product);
    if(status){
      setState(() {
        widget.product.isFavorite =  !widget.product.isFavorite;
      });
    }
  }*/

}


class StoreCard extends StatefulWidget {
  const StoreCard({
    super.key,
    required this.store,
    this.topMargin = 0,
  });

  final Store store;
  final double topMargin;

  @override
  State<StoreCard> createState() => StoreCardState();
}

class StoreCardState extends State<StoreCard> {
  @override
  Widget build(BuildContext context) {
    print('##########Store##########  ${widget.store.logoImage}');

    return Container(
      // height: 100,
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
            width: 110,
            margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: Colors.green.shade100,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  ApiSettings.getImageUrl(widget.store.logoImage!),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmallText(
                  text: widget.store.name!,
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
            ),
          )
        ],
      ),
    );
  }
}



class StoreCard2 extends StatefulWidget {
  const StoreCard2({
    super.key,
    this.topMargin = 0,
  });

  final double topMargin;

  @override
  State<StoreCard2> createState() => StoreCard2State();
}

class StoreCard2State extends State<StoreCard2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
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
            width: 110,
            margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: Colors.green.shade100,
              image: DecorationImage(
                fit: BoxFit.fill,
                image:AssetImage('assets/images/product1.png')
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmallText(
                  text: 'متجر ليلى',
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
            ),
          )
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
      width: 180,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.green.shade100,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        image: DecorationImage(
          fit: BoxFit.cover,
            image: AssetImage('assets/images/product3.png')

          /*NetworkImage(
            ApiSettings.getImageUrl(widget.product.imageUrl),
          ),*/
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
                icon:  Icon(
                  Icons.favorite_rounded,
                  // color: isFavorite ? Colors.red : Colors.white, size: 30,
                  color: Colors.white, size: 30,

                ),
                onPressed: () async {
                  if(SharedPrefController().loggedIn){
                  }else{
                    Get.snackbar('مهلاً', 'سجل دخولك لإضافة عناصرك المفضلة الخاصة بك');
                    Navigator.pushNamed(context, '/login_register_screen');
                  }
                },
                // onPressed: () async => await updateFavorite(),
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
              text: 'طارة',
              size: 13,
              color: Colors.white,
            ),
          ),
          Positioned(
            left: 10.w,
            bottom: 10.h,
            child: SmallText(
              text: '₪25',
              size: 13,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );

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
          image: AssetImage('assets/images/product3.png')
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
              text: 'طارة',
              size: 13,
            ),
          ),
          Positioned(
            left: 10,
            bottom: 10,
            child: SmallText(
              text: '₪25',
              size: 13,
            ),
          ),
        ],
      ),
    );
  }
}