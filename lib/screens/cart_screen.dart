import 'package:flutter/material.dart';
import '../widgets/no_products_yet.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: NoProductsYet(image: 'assets/images/no_cart.svg',
      ),
    );
  }
}

