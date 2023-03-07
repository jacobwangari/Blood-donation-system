import 'package:bds/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


Future<void> signOut(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  } catch (e) {
    // handle sign-out errors
    print('Failed to sign out: $e');
  }
}
