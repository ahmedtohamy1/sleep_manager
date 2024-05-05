import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sleep_manager/features/home/logic/cubit/sleep_now_cubit.dart';
import 'package:sleep_manager/features/home/logic/cubit/wanted_time_to_wake_cubit.dart';

class ClearWakeTime {
  ClearWakeTime(BuildContext context);

  Future<dynamic> ClearTimeDialog(BuildContext context) {
    return showShadDialog(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: const Text('Are you absolutely sure?'),
        description: const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
          ),
        ),
        actions: [
          ShadButton.outline(
            text: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          ShadButton(
            text: const Text('Continue'),
            onPressed: () {
              context.read<WantedTimeToWakeCubit>().clearWantedTimeToWake();
              context.read<SleepNowCubit>().clearSleepNowTime();
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );
  }
}
