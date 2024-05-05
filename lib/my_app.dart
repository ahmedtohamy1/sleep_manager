import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sleep_manager/core/helpers/firebase_helper.dart';
import 'package:sleep_manager/features/home/logic/cubit/db_cubit.dart';
import 'package:sleep_manager/features/home/logic/cubit/sleep_now_cubit.dart';
import 'package:sleep_manager/features/home/logic/cubit/wanted_time_to_wake_cubit.dart';
import 'package:sleep_manager/features/home/ui/screens/home_screen.dart';
import 'package:sleep_manager/features/login/logic/cubit/cubit/login_cubit.dart';
import 'package:sleep_manager/features/login/ui/screens/login_screen.dart';
import 'package:sleep_manager/loginorhome.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseHelper helper = FirebaseHelper();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(helper),
        ),
        BlocProvider(
          create: (context) => WantedTimeToWakeCubit(),
        ),
        BlocProvider(
          create: (context) => SleepNowCubit(),
        ),
        BlocProvider(
          create: (context) => DbCubit(helper),
        )
      ],
      child: ShadApp.material(
        debugShowCheckedModeBanner: false,
        darkTheme: ShadThemeData(
          brightness: Brightness.dark,
          colorScheme: const ShadRedColorScheme.dark(),
        ),
        themeMode: ThemeMode.dark,
        home: const LoginOrHome(),
        routes: {
          '/LoginOrHome': (context) => const LoginOrHome(),
          '/Login': (context) => const LoginScreen(),
          '/Home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
