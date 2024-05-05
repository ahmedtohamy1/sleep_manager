import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sleep_manager/features/home/logic/cubit/db_cubit.dart';
import 'package:sleep_manager/features/home/logic/cubit/sleep_now_cubit.dart';
import 'package:sleep_manager/features/home/logic/cubit/wanted_time_to_wake_cubit.dart';
import 'package:sleep_manager/features/home/ui/widgets/avatar_name_advice.dart';
import 'package:sleep_manager/features/home/ui/widgets/goal_container.dart';
import 'package:sleep_manager/features/home/ui/widgets/home_tile.dart';
import 'package:url_launcher/url_launcher.dart';

extension DateTimeExtension on DateTime {
  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Uri url = Uri.parse('https://www.sleepfoundation.org/stages-of-sleep');

  Future<void> openUrl() async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  late String wantedTimeTowake;

  Future<void> updateTimes() async {
    final times = await context.read<DbCubit>().getSleepAndWakeTimes();

    context
        .read<SleepNowCubit>()
        .setTimeFirebase(times['SleepNow'] ?? 'Not set');
    context
        .read<WantedTimeToWakeCubit>()
        .setTimeFirebase(times['wakeAtTime'] ?? 'Not set');
  }

  @override
  void initState() {
    wantedTimeTowake = context.read<WantedTimeToWakeCubit>().state;
    updateTimes();
    super.initState();
  }

  void wakeAt() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        context.read<WantedTimeToWakeCubit>().setWantedTimeToWake(value);
        context.read<DbCubit>().updateWakeTime(
            DateFormat.jm().format(DateTime.now().applied(value)));
        print(context.read<WantedTimeToWakeCubit>().state);
        ShadToaster.of(context).show(
          ShadToast(
            title: const Text('Picked The Time You Wanted Succesfully '),
            description: Text(
                'Picked time is: ${context.read<WantedTimeToWakeCubit>().state}'),
          ),
        );
      }
    });

    print(context.read<WantedTimeToWakeCubit>().state);
  }

  void sleepNow() {
    context.read<SleepNowCubit>().setSleepNowTime();
    context.read<DbCubit>().updateSleepTime(
        DateFormat.jm().format(DateTime.now().applied(TimeOfDay.now())));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const AvatarNameAdvice(),
          const SizedBox(
            height: 20,
          ),
          const GoalContainer(),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10),
                  child: HomeTile(
                    onTap: () {
                      sleepNow();
                      print(context.read<SleepNowCubit>().state);
                    },
                    icon: LucideIcons.bed,
                    title: 'Sleep Now',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 10),
                  child: HomeTile(
                    onTap: () {
                      wakeAt();
                    },
                    icon: LucideIcons.sunMoon,
                    title: 'Wake at',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10),
                  child: HomeTile(
                    onTap: () {},
                    icon: LucideIcons.target,
                    title: 'Set Daily Goal',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 10),
                  child: HomeTile(
                    onTap: () {
                      openUrl();
                    },
                    icon: LucideIcons.listCollapse,
                    title: 'About Sleep Cycles',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
