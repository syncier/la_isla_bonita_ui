import 'package:flutter/material.dart';
import 'package:la_isla_Bonita_ui/common_widgets/registration_slider.dart';

class RegistrationQuestionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 64.0,),
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              'How much do you know about sustainability?',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 26.0),
            ),
          ),
          RegistrationSlider(
            leftLabel: 'Beginner',
            rightLabel: 'Expert',
            onChanged: (value) {},
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, top: 38.0),
            child: Text(
              'How sustainable do you think you live?',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 26.0),
            ),
          ),
          RegistrationSlider(
            leftLabel: 'not at all',
            rightLabel: 'all in',
            onChanged: (value) {},
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, top: 38.0),
            child: Text(
              'How much would you like to improve your life style to be more sustainable?',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 26.0),
            ),
          ),
          RegistrationSlider(
            leftLabel: 'not much',
            rightLabel: 'very much',
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
