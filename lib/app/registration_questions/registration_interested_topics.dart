import 'package:flutter/material.dart';

class RegistrationInterestedTopicsPage extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold);

  int _selectedValue = 0;

  final chipsArray = [
    '🛍 Plastic Pollution',
    '🥖 Food Waste',
    '🐝 Biodiversity',
    '🌲 Deforestation',
    '💨 Air Pollution',
    '💧 Water Pollution'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SizedBox(
        height: 40,
      ),
      Text(
        'What are you interested in?',
        style: optionStyle,
      ),
      Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0.0, top: 8.0),
        child: SizedBox(
          height: 42.0,
          child: Wrap(
            spacing: 4.0,
            runSpacing: 0.0,
            children: List<Widget>.generate(
                chipsArray.length, // place the length of the array here
                (int index) {
              return ChoiceChip(
                label: Text(chipsArray[index],
                    style: TextStyle(color: Color(0xFF545868), fontSize: 16.0)),
                selected: _selectedValue == index,
                backgroundColor: Color(0xFFF3F5FD),
                selectedColor: Color(0xFFD3D5FD),
                onSelected: (_) {},
              );
            }).toList(),
          ),
        ),
      ),
    ]);
  }
}
