import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sleep_manager/features/login/logic/cubit/login_cubit.dart';

class ForgotPasswordWidget {
  Future<dynamic> ForgotPasswordDialog(
    BuildContext context,
    TextEditingController emailContrlr,
  ) {
    return showShadDialog(
      context: context,
      builder: (context) => ShadDialog(
        title: const Text('Reset Your Password'),
        // description: const Text("Make new account in app."),
        content: Container(
          width: 375,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Email',
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: ShadInput(
                        controller: emailContrlr,
                      ),
                    ),
                  ],
                ),
              ]),
        ),
        actions: [
          ShadButton(
            text: const Text('Save changes'),
            onPressed: () {
              context.read<LoginCubit>().forgotPassword(emailContrlr.text);
              Navigator.of(context).pop();
              emailContrlr.clear();
            },
          )
        ],
      ),
    );
  }
}

final ForgotPasswordMap = [
  (
    title: 'Email',
    value: '',
  ),
];
