import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:la_isla_Bonita_ui/app/home_page/home_page.dart';
import 'package:la_isla_Bonita_ui/app/landing_page.dart';
import 'package:la_isla_Bonita_ui/services/auth.dart';
import 'package:la_isla_Bonita_ui/themes/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        '/sign-in': (context) => LandingPage(auth: Auth()),
      },
    );
  }
}
