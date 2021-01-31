import 'package:flutter/material.dart';
import 'package:la_isla_Bonita_ui/app/inspire/inspire_page.dart';
import 'package:la_isla_Bonita_ui/common_widgets/show_alert_dialog.dart';
import 'package:la_isla_Bonita_ui/services/auth.dart';
import 'package:provider/provider.dart';

class AppFeedPage extends StatefulWidget {
  @override
  _AppFeedPageState createState() => _AppFeedPageState();
}

class _AppFeedPageState extends State<AppFeedPage> {
  void _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    InspirePage(),
    Text(
      'Index 1: Projects',
      style: optionStyle,
    ),
    Text(
      'Index 2: Advice',
      style: optionStyle,
    ),
    Text(
      'Index 3: Community',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    );
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
        actions: [
          FlatButton(
              onPressed: () => _confirmSignOut(context),
              child: Text(
                'Log out',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ))
        ],
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: SizedBox(
        height: 72.0,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_sunny_outlined),
              label: 'Inspire',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              label: 'Projects',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined),
              label: 'Advice',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle_outlined),
              label: 'Community',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.grey[400],
          selectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          selectedIconTheme: IconThemeData(size: 30.0),
          unselectedIconTheme: IconThemeData(size: 30.0),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
