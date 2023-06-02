import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  TextOverflow overflow;
  FontWeight fontWeight;


  SmallText(
      {Key? key,
      this.color = Colors.black,
      required this.text,
      this.size = 11,
      this.height = 1.2,
      this.overflow = TextOverflow.ellipsis,
        this.fontWeight = FontWeight.normal,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        height: height,
        fontFamily: 'Roboto',
      ),
    );
  }
}
