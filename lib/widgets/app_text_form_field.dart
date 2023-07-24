import 'package:flutter/material.dart';
import 'package:handcrafts/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
  final bool enabled;



  const AppTextFormField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.maxLines = 1,
    this.width = double.infinity,
    this.obscureText = false,
    this.textInputField = TextInputType.text,
    this.height = 60,
    required this.controller,
    required this.onChanged,
    this.validator,
    this.prefixIcon,
    this.enabled = true,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width.w,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        maxLines: maxLines,
        keyboardType: textInputField,
        obscureText: obscureText,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        enabled: enabled,
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          contentPadding: const EdgeInsets.only(bottom: 15.0,left: 5,right: 5), // Apply padding at the bottom
          hintStyle: TextStyle(fontSize: 12.sp,color: Colors.grey),
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
        borderRadius: BorderRadius.circular(10).r);
  }
}
