import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sleep_manager/features/login/logic/cubit/cubit/login_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
    required void Function() onPressed,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return ShadButton(
      size: ShadButtonSize.lg,
      text: const Text(
        'Login',
        style: TextStyle(
          fontSize: 17,
        ),
      ),
      onPressed: () {
        context
            .read<LoginCubit>()
            .login(emailController.text, passwordController.text);
      },
    );
  }
}
