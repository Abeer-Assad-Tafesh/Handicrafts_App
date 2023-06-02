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
  final TextEditingController controller;
  final String? Function(String) onChanged;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;



  const AppTextFormField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.maxLines = 1,
    this.width = double.infinity,
    this.obscureText = false,
    this.textInputField = TextInputType.text,
    this.height = 55,
    required this.controller,
    required this.onChanged,
    this.validator,
    this.prefixIcon,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        maxLines: maxLines,
        keyboardType: textInputField,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          hintStyle: const TextStyle(fontSize: 12,color: Colors.grey),
          filled: true,
          fillColor: Colors.grey.shade50,
          suffixIcon: Icon(
            suffixIcon,
            color: kPrimaryColor,
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
