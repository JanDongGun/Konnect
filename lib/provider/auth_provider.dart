import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/navigation_service.dart';
import '../services/snackbar_service.dart';

enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotfound,
  Error,
}

enum EmailStatus {
  Sending,
  Sended,
  Error,
}

class AuthProvider extends ChangeNotifier {
  User user;
  AuthStatus status;
  EmailStatus emailStatus;
  FirebaseAuth _auth;

  static AuthProvider instance = AuthProvider();

  AuthProvider() {
    _auth = FirebaseAuth.instance;
  }

  void loginUserWithEmailAndPassword(String _email, String _password) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      UserCredential _result = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);

      user = _result.user;
      status = AuthStatus.Authenticated;
      SnackBarSv.instance.showSnackbarSuccess("Welcome, ${user.email}");
      NavigationService.instance.navigateToReplacement("homepage");
    } catch (e) {
      status = AuthStatus.Error;
      if (e.code == 'invalid-email') {
        SnackBarSv.instance.showSnackbarError("invalid email");
      } else if (e.code == 'user-not-found') {
        SnackBarSv.instance.showSnackbarError("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        SnackBarSv.instance
            .showSnackbarError("Wrong password provided for that user.");
      }
    }
    notifyListeners();
  }

  void sendPasswordResetMail(String _email) async {
    notifyListeners();
    try {
      await _auth.sendPasswordResetEmail(email: _email);
      status = AuthStatus.Authenticated;
      NavigationService.instance.navigateToReplacement("checkmail");
    } catch (e) {
      print(e);
      status = AuthStatus.Error;
      if (e.code == 'user-not-found') {
        SnackBarSv.instance.showSnackbarError("Email not found");
      } else if (e.code == 'invalid-email') {
        SnackBarSv.instance.showSnackbarError("invalid email");
      }
    }
    notifyListeners();
  }

  void regisUserWithEmailAndPassword(String _email, String _password,
      Future<void> onSuccess(String _uid)) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      UserCredential _result = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);

      user = _result.user;
      status = AuthStatus.Authenticated;
      await onSuccess(user.uid);
    } catch (e) {
      status = AuthStatus.Error;
      user = null;
      SnackBarSv.instance.showSnackbarError("Error Registering User");
    }
    notifyListeners();
  }

  void logoutUser(Future<void> onSuccess()) async {
    try {
      await _auth.signOut();
      user = null;
      status = AuthStatus.NotAuthenticated;
      await onSuccess();
      await NavigationService.instance.navigateToReplacement('login');
      SnackBarSv.instance.showSnackbarSuccess('Logged out successfully');
    } catch (e) {
      SnackBarSv.instance.showSnackbarSuccess('Logged out error');
    }
  }
}
