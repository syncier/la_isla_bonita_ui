import 'package:flutter/material.dart';
import 'package:la_isla_Bonita_ui/common_widgets/show_alert_dialog.dart';
import 'package:la_isla_Bonita_ui/services/auth.dart';
import 'package:provider/provider.dart';

class AppFeedPage extends StatelessWidget {
  void _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
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
    );
  }
}
