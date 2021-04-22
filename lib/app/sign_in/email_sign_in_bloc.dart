import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:la_isla_Bonita_ui/services/auth.dart';
import 'package:rxdart/rxdart.dart';

import 'email_sign_in_model.dart';

class EmailSignInBloc {
  EmailSignInBloc({@required this.auth});
  final AuthBase auth;

  final _modelSubject =
      BehaviorSubject<EmailSignInModel>.seeded(EmailSignInModel());
  Stream<EmailSignInModel> get modelStream => _modelSubject.stream;
  EmailSignInModel get _model => _modelSubject.value;

  void dispose() {
    _modelSubject.close();
  }

  FutureOr<User> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        final user = await auth.createUserWithEmailAndPassword(
            email: _model.email,
            password: _model.password,
            username: _model.username);
        // user.sendEmailVerification().then((_) {}).catchError((e) {
        //   print(e);
        // });
        // Error occurred. Inspect error.code.
        return user;
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void toggleFormType() {
    final formType = _model.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
      email: '',
      password: '',
      username: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  void updateUsername(String username) => updateWith(username: username);

  void updateWith({
    String email,
    String password,
    String username,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    _modelSubject.value = _model.copyWith(
      email: email,
      password: password,
      username: username,
      formType: formType,
      isLoading: isLoading,
      submitted: submitted,
    );
  }
}
