import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sleep_manager/features/home/logic/cubit/db_cubit.dart';
import 'package:sleep_manager/features/home/logic/cubit/sleep_now_cubit.dart';
import 'package:sleep_manager/features/home/logic/cubit/wanted_time_to_wake_cubit.dart';
import 'package:sleep_manager/features/home/ui/screens/alarm_screen.dart';
import 'package:sleep_manager/features/home/ui/widgets/clear_wake_time.dart';
import 'package:sleep_manager/features/profile/ui/screens/profile_screen.dart';

import '../../../../core/helpers/firebase_helper.dart';

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
    Reference ref = FirebaseHelper()
        .storage
        .ref()
        .child('user_images/${FirebaseHelper().auth.currentUser!.uid}.jpg');

    Future<String> getUrl() async {
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            FutureBuilder<String>(
              future: getUrl(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileScreen()));
                    },
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(snapshot.data!),
                      child: const Align(
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  );
                }
              },
            ),
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
            const SizedBox(width: 10),
          ],
        ),
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            if (context.read<WantedTimeToWakeCubit>().state.toLowerCase() !=
                    'no alarms' ||
                context.read<SleepNowCubit>().state.toLowerCase() !=
                    'no alarms') {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AlarmScreen()));
            } else if (context
                        .read<WantedTimeToWakeCubit>()
                        .state
                        .toLowerCase() ==
                    'no alarms' ||
                context.read<SleepNowCubit>().state.toLowerCase() ==
                    'no alarms') {
              ShadToaster.of(context).show(
                const ShadToast(
                  title: Text('No Alarm Set'),
                  description: Text('Please set an alarm to view it'),
                ),
              );
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
