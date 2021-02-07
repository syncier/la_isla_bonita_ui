import 'package:flutter/material.dart';
import 'package:la_isla_Bonita_ui/app/act_page/act_page.dart';
import 'package:la_isla_Bonita_ui/app/daily_page/daily_page.dart';
import 'package:la_isla_Bonita_ui/app/profile_page/profile_page.dart';
import 'package:la_isla_Bonita_ui/services/auth.dart';
import 'package:provider/provider.dart';

class AppFeedPage extends StatefulWidget {
  @override
  _AppFeedPageState createState() => _AppFeedPageState();
}

class _AppFeedPageState extends State<AppFeedPage> {
  int _selectedIndex = 0;

  List<Widget> _navList = <Widget>[
    DailyPage(),
    ActPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _navList.elementAt(_selectedIndex)),
      bottomNavigationBar: SizedBox(
        height: 72.0,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_sunny_outlined),
              label: 'Daily',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_border),
              label: 'Act',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.face_outlined),
              label: 'Profile',
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
