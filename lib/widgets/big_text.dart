import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  FontWeight fontWeight;
  TextDecoration textDecoration;

  BigText({
    Key? key,
    this.color = Colors.black,
    required this.text,
    this.size = 20,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight = FontWeight.normal,
    this.textDecoration = TextDecoration.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
          decoration: textDecoration,
          color: color,
          fontSize: size.sp,
          fontWeight: FontWeight.w400),
    );
  }
}
