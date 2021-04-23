import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:la_isla_Bonita_ui/app/sign_in/email_sign_in_form.dart';
import 'package:la_isla_Bonita_ui/app/sign_in/sign_in_button.dart';
import 'package:la_isla_Bonita_ui/app/sign_in/sign_in_manager.dart';
import 'package:la_isla_Bonita_ui/common_widgets/show_exception_alert_dialog.dart';
import 'package:la_isla_Bonita_ui/services/auth.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key key,
    @required this.manager,
    @required this.isLoading,
  }) : super(key: key);
  final SignInManager manager;
  final bool isLoading;

  static const Key emailPasswordKey = Key('email-password');

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (_, manager, __) =>
                SignInPage(manager: manager, isLoading: isLoading.value),
          ),
        ),
      ),
    );
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }

    showExceptionAlertDialog(context,
        title: 'Sign in failed', exception: exception);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await manager.signInAnonymously();
      Navigator.pop(context);
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
      Navigator.pop(context);
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await manager.signInWithFacebook();
      Navigator.pop(context);
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Hi there, \nWelcome'),
        toolbarHeight: 80.0,
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            EmailSignInForm.create(context),
            Text(
              'or',
              style: TextStyle(fontSize: 14, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            SignInButton(
              text: 'Go Anonymous',
              onPressed: isLoading ? null : () => _signInAnonymously(context),
            ),
            SizedBox(height: 8.0),
            SignInButton(
              text: 'Sign in with Google',
              onPressed: isLoading ? null : () => _signInWithGoogle(context),
            ),
            SizedBox(height: 8.0),
            SignInButton(
              text: 'Sign in with Facebook',
              onPressed: isLoading ? null : () => _signInWithFacebook(context),
            ),
          ],
        ),
      ),
    );
  }
}
