// ignore_for_file: file_names, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Last_step.dart';
import '../Main_Screen.dart';
import 'Users_services.dart';

class Auth {
  final _firebaseauth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final Userservice _userservice = Userservice();
  Future signIn(String email, String password) async {
    try {
      await _firebaseauth.signInWithEmailAndPassword(
          email: email, password: password);
      if (FirebaseAuth.instance.currentUser?.emailVerified == false) {
        Get.snackbar(
            "Your E-mail has not been confirmed", "Please Verify Your E-Mail",
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.TOP,
            colorText: Colors.blue);
      } else {
        Get.to(() => const Main_Screen());
      }
    } on FirebaseAuthException catch (e) {
      String? title = e.code.replaceAll(RegExp('-'), ' ').capitalize;

      String message = '';

      if (e.code == 'wrong-password') {
        message = 'Invalid Password. Please try again!';
      } else if (e.code == 'user-not-found') {
        message =
            ('The account does not exists for $email. Create your account by signing up.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title!, message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          colorText: Colors.blue);
    } catch (e) {
      Get.snackbar(
        'Error occured!',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.blue,
      );
    }
  }

  Future Out() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future signUp(String email, String password, String uid, String name,
      String surname, String emailagain, String phoTo_Url) async {
    try {
      await _firebaseauth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => sendEmailVerif())
          .then((value) => _userservice
              .addUser(uid, name, surname, emailagain, phoTo_Url)
              .then((value) => Get.to(() => Last_step())));
    } on FirebaseAuthException catch (e) {
      String? title = e.code.replaceAll(RegExp('-'), ' ').capitalize;
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = ('The account already exists for that email.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title!, message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.blue,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.blue,
          colorText: Colors.white);
    }
  }

  Future<void> resetPassword(String email) async {
    await _firebaseauth.sendPasswordResetEmail(email: email);
  }

  Future sendEmailVerif() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (!(user!.emailVerified)) {
      await user.sendEmailVerification();
    }
  }
}
