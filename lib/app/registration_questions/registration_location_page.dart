import 'package:flutter/material.dart';

class RegistrationLocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 64.0,
        ),
        Text(
          'In which city do you live?',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 26.0),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16.0, bottom: 32.0),
          child: Text(
            'We’re asking in order show you tailored news and challenges on our app.',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }
}
