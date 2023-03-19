import 'package:flutter/material.dart';
import '../widgets/no_products_yet.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Center(
        child: NoProductsYet(image: 'assets/images/no_favorite.svg',));
  }
}
