import 'package:bds/donors.dart';
import 'package:bds/profile.dart';
import 'package:bds/request.dart';
import 'package:bds/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Donation App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeWrapper(),
        '/profile': (context) => const ProfilePage(),
        '/login':(context) => const LoginScreen(),
        '/donors': (context) => const Donors(),
        '/request': (context) => const Request(), 
      },
    );
  }
}
