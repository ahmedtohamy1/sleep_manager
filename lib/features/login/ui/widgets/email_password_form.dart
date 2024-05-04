import 'package:flutter/material.dart';
import 'package:sleep_manager/features/login/ui/widgets/my_input_field.dart';

class EmailPasswordForm extends StatelessWidget {
  const EmailPasswordForm(
      {super.key,
      required this.emailController,
      required this.passwordController});

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}
