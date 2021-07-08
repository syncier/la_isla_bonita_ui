import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:la_isla_Bonita_ui/app/sign_in/confirm_email_page.dart';
import 'package:la_isla_Bonita_ui/common_widgets/show_exception_alert_dialog.dart';
import 'package:provider/provider.dart';

import 'email_sign_in_bloc.dart';
import 'email_sign_in_model.dart';

class EmailSignInForm extends StatefulWidget {
  final EmailSignInBloc bloc;
  static final GlobalKey<_EmailSignInFormState> globalKey = GlobalKey();
  EmailSignInForm({@required this.bloc, Key key}): super(key: globalKey);

  static Widget create(BuildContext context) {
    final bloc = Provider.of<EmailSignInBloc>(context, listen: false);
    return EmailSignInForm(bloc: bloc);
  }

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      final user = await widget.bloc.submit();
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

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void toggleFormType() {
    widget.bloc.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
    _usernameController.clear();
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    return [
      _buildHeader(model),
      ..._buildSignUpFields(model),
      _buildEmailTextField(model),
      SizedBox(height: 8.0),
      _buildPasswordTextField(model),
    ];
  }

  TextField _buildPasswordTextField(EmailSignInModel model) {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_outline),
        labelText: 'Password',
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: widget.bloc.updatePassword,
      onEditingComplete: _submit,
    );
  }

  TextField _buildEmailTextField(EmailSignInModel model) {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 0),
        prefixIcon: Icon(Icons.mail_outline),
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: widget.bloc.updateEmail,
      onEditingComplete: () => _emailEditingComplete(model),
    );
  }

  List<Widget> _buildSignUpFields(EmailSignInModel model) {
    if (model.formType == EmailSignInFormType.register) {
      return [
        TextField(
          controller: _usernameController,
          focusNode: _usernameFocusNode,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.tag_faces_outlined),
            labelText: 'Name',
            hintText: 'Name',
            enabled: model.isLoading == false,
          ),
          autocorrect: false,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onChanged: widget.bloc.updateUsername,
          onEditingComplete: () => _emailEditingComplete(model),
        )
      ];
    }

    if (model.formType == EmailSignInFormType.signIn) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel model = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: _buildChildren(model),
          );
        });
  }

  Widget _buildHeader(EmailSignInModel model) {
    if (model.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      height: 16.0,
    );
  }
}
