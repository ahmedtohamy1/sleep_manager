import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sleep_manager/features/login/logic/cubit/login_cubit.dart';
import 'package:sleep_manager/features/login/ui/widgets/dont_have_an_account.dart';
import 'package:sleep_manager/features/login/ui/widgets/forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController signupEmailController;
  late TextEditingController signupPasswordController;
  late TextEditingController signupNameController;
  late TextEditingController signupNumberController;
  late TextEditingController forgotPasswordEmailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    forgotPasswordEmailController = TextEditingController();
    signupEmailController = TextEditingController();
    signupPasswordController = TextEditingController();
    signupNameController = TextEditingController();
    signupNumberController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    forgotPasswordEmailController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    signupNameController.dispose();
    signupNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  children: [
                    Text(
                      'Welcome back! ',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                ShadInputFormField(
                  controller: emailController,
                  description: const Text("Enter Your Email Address"),
                  label: const Text("Email Address"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!isValidEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                ShadInputFormField(
                  controller: passwordController,
                  description: const Text("Enter Your Password"),
                  label: const Text("Password"),
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                ShadButton(
                  width: double.infinity - 50,
                  size: ShadButtonSize.lg,
                  text: const Text('Login'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<LoginCubit>().login(
                            emailController.text,
                            passwordController.text,
                          );
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                DontHaveAnAccount(
                  signupEmailController: signupEmailController,
                  signupPasswordController: signupPasswordController,
                  signupNameController: signupNameController,
                  signupNumberController: signupNumberController,
                ),
                const SizedBox(
                  height: 16,
                ),
                ForgotPassword(
                  forgotPasswordEmailController: forgotPasswordEmailController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }
}
