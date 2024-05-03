import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sleep_manager/features/login/logic/cubit/cubit/login_cubit.dart';

class Signup {
  Future<dynamic> SignupDialog(
    BuildContext context,
    TextEditingController emailContrlr,
    TextEditingController passContrlr,
  ) {
    return showShadDialog(
      context: context,
      builder: (context) => ShadDialog(
        title: const Text('SignUp New User'),
        description: const Text("Make new account in app."),
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Password',
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: ShadInput(
                        controller: passContrlr,
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
              context.read<LoginCubit>().signup();
              Navigator.of(context).pop();
              emailContrlr.clear();
              passContrlr.clear();
            },
          )
        ],
      ),
    );
  }
}

final signup = [
  (
    title: 'Email',
    value: '',
  ),
  (
    title: 'Password',
    value: '',
  ),
  (title: 'ReEnter Password', value: ''),
];
