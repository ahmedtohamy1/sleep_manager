// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sleep_manager/features/login/ui/widgets/dont_have_an_account.dart';
import 'package:sleep_manager/features/login/ui/widgets/forgot_password.dart';
import 'package:sleep_manager/features/login/ui/widgets/login_button.dart';
import 'package:sleep_manager/features/login/ui/widgets/email_password_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController signupEmailController;
  late TextEditingController signupPasswordController;
  late TextEditingController forgotPasswordEmailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    forgotPasswordEmailController = TextEditingController();
    signupEmailController = TextEditingController();
    signupPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: const [
                  Text(
                    'Welcome back! ',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              EmailPasswordForm(
                  emailController: emailController,
                  passwordController: passwordController),
              SizedBox(
                height: 16,
              ),
              LoginButton(
                emailController: emailController,
                passwordController: passwordController,
              ),
              SizedBox(
                height: 16,
              ),
              DontHaveAnAccount(
                  signupEmailController: signupEmailController,
                  signupPasswordController: signupPasswordController),
              SizedBox(
                height: 16,
              ),
              ForgotPassword(
                forgotPasswordEmailController: forgotPasswordEmailController,
              )
            ],
          ),
        ),
      ),
    );
  }
}
