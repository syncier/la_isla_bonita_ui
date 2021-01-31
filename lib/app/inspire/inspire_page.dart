import 'package:flutter/material.dart';

class InspirePage extends StatefulWidget {
  @override
  _InspirePageState createState() => _InspirePageState();
}

class _InspirePageState extends State<InspirePage> {
  int _selectedValue = 0;

  final array = [
    'Food',
    'Mobility',
    'Plastic',
    'Zero-Waste',
    'Option 5',
    'Option 6'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                      array.length, // place the length of the array here
                      (int index) {
                    return ChoiceChip(
                      label: Text(array[index],
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
        Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.network(
            'https://placeimg.com/720/960/any',
            fit: BoxFit.fill,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 3,
          margin: EdgeInsets.all(10),
        ),
      ],
    );
  }
}
