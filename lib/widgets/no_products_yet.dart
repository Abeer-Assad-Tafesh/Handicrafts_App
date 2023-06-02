import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class NoProductsYet extends StatelessWidget {
  const NoProductsYet({
    super.key, required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Spacer(flex: 1,),
          Container(
              alignment: AlignmentDirectional.center,
              child: SvgPicture.asset(image)),
          const Text(
            'عذرًا! لا يوجد منتجات',
            style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          InkWell(
            onTap: (){
              Navigator.popAndPushNamed(context, '/home_screen');
            },
            child: Text(
              'تسوق الآن',
              style: TextStyle(color: kPrimaryColor,
                  fontSize: 18,
                  decoration: TextDecoration.underline),
            ),
          ),
          const Spacer(flex: 3,),
        ],
      ),
    );
  }
}
