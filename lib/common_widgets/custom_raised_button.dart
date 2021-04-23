import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        child: child,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)))),
        ),
        onPressed: onPressed,
      ),
    );
  }

  CustomElevatedButton(
      {this.child,
      this.color: const Color(0xFF3455C3),
      this.borderRadius: 8.0,
      this.height: 50.0,
      this.onPressed});
}
