import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {

  final String text;
  final double height;
  final double width;
  final VoidCallback? onPressed;
  final Color color;

  const AppButton({
    super.key,
    this.onPressed,
    required this.text,
    this.height = 55,
    this.width = 260,
    this.color = const Color(0xff457C77)
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width.w,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: color,
          disabledForegroundColor: color,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10).r,
          ),
          shadowColor: Colors.grey, // elevation color
          elevation: 5,
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16.sp, color: Colors.white),
        ),
      ),
    );
  }
}
