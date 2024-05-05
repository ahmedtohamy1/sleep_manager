import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sleep_manager/core/helpers/firebase_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.firebaseHelper) : super(LoginInitial());
  final FirebaseHelper firebaseHelper;

  login(String Email, String Password) async {
    await firebaseHelper.loginUser(Email.trim(), Password.trim());
    await firebaseHelper.addDocSleepNow("");
    await firebaseHelper.addDocWakeAt("");
  }

  signup(String Email, String Password) async {
    await firebaseHelper.signUpUser(Email.trim(), Password.trim());
  }

  // log out
  logout() async {
    await firebaseHelper.logout();
  }

  isLoggedin() {
    return firebaseHelper.isLoggedIn();
  }

  // forgot password
  forgotPassword(String email) async {
    await firebaseHelper.forgotPassword(email.trim());
  }
}
