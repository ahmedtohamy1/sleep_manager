// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sleep_manager/features/login/logic/cubit/cubit/login_cubit.dart';
import 'package:sleep_manager/features/login/ui/widgets/my_input_field.dart';
import 'package:sleep_manager/features/login/ui/widgets/signup_dialog.dart';

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

  @override
  void initState() {
    super.initState();
    emailController = context.read<LoginCubit>().emailController;
    passwordController = context.read<LoginCubit>().passwordController;

    signupEmailController = context.read<LoginCubit>().signupEmailController;
    signupPasswordController =
        context.read<LoginCubit>().signupPasswordController;
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
              MyInputField(
                  controller: emailController,
                  id: 'email',
                  hint: 'Enter Your Email',
                  label: 'Email',
                  isObscure: false),
              MyInputField(
                controller: passwordController,
                id: 'password',
                hint: 'Enter Your Password',
                label: 'Password',
                isObscure: true,
              ),
              SizedBox(
                height: 16,
              ),
              ShadButton(
                size: ShadButtonSize.lg,
                text: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                onPressed: () {
                  context.read<LoginCubit>().login();
                  emailController.clear();
                  passwordController.clear();
                  context.read<LoginCubit>().isLoggedin()
                      ? Navigator.pushNamed(context, '/Home')
                      : null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              ShadAlert(
                iconSrc: LucideIcons.messageCircleQuestion,
                title: Text('Do not have an account?!'),
                description: Row(
                  children: [
                    Text('Register from '),
                    GestureDetector(
                      onTap: () {
                        Signup().SignupDialog(context, signupEmailController,
                            signupPasswordController);
                      },
                      child: Text(
                        "here!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 22, 150, 255),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ShadAlert(
                iconSrc: LucideIcons.refreshCcwDot,
                title: Text('Forgot Password?!'),
                description: Row(
                  children: [
                    Text('Reset Password from '),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "here!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 22, 150, 255),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
