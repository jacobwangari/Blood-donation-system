import 'package:bds/home_screen.dart';
import 'package:bds/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeWrapper extends StatelessWidget {
  const HomeWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.authStateChanges().first,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // return a loading widget if we're still waiting for the auth state to change
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          // if the user is logged in, show the HomePage widget
          return const HomePage();
        } else {
          // if the user is not logged in, redirect to the login page
          return const LoginScreen();
        }
      },
    );
  }
}
