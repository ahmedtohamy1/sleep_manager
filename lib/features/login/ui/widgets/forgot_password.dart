import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sleep_manager/features/login/ui/widgets/forgot_password_dialog.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
    required this.forgotPasswordEmailController,
  });

  final TextEditingController forgotPasswordEmailController;

  @override
  Widget build(BuildContext context) {
    return ShadAlert(
      iconSrc: LucideIcons.refreshCcwDot,
      title: const Text('Forgot Password?!'),
      description: Row(
        children: [
          const Text('Reset Password from '),
          GestureDetector(
            onTap: () {
              ForgotPasswordWidget()
                  .ForgotPasswordDialog(context, forgotPasswordEmailController);
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
