import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final Color cursorColor;
  final Color textColor;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool valid;
  final String errorText;

  const AuthTextField({
    Key? key,
    required this.controller,
    this.hintText = "",
    required this.prefixIcon,
    this.suffixIcon,
    this.cursorColor = Colors.black,
    this.textColor = Colors.white,
    this.obscureText = false,
    this.validator,
    this.valid = true,
    this.errorText = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: cursorColor,
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      autofocus: true,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w700,
        fontSize: 12.sp,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 12.sp),
        errorText: valid ? null : errorText,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: Icon(
          suffixIcon,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: 0.0),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: 0.0),
        ),
      ),
    );
  }
}
