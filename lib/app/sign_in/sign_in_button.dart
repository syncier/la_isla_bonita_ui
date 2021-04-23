import 'package:flutter/material.dart';
import 'package:la_isla_Bonita_ui/common_widgets/custom_raised_button.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton({
    String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) : super(
            child: Text(text,
                style: TextStyle(
                    color: textColor ?? Color(0xFFFBFCFB), fontSize: 15.0)),
            color: color ?? Color(0xFF3455C3),
            onPressed: onPressed);
}
