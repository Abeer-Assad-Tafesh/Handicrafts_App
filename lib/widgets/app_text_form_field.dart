import 'package:flutter/material.dart';
import 'package:handcrafts/constants.dart';

class AppTextFormField extends StatelessWidget {

  final TextInputType textInputField;
  final bool obscureText;
  final IconData? suffixIcon;
  final String? hintText;

  const AppTextFormField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.textInputField = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        maxLines: 1,
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
