import 'package:flutter/material.dart';

class RegistrationSlider extends StatefulWidget {
  final int divisions;
  final SliderCallback onChanged;
  final String leftLabel;
  final String rightLabel;

  const RegistrationSlider(
      {Key key,
      this.divisions: 4,
      this.onChanged,
      this.leftLabel: '',
      this.rightLabel: ''})
      : super(key: key);

  @override
  _RegistrationSliderState createState() => _RegistrationSliderState();
}

class _RegistrationSliderState extends State<RegistrationSlider> {
  double _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: _currentSliderValue,
          min: 0,
          max: 100,
          divisions: widget.divisions,
          activeColor: Color(0xFF3455C3),
          inactiveColor: Color(0xFFE2E6FB),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
              widget.onChanged(value);
            });
          },
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.leftLabel,
                style: TextStyle(fontSize: 12.0),
              ),
              Text(
                widget.rightLabel,
                style: TextStyle(fontSize: 12.0),
              )
            ],
          ),
        ),
      ],
    );
  }
}

typedef SliderCallback = void Function(double);
