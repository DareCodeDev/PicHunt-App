import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String userUid = '';
  String get getUserUid => userUid;

  Future<void> logIntoAccount(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = userCredential.user!;
      userUid = user.uid;
      print('User uid: $userUid');
      notifyListeners();
    } catch (e) {
      // Handle login errors
      print('Error logging in: $e');
      throw e; // Rethrow the error for handling in UI
    }
  }

  Future<void> userRegister(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set({
        'username': 'UserName',
        'email': email,
        'password': password,
        'Createded At': DateTime.now(),
        'userID': userCredential.user!.uid,
      });

      User user = userCredential.user!;
      userUid = user.uid;
      print('User uid: $userUid');
      notifyListeners();
    } catch (e) {
      // Handle registration errors
      print('Error registering user: $e');
      throw e; // Rethrow the error for handling in UI
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          userUid = user.uid;
          print('User uid: $userUid');
          notifyListeners();
          return user;
        }
      }
    } catch (e) {
      // Handle Google sign-in errors
      print('Error signing in with Google: $e');
      throw e; // Rethrow the error for handling in UI
    }
    return null;
  }
}
