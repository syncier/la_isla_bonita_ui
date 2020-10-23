import 'package:flutter/material.dart';
import 'package:la_isla_Bonita_ui/home_page/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La Isla Bonita',
      theme: ThemeData(
          primarySwatch: Colors.green
      ),
      home: HomePage(),
    );
  }
}

