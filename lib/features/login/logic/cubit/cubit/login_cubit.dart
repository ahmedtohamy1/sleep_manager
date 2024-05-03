import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sleep_manager/core/helpers/firebase_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.firebaseHelper) : super(LoginInitial());
  final FirebaseHelper firebaseHelper;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();

  login() async {
    await firebaseHelper.loginUser(
        emailController.text.trim(), passwordController.text.trim());
  }

  signup() async {
    await firebaseHelper.signUpUser(signupEmailController.text.trim(),
        signupPasswordController.text.trim());
  }

  isLoggedin() {
    return firebaseHelper.isLoggedIn();
  }
}
