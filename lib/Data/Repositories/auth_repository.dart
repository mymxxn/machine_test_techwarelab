import 'dart:developer';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      log("message");
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await result.user?.updateDisplayName(name);
      // await result.user?.updatePhoneNumber(phoneCredential)
      log("message1");
    } on FirebaseAuthException catch (e) {
      log("${e.code} message2");

      if (e.code == 'weak-password') {
        throw Exception('This password is too weak');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email');
      }
    } catch (e) {
      log("${e} message3");
      throw Exception(e.toString());
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'channel-error') {
        throw Exception('${e}');
      } else if (e.code == 'invalid-credential') {
        throw Exception('Email or Password provided is incorrect');
      }
      log("${e.code}");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
