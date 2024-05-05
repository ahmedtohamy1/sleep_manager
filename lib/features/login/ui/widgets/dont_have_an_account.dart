
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sleep_manager/features/login/ui/widgets/signup_dialog.dart';

class DontHaveAnAccount extends StatelessWidget {
  const DontHaveAnAccount({
    super.key,
    required this.signupEmailController,
    required this.signupPasswordController,
    required this.signupNameController,
    required this.signupNumberController,
  });

  final TextEditingController signupEmailController;
  final TextEditingController signupPasswordController;
  final TextEditingController signupNameController;
  final TextEditingController signupNumberController;

  @override
  Widget build(BuildContext context) {
    return ShadAlert(
      iconSrc: LucideIcons.messageCircleQuestion,
      title: const Text('Do not have an account?!'),
      description: Row(
        children: [
          const Text('Register from '),
          GestureDetector(
            onTap: () {
              Signup().SignupDialog(
                context,
                signupEmailController,
                signupPasswordController,
                signupNameController,
                signupNumberController,
              );
            },
            child: const Text(
              "here!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 22, 150, 255),
              ),
            ),
          )
        ],
      ),
    );
  }
}
