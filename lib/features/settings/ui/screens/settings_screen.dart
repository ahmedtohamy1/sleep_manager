import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleep_manager/features/login/logic/cubit/login_cubit.dart';

import 'package:sleep_manager/features/profile/ui/screens/profile_screen.dart';
import 'package:sleep_manager/features/settings/logic/cubit/theme_mode_cubit.dart';
import 'package:sleep_manager/features/settings/ui/widgets/settings_card.dart';
import 'package:sleep_manager/loginorhome.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SettingsCard(
                logout: false,
                toggle: true,
                title: 'Profile Settings',
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
                body: 'Edit Personal Info',
                editable: true,
              ),
              SettingsCard(
                logout: false,
                toggle: true,
                title: 'App Color Mode',
                onTap: () {
                  context.read<ThemeModeCubit>().toggleTheme();
                },
                body: 'Switch between Color modes',
                editable: false,
              ),
              SettingsCard(
                logout: true,
                toggle: false,
                title: 'Log Out',
                onTap: () {
                  context.read<LoginCubit>().logout();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginOrHome(),
                    ),
                  );
                },
                body: 'Log Out from this account',
                editable: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
