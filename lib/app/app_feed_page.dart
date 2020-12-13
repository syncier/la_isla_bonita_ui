import 'package:flutter/material.dart';
import 'package:la_isla_Bonita_ui/services/auth.dart';

class AppFeedPage extends StatelessWidget {
  const AppFeedPage({Key key, @required this.auth})
      : super(key: key);
  final AuthBase auth;

  void _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
        actions: [
          FlatButton(
              onPressed: _signOut,
              child: Text(
                'Log out',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ))
        ],
      ),
    );
  }
}
