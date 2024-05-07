import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseHelper {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  // Auth functions

  Future loginUser(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // make signup method

  Future<String> signUpUser(String email, String password, String fullName,
      String phoneNumber, File imageFile) async {
    try {
      // Create user in Firebase Authentication
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user ID of the newly created user
      String userId = userCredential.user!.uid;

      // Upload image to Firebase Storage
      String? imageUrl = await uploadImage(userId, imageFile);

      // Save the user's full name, phone number, and image URL in Firestore
      await db.collection('users').doc(userId).set({
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'imageUrl': imageUrl,
      });

      // Return the user ID
      return userId;
    } catch (error) {
      // Handle any errors that occur during user creation
      print("Error occurred during user creation: $error");
      // Rethrow the error to be handled by the caller
      rethrow;
    }
  }

  Future<String?> uploadImage(String userId, File imageFile) async {
    try {
      // Reference to Firebase Storage
      Reference ref = storage.ref().child('user_images/$userId.jpg');

      // Upload image to Firebase Storage
      UploadTask uploadTask = ref.putFile(imageFile);

      // Get download URL
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      // Return the download URL
      return imageUrl;
    } catch (error) {
      // Handle any errors that occur during image upload
      print("Error occurred during image upload: $error");
      // Return null to indicate failure
      return null;
    }
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

  Future<String?> getCurrentUserPhoneNumber() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        // Fetch the user's document from Firestore
        var userDoc = await db.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          return userDoc.get('phoneNumber');
        }
      }
      return null;
    } catch (e) {
      print("Error getting user's full name: $e");
      return null;
    }
  }

  // Method to get the user's full name
  Future<String?> getCurrentUserFullName() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        // Fetch the user's document from Firestore
        var userDoc = await db.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          return userDoc.get('fullName');
        }
      }
      return null;
    } catch (e) {
      print("Error getting user's full name: $e");
      return null;
    }
  }

  // Method to update the user's full name
  Future<void> updateFullName(String fullName) async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        // Update the user's document in Firestore
        await db.collection('users').doc(user.uid).update({
          'fullName': fullName,
        });
      }
    } catch (e) {
      print("Error updating user's full name: $e");
      rethrow;
    }
  }

  // Method to update the user's phone number
  Future<void> updatePhoneNumber(String phoneNumber) async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        // Update the user's document in Firestore
        await db.collection('users').doc(user.uid).update({
          'phoneNumber': phoneNumber,
        });
      }
    } catch (e) {
      print("Error updating user's phone number: $e");
      rethrow;
    }
  }

  Future<void> updateProfileImage(File imageFile) async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        // Upload image to Firebase Storage
        String? imageUrl = await uploadImage(user.uid, imageFile);

        if (imageUrl != null) {
          // Update the user's document in Firestore with the new image URL
          await db.collection('users').doc(user.uid).update({
            'imageUrl': imageUrl,
          });
        }
      }
    } catch (e) {
      print("Error updating user's profile image: $e");
      rethrow;
    }
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
