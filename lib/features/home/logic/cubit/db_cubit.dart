import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:sleep_manager/core/helpers/firebase_helper.dart';

part 'db_state.dart';

class DbCubit extends Cubit<DbState> {
  DbCubit(this.firebaseHelper) : super(DbInitial());
  final FirebaseHelper firebaseHelper;

  addDocSleepNow(String sleepNowTime) async {
    await firebaseHelper.addDocSleepNow(sleepNowTime);
  }

  addDocWakeAt(String wakeAtTime) async {
    await firebaseHelper.addDocWakeAt(wakeAtTime);
  }

  //get times
  getSleepAndWakeTimes() async {
    await firebaseHelper.getSleepAndWakeTimes();
  }

  updateSleepTime(String newTime) async {
    await firebaseHelper.updateSleepTime(newTime);
  }

  updateWakeTime(String newTime) async {
    await firebaseHelper.updateWakeTime(newTime);
  }
}
