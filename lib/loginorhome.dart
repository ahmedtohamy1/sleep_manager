import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:sleep_manager/core/helpers/auth_helper.dart';
import 'package:sleep_manager/core/helpers/firebase_helper.dart';
import 'package:sleep_manager/features/home/ui/screens/home_screen.dart';
import 'package:sleep_manager/features/login/ui/screens/login_screen.dart';

class LoginOrHome extends StatelessWidget {
  const LoginOrHome({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseHelper().auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            // there is no user
            return const LoginScreen();
          } else {
            // there is a user
            authenticate().then((authenticated) {
              if (authenticated) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }
            });
            return const SizedBox();
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
