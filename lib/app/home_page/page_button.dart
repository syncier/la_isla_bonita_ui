import 'package:flutter/material.dart';
import 'package:la_isla_Bonita_ui/common_widgets/custom_raised_button.dart';

class PageButton extends CustomElevatedButton {
  PageButton({
    String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) : super(
            child: Text(text,
                style: TextStyle(
                    color: textColor ?? Color(0xFFFBFCFB), fontSize: 15.0)),
            color: color ?? Color(0xFF0E6555),
            onPressed: onPressed);
}
