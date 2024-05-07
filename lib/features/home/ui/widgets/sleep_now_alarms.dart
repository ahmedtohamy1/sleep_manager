import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sleep_manager/features/home/logic/cubit/sleep_now_cubit.dart';

class SleepNowAlarms extends StatelessWidget {
  const SleepNowAlarms({super.key});

  @override
  Widget build(BuildContext context) {
    String cycleCalc(int hrs, int mins) {
      return context
          .read<SleepNowCubit>()
          .addTime(context.read<SleepNowCubit>().state, hrs, mins);
    }

    return context.read<SleepNowCubit>().state != 'no alarms'
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(96, 34, 32, 32),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(children: [
                const Positioned(
                    top: 0,
                    left: 0,
                    child: ShadBadge.secondary(
                      text: Text('Sleep Now Alarms'),
                    )),
                Row(
                  children: [
                    const Icon(
                      LucideIcons.bedSingle,
                      size: 50,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(context.read<SleepNowCubit>().state,
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                        children: List.generate(5, (index) {
                      int hour, minute;

                      switch (index + 1) {
                        case 1:
                          hour = 1;
                          minute = 30;
                          break;
                        case 2:
                          hour = 3;
                          minute = 0;
                          break;
                        case 3:
                          hour = 4;
                          minute = 30;
                          break;
                        case 4:
                          hour = 7;
                          minute = 0;
                          break;
                        case 5:
                          hour = 9;
                          minute = 30;
                          break;
                        default:
                          hour = 0;
                          minute = 0;
                      }

                      return Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'To Sleep ${index + 1} Cycle(s): \n Wake At: ${cycleCalc(hour, minute)}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    }))
                  ],
                ),
              ]),
            ),
          )
        : Container();
  }
}
