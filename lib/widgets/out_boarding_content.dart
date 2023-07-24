import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handcrafts/widgets/out_boarding_indicator.dart';
import 'package:handcrafts/widgets/small_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutBoardingContent extends StatelessWidget {

  final int currentPage;
  final String image;
  final String title;
  final String describe;

  const OutBoardingContent({super.key, required this.currentPage, required this.image, required this.title, required this.describe});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 3,
            child: SvgPicture.asset(image,height: 300.h,width: 300.w,)),
        Expanded(
          flex: 1,
          child: SmallText(text:title,
              size: 35,
              fontWeight: FontWeight.bold),
        ),
        Expanded(
          flex: 1,
          child: SmallText(text: describe,
            textAlign: TextAlign.center,
            size: 16,
                fontWeight: FontWeight.w500
            ),
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
