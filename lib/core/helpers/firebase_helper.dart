import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  // Auth functions

  Future loginUser(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // make signup method
  Future signUpUser(String email, String password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  // is logged in method
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  // logout method
  Future logout() async {
    await auth.signOut();
  }

  // forgot password method
  Future forgotPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> addDocSleepNow(String sleepNowTime) async {
    // Check if document with user's UID and 'SleepNow' exists
    final QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('times')
        .where('userOwner', isEqualTo: auth.currentUser?.uid)
        .where('SleepNow', isNull: true)
        .get();

    if (snapshot.docs.isEmpty) {
      // Document does not exist, add new one
      await db.collection('times').add({
        'SleepNow': sleepNowTime,
        'userOwner': auth.currentUser?.uid,
      });
    }
  }

  Future<void> addDocWakeAt(String wakeAtTime) async {
    // Check if document with user's UID and 'wakeAtTime' exists
    final QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('times')
        .where('userOwner', isEqualTo: auth.currentUser?.uid)
        .where('wakeAtTime', isNull: true)
        .get();

    if (snapshot.docs.isEmpty) {
      // Document does not exist, add new one
      await db.collection('times').add({
        'wakeAtTime': wakeAtTime,
        'userOwner': auth.currentUser?.uid,
      });
    }
  }

  Future<Map<String, dynamic>> getSleepAndWakeTimes() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('times')
        .where('userOwner', isEqualTo: auth.currentUser?.uid)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Retrieve the data from the first document (assuming there's only one document per user)
      final data = snapshot.docs.first.data();
      return {
        'SleepNow': data['SleepNow'],
        'wakeAtTime': data['wakeAtTime'],
      };
    } else {
      // No document found for the current user
      return {
        'SleepNow': null,
        'wakeAtTime': null,
      };
    }
  }

  Future<void> updateSleepTime(String newSleepTime) async {
    await db
        .collection('times')
        .where('userOwner', isEqualTo: auth.currentUser?.uid)
        .where('SleepNow', isEqualTo: '')
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.forEach((doc) async {
          await doc.reference.update({'SleepNow': newSleepTime});
        });
      }
    });
  }

  Future<void> updateWakeTime(String newWakeTime) async {
    await db
        .collection('times')
        .where('userOwner', isEqualTo: auth.currentUser?.uid)
        .where('wakeAtTime', isEqualTo: '')
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.forEach((doc) async {
          await doc.reference.update({'wakeAtTime': newWakeTime});
        });
      }
    });
  }
}
