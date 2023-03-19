import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/widgets/out_boarding_indicator.dart';

class OutBoardingContent extends StatelessWidget {

  final int currentPage;
  final String image;
  final String title;
  final String describe;

  const OutBoardingContent({super.key, required this.currentPage, required this.image, required this.title, required this.describe});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 3,
            child: SvgPicture.asset(image)),
        // const SizedBox(height: 10,),
        // const SizedBox(height: 10,),
        Expanded(
          flex: 1,
          child: Text(title,
            style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold
            ),),
        ),
        Expanded(
          flex: 1,
          child: Text(describe,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
            ),),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutBoardingIndicator(marginEnd: 5,selected: currentPage == 0,),
              OutBoardingIndicator(marginEnd: 5,selected: currentPage == 1),
              OutBoardingIndicator(marginEnd: 5,selected: currentPage == 2),
              OutBoardingIndicator(marginEnd: 0,selected: currentPage == 3),
            ],
          ),
        ),
      ],
    );
  }
}
