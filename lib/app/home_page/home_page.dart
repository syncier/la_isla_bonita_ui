import 'package:flutter/material.dart';
import 'package:la_isla_Bonita_ui/app/home_page/page_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Isla Bonita Pages'),
        elevation: 2.0,
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Home page',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 48.0),
          PageButton(
            text: 'Sign in page',
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/sign-in');
            },
          ),
          SizedBox(height: 16.0),
          PageButton(
            text: 'Another page',
            onPressed: () {},
          ),
          SizedBox(height: 16.0),
          PageButton(
            text: 'Again, another page',
            onPressed: () {},
          ),
          SizedBox(height: 16.0),
          PageButton(
            text: 'One more page',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
