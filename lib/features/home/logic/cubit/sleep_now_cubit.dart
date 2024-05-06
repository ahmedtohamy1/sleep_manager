import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sleep_manager/features/home/ui/screens/home.dart';

class SleepNowCubit extends Cubit<String> {
  SleepNowCubit() : super('No alarms');

  setSleepNowTime() {
    emit(DateFormat.jm().format(DateTime.now().applied(TimeOfDay.now())));
  } // return string = 4:50 AM -PM

  setTimeFirebase(String time) {
    emit(time); // CUBIT = 00000
  }

  void clearSleepNowTime() {
    emit('No alarms');
  }

  DateTime parseTime(String timeString) {
    // Split the time string
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1].split(' ')[0]);
    bool isPM = parts[1].contains('PM');

    // Adjust hour for PM times
    if (isPM && hour != 12) {
      hour += 12;
    }
    // Adjust hour for 12:00 AM
    else if (hour == 12 && !isPM) {
      hour = 0;
    }

    // Create a DateTime object with the parsed values
    return DateTime(1, 1, 1, hour, minute);
  }

  String formatDate(DateTime dateTime) {
    // Format DateTime object back to string
    String hour = (dateTime.hour % 12).toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String period = dateTime.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  String addTime(String dateTime, int hrs, int mins) {
    // Split the time string
    List<String> parts = dateTime.split(':'); // 8:16 PM 8  16
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1].split(' ')[0]);
    bool isPM = parts[1].contains('PM');

    // Adjust hour for PM times
    if (isPM && hour != 12) {
      hour += 12;
    }
    // Adjust hour for 12:00 AM
    else if (hour == 12 && !isPM) {
      hour = 0;
    }

    // Subtract the specified hours and minutes
    DateTime dateTimeObj = DateTime(1, 1, 1, hour, minute);
    DateTime subtractedTime =
        dateTimeObj.add(Duration(hours: hrs, minutes: mins));
    return formatDate(subtractedTime);
  }

  String subtractTime(String dateTime, int hrs, int mins) {
    // Split the time string
    List<String> parts = dateTime.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1].split(' ')[0]);
    bool isPM = parts[1].contains('PM');

    // Adjust hour for PM times
    if (isPM && hour != 12) {
      hour += 12;
    }
    // Adjust hour for 12:00 AM
    else if (hour == 12 && !isPM) {
      hour = 0;
    }

    // Subtract the specified hours and minutes
    DateTime dateTimeObj = DateTime(1, 1, 1, hour, minute);
    DateTime subtractedTime =
        dateTimeObj.subtract(Duration(hours: hrs, minutes: mins));
    return formatDate(subtractedTime);
  }
}
