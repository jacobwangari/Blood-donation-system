// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDhCINV3AogbxBjGLyDd6XhB3YNgFp_0x8',
    appId: '1:1098058561248:web:9bdd3a368b44b371ba8285',
    messagingSenderId: '1098058561248',
    projectId: 'bloodds-4cc4a',
    authDomain: 'bloodds-4cc4a.firebaseapp.com',
    storageBucket: 'bloodds-4cc4a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCInTlLn7u0a6zYeGxDlmmiUEqm7vRqKQU',
    appId: '1:1098058561248:android:0666a10d890a00bbba8285',
    messagingSenderId: '1098058561248',
    projectId: 'bloodds-4cc4a',
    storageBucket: 'bloodds-4cc4a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAL_-q-OsLwRC09PXwWctxffwAJwUhFRQE',
    appId: '1:1098058561248:ios:b736604a930c605dba8285',
    messagingSenderId: '1098058561248',
    projectId: 'bloodds-4cc4a',
    storageBucket: 'bloodds-4cc4a.appspot.com',
    iosClientId: '1098058561248-cpng3i0d9lb70gask1lurgdr0orpav5d.apps.googleusercontent.com',
    iosBundleId: 'com.example.bds',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAL_-q-OsLwRC09PXwWctxffwAJwUhFRQE',
    appId: '1:1098058561248:ios:b736604a930c605dba8285',
    messagingSenderId: '1098058561248',
    projectId: 'bloodds-4cc4a',
    storageBucket: 'bloodds-4cc4a.appspot.com',
    iosClientId: '1098058561248-cpng3i0d9lb70gask1lurgdr0orpav5d.apps.googleusercontent.com',
    iosBundleId: 'com.example.bds',
  );
}
