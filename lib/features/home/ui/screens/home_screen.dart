import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sleep_manager/core/helpers/firebase_helper.dart';
import 'package:sleep_manager/features/login/logic/cubit/cubit/login_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ShadButton(
          icon: const Icon(LucideIcons.logOut),
          onPressed: () {
            context.read<LoginCubit>().logout();
          },
        ),
      ),
    );
  }
}
