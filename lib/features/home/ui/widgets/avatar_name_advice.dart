import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sleep_manager/features/home/logic/cubit/db_cubit.dart';
import 'package:sleep_manager/features/home/logic/cubit/sleep_now_cubit.dart';
import 'package:sleep_manager/features/home/logic/cubit/wanted_time_to_wake_cubit.dart';
import 'package:sleep_manager/features/home/ui/screens/alarm_screen.dart';
import 'package:sleep_manager/features/home/ui/widgets/clear_wake_time.dart';

class AvatarNameAdvice extends StatefulWidget {
  const AvatarNameAdvice({
    super.key,
  });

  @override
  State<AvatarNameAdvice> createState() => _AvatarNameAdviceState();
}

class _AvatarNameAdviceState extends State<AvatarNameAdvice> {
  @override
  Widget build(BuildContext context) {
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
      super.initState();
      updateTimes();
    }

    return Row(
      children: [
        const CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(
                'https://t4.ftcdn.net/jpg/00/96/48/11/360_F_96481143_EDJRxhplkTUrdgXE4R45XAX0cHFr8QTC.jpg')),
        const SizedBox(
          width: 15,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Night",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Sleep Well",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        const SizedBox(width: 75),
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            if (context.read<WantedTimeToWakeCubit>().state != 'No Alarm') {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AlarmScreen()));
            } else {
              ShadToaster.of(context).show(
                const ShadToast(
                  title: Text('No Alarm Set'),
                  description: Text('Please set an alarm to view it'),
                ),
              );
            }
          },
          onLongPress: () {
            ClearWakeTime(context).ClearTimeDialog(context);
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(96, 34, 32, 32),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    const Text('Next Alarm at: '),
                    BlocBuilder<SleepNowCubit, String>(
                      builder: (context, state) {
                        return Text(
                          context.read<SleepNowCubit>().state,
                          style: const TextStyle(fontSize: 20),
                        );
                      },
                    ),
                  ],
                )),
          ),
        )
      ],
    );
  }
}
