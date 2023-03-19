import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {

  final String text;
  final double height;
  final double width;
  final VoidCallback onPressed;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.height = 55,
    this.width = 260
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadowColor: Colors.grey, // elevation color
          elevation: 5,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
