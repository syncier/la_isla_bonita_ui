import 'package:flutter/material.dart';

class ActPage extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

  int _selectedValue = 0;

  final chipsArray = [
    'Food',
    'Mobility',
    'Plastic',
    'Zero-Waste',
    'Ocean',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        SizedBox(
          height: 40,
        ),
        Text(
          'Act',
          style: optionStyle,
        ),
        Padding(
          padding:
              EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0.0, top: 8.0),
          child: SizedBox(
            height: 42.0,
            child: ListView(
              primary: true,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Wrap(
                  spacing: 4.0,
                  runSpacing: 0.0,
                  children: List<Widget>.generate(
                      chipsArray.length, // place the length of the array here
                      (int index) {
                    return ChoiceChip(
                      label: Text(chipsArray[index],
                          style:
                              TextStyle(color: Colors.black, fontSize: 16.0)),
                      selected: _selectedValue == index,
                      selectedColor: Color(0xFF4FEAA9),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
