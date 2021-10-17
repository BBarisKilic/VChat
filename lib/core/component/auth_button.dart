import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final Color buttonColor;
  final Color borderColor;
  final double fontSize;

  const AuthButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.textColor,
      required this.buttonColor,
      required this.borderColor,
      this.fontSize = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 20.0),
        ),
        side: MaterialStateProperty.all(
          BorderSide(color: borderColor),
        ),
        backgroundColor: MaterialStateProperty.all(buttonColor),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
