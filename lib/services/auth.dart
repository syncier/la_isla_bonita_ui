import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User get currentUser;
  Stream<User> authStateChanges();
  Future<User> signInAnonymously();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createUserWithEmailAndPassword(
      {String email, String password, String username});

  Future<User> signInWithGoogle();

  Future<User> signInWithFacebook();

  Future<void> signOut();

  Future<void> resendEmail();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User> authStateChanges() => _firebaseAuth.userChanges();

  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithCredential(
        EmailAuthProvider.credential(email: email, password: password));
    return userCredential.user;
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      {String email, String password, String username}) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = userCredential.user;
    await user.updateProfile(displayName: username);
    await user.sendEmailVerification();

    return user;
  }

  @override
  Future<User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  Future<User> signInWithFacebook() async {
    try {
      final AccessToken accessToken = await FacebookAuth.instance.login();

      final FacebookAuthCredential credential = FacebookAuthProvider.credential(
        accessToken.token,
      );
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } on FacebookAuthException catch (e) {
      // handle the FacebookAuthException
      throw FirebaseAuthException(
        code: e.errorCode,
        message: e.message,
      );
    } finally {}
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        return userCredential.user;
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: 'Missing Google ID Token',
        );
      }
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> resendEmail() async {
    final currentUser = await _firebaseAuth.currentUser;
    return await currentUser.sendEmailVerification();
  }
}
