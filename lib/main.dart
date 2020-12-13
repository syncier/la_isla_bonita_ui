import 'package:flutter/material.dart';
import 'package:la_isla_Bonita_ui/home_page/home_page.dart';
import 'package:la_isla_Bonita_ui/sign_in/sign_in_page.dart';
import 'package:la_isla_Bonita_ui/themes/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La Isla Bonita',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/sign-in': (context) => SignInPage(),
      },
    );
  }
}

