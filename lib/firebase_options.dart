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
    apiKey: 'AIzaSyCmC5iqOIRxh2lNBTY1fTpyAtHMx8fnudA',
    appId: '1:848249540366:web:0eebd1d629af1382c7515f',
    messagingSenderId: '848249540366',
    projectId: 'test-d8042',
    authDomain: 'test-d8042.firebaseapp.com',
    storageBucket: 'test-d8042.appspot.com',
    measurementId: 'G-8JQ98H6X25',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCzfcnyk7jgZU95Gwp1q07uCeI90egjuag',
    appId: '1:848249540366:android:05b36962bc087b15c7515f',
    messagingSenderId: '848249540366',
    projectId: 'test-d8042',
    storageBucket: 'test-d8042.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAWY7ROiuVH-qZy-HiosfXj2cBZnduU8XA',
    appId: '1:848249540366:ios:34daa813cdc48f51c7515f',
    messagingSenderId: '848249540366',
    projectId: 'test-d8042',
    storageBucket: 'test-d8042.appspot.com',
    iosClientId: '848249540366-n62b11irl2ee5tvsor64et0s5rk2ki1s.apps.googleusercontent.com',
    iosBundleId: 'com.example.testing',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAWY7ROiuVH-qZy-HiosfXj2cBZnduU8XA',
    appId: '1:848249540366:ios:34daa813cdc48f51c7515f',
    messagingSenderId: '848249540366',
    projectId: 'test-d8042',
    storageBucket: 'test-d8042.appspot.com',
    iosClientId: '848249540366-n62b11irl2ee5tvsor64et0s5rk2ki1s.apps.googleusercontent.com',
    iosBundleId: 'com.example.testing',
  );
}
