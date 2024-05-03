import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  FirebaseAuth auth = FirebaseAuth.instance;
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
}
