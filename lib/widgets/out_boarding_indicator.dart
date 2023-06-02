import 'package:flutter/material.dart';
import 'package:handcrafts/constants.dart';

class OutBoardingIndicator extends StatelessWidget {

  final double width;
  final double height;
  final double marginEnd;
  final bool selected;
  final Color unSelectedColor;

  const OutBoardingIndicator({super.key,
    required this.selected,
    required this.marginEnd,
    this.width = 8,
    this.height= 8,
    this.unSelectedColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: selected ? kPrimaryColor : unSelectedColor,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsetsDirectional.only(end: marginEnd),
    );
  }
}
