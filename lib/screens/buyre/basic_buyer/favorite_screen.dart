import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/prefs/shared_pref_controller.dart';
import 'package:handcrafts/widgets/app_card.dart';
import 'package:handcrafts/widgets/not_yet.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Color _favoriteColor = Colors.white;
  final List<Map> myProducts =
      List.generate(10, (index) => {"id": index, "name": "Product $index"})
          .toList();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SharedPrefController().loggedIn
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 0),
                itemCount: 30,
                itemBuilder: (BuildContext ctx, index) {
                  return AppCard2(
                    topMargin: 10,
                  );
                })
            : const NotYet(
                image: 'assets/images/no_cart.svg',
                text: 'عذرًا! لم تسجل دخول',
                textButton: 'سجل دخول لرؤية عناصرك المفضلة',
                route: '/login_register_screen',
              ));
  }
}
