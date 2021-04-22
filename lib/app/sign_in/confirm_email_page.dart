import 'package:flutter/material.dart';

class ConfirmEmail extends StatelessWidget {
  static const id = 'confirm-email';

  const ConfirmEmail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Center(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                'You received mail from us',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 32,),
              ),
            )),
      ),
    );
  }
}