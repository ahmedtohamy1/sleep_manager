import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sleep_manager/core/helpers/firebase_helper.dart';
import 'package:sleep_manager/features/home/ui/screens/home_screen.dart';
import 'package:sleep_manager/features/login/logic/cubit/cubit/login_cubit.dart';
import 'package:sleep_manager/features/login/ui/screens/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseHelper helper = FirebaseHelper();
    return BlocProvider(
      create: (context) => LoginCubit(helper),
      child: ShadApp.material(
        debugShowCheckedModeBanner: false,
        darkTheme: ShadThemeData(
          brightness: Brightness.dark,
          colorScheme: const ShadRedColorScheme.dark(),
        ),
        themeMode: ThemeMode.dark,
        home: const Scaffold(
          body: Center(
            child: Text('Hello World!'),
          ),
        ),
        initialRoute: '/Login',
        routes: {
          '/Login': (context) => LoginScreen(),
          '/Home': (context) => HomeScreen(),
        },
      ),
    );
  }
}
