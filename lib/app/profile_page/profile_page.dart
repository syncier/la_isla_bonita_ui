import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:la_isla_Bonita_ui/app/sign_in/sign_in_page.dart';
import 'package:la_isla_Bonita_ui/common_widgets/show_alert_dialog.dart';
import 'package:la_isla_Bonita_ui/services/auth.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

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
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          List<Widget> signInButton = [CircularProgressIndicator()];
          if (snapshot.connectionState == ConnectionState.active) {
            final User user = snapshot.data;
            if (user == null) {
              signInButton = [
                Text('Guest',
                    style: TextStyle(
                      fontSize: 18,
                    )),
                ElevatedButton(
                    onPressed: () => _openSignIn(context),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ))
              ];
            } else {
              signInButton = [
                Text(user.displayName ?? "Anonymous",
                    style: TextStyle(
                      fontSize: 18,
                    )),
                ElevatedButton(
                    onPressed: () => _confirmSignOut(context),
                    child: Text(
                      'Log out',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ))
              ];
            }
          }
          return Center(
            child: Column(children: [
              SizedBox(
                height: 40.0,
              ),
              Text(
                'Index 2: Profile',
                style: optionStyle,
              ),
              ...signInButton,
            ]),
          );
        });
  }

  void _openSignIn(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return SignInPage.create(context);
    }));
  }
}
