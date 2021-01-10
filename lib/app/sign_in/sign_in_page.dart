import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:la_isla_Bonita_ui/app/sign_in/sign_in_button.dart';
import 'package:la_isla_Bonita_ui/common_widgets/show_exception_alert_dialog.dart';
import 'package:la_isla_Bonita_ui/services/auth.dart';
import 'package:provider/provider.dart';

import 'email_sign_in_form.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;
  StreamController<bool> _isLoadingChild = StreamController();
  Stream<bool> get isLoadingChild => _isLoadingChild.stream;

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }

    showExceptionAlertDialog(context,
        title: 'Sign in failed', exception: exception);
  }

  void _signInAnonymously(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      _isLoadingChild.add(_isLoading);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInAnonymously();
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() => _isLoading = false);
      _isLoadingChild.add(_isLoading);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('Welcome!!!'),
        elevation: 2.0,
      ),
      body: _buildContent(context),
    );
  }

  BoolCallback isLoadingFromEmailForm(bool loadingState) {
    setState(() {
      _isLoading = loadingState;
    });
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            EmailSignInForm(
              isLoadingFromEmailForm: isLoadingFromEmailForm,
              isLoadingFromSignInForm: isLoadingChild,
            ),
            Text(
              'or',
              style: TextStyle(fontSize: 14, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            SignInButton(
              text: 'Go Anonymous',
              onPressed: _isLoading ? null : () => _signInAnonymously(context),
            ),
          ],
        ),
      ),
    );
  }
}
