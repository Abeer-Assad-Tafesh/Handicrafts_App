import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:handcrafts/api/get/favorite_product_getx_controller.dart';
import 'package:handcrafts/api/models/product.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:handcrafts/widgets/app_card.dart';
import 'package:handcrafts/widgets/not_yet.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SharedPrefController().loggedIn
          ? GetBuilder<FavoriteGetXController>(
              builder: (controller) {
                if (controller.loading) {
                  return Center(
                      child: CircularProgressIndicator(color: kPrimaryColor));
                } else if (controller.favoriteList.isNotEmpty) {
                  List<Product> favoriteProducts = controller.favoriteList;
                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 3 / 4,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 0),
                      itemCount: favoriteProducts.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return ProductCard(product: favoriteProducts[index]);
                      });
                } else {
                  return const NotYet(
                    image: 'assets/images/verif_code.svg',
                    text: 'احفظ عناصرك المفضلة هنا',
                  );
                }
              },
            )
          : const NotYet(
              image: 'assets/images/verif_code.svg',
              text: 'عذرًا! لم تسجل دخول',
              textButton: 'سجل دخول لرؤية عناصرك المفضلة',
              route: '/login_register_screen',
            ),
    );
  }
}
