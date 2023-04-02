import 'package:flutter/material.dart';
import 'package:handcrafts/constants.dart';

class AppTextFormField extends StatelessWidget {

  final TextInputType textInputField;
  final bool obscureText;
  final IconData? suffixIcon;
  final String? hintText;
  final int maxLines;
  final double width;
  final double height;


  const AppTextFormField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.maxLines = 1,
    this.width = double.infinity,
    this.obscureText = false,
    this.textInputField = TextInputType.text,
    this.height = 55,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        maxLines: maxLines,
        keyboardType: textInputField,
        obscureText: obscureText,
        // style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 12,color: Colors.grey),
          filled: true,
          fillColor: Colors.grey.shade50,
          suffixIcon: Icon(
            suffixIcon,
            color: kDefaultColor,
          ),
          enabledBorder: getBorder(),
          disabledBorder: getBorder(),
          focusedBorder: getBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder getBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey.shade200,
        ),
        borderRadius: BorderRadius.circular(10));
  }
}
