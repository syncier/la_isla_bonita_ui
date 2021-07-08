import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:la_isla_Bonita_ui/app/sign_in/email_sign_in_bloc.dart';
import 'package:la_isla_Bonita_ui/app/sign_in/email_sign_in_form.dart';
import 'package:la_isla_Bonita_ui/app/sign_in/sign_in_manager.dart';
import 'package:la_isla_Bonita_ui/common_widgets/show_exception_alert_dialog.dart';
import 'package:la_isla_Bonita_ui/services/auth.dart';
import 'package:provider/provider.dart';

import 'confirm_email_page.dart';
import 'email_sign_in_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage(
      {Key key,
      @required this.manager,
      @required this.isLoading,
      @required this.bloc})
      : super(key: key);
  final SignInManager manager;
  final bool isLoading;

  final EmailSignInBloc bloc;
  static const Key emailPasswordKey = Key('email-password');

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final emailBlocProvider =
        (ValueNotifier<bool> isLoading, SignInManager manager) =>
            Provider<EmailSignInBloc>(
                create: (_) => EmailSignInBloc(auth: auth),
                dispose: (_, bloc) => bloc.dispose(),
                child: Consumer<EmailSignInBloc>(
                    builder: (_, bloc, __) => SignInPage(
                          manager: manager,
                          isLoading: isLoading.value,
                          bloc: bloc,
                        )));

    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (_, manager, __) => emailBlocProvider(isLoading, manager),
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

  Future<void> _submit(BuildContext context) async {
    try {
      final user = await bloc.submit();
      if (user != null && user.emailVerified) {
        Navigator.pop(context);
      } else {
        Navigator.pushReplacementNamed(context, ConfirmEmail.id);
      }
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Sign in failed',
        exception: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel model = snapshot.data;

          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: Text('Hi there, \nWelcome'),
              toolbarHeight: 80.0,
            ),
            body: _buildContent(context, model),
            floatingActionButton: FloatingActionButton(
              onPressed: model.canSubmit ? () => _submit(context) : null,
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              backgroundColor: Color(0xFF3455C3),
            ),
          );
        });
  }

  Widget _buildContent(BuildContext context, EmailSignInModel model) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            EmailSignInForm.create(context),
            Spacer(),
            Text(
              'Or sign up with',
              style: TextStyle(fontSize: 14, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RawMaterialButton(
                  onPressed:
                      isLoading ? null : () => _signInWithGoogle(context),
                  fillColor: Color(0xFFE2E6FB),
                  child: SvgPicture.asset("assets/images/google.svg"),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
                RawMaterialButton(
                  onPressed:
                      isLoading ? null : () => _signInWithFacebook(context),
                  fillColor: Color(0xFFE2E6FB),
                  child: SvgPicture.asset(
                    "assets/images/facebook.svg",
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            TextButton(
              child: Text(model.secondaryButtonText),

              onPressed: !model.isLoading
                  ? EmailSignInForm.globalKey.currentState?.toggleFormType
                  : null,
            )
          ],
        ),
      ),
    );
  }
}
