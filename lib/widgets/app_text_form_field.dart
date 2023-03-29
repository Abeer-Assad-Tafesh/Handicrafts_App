import 'package:flutter/material.dart';
import 'package:handcrafts/constants.dart';

class AppTextFormField extends StatelessWidget {

  final TextInputType textInputField;
  final bool obscureText;
  final IconData? suffixIcon;
  final String? hintText;
  final int maxLines;
  final double width;


  const AppTextFormField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.maxLines = 1,
    this.width = double.infinity,
    this.obscureText = false,
    this.textInputField = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: width,
      child: TextFormField(
        maxLines: maxLines,
        keyboardType: textInputField,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
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
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10));
  }
}
