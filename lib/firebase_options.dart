// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBxiWYWsKWmLNvu192HS6sOfI6oecorBUY',
    appId: '1:430573276237:web:7135a5cfd868a77b192004',
    messagingSenderId: '430573276237',
    projectId: 'flutter-cuoiky',
    authDomain: 'flutter-cuoiky.firebaseapp.com',
    storageBucket: 'flutter-cuoiky.appspot.com',
    measurementId: 'G-R7F1YZCE9T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPcML5L8_FJJyBX5a0FfjteNS03k4FB88',
    appId: '1:430573276237:android:dfb2fdc8e414304d192004',
    messagingSenderId: '430573276237',
    projectId: 'flutter-cuoiky',
    storageBucket: 'flutter-cuoiky.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAcKqz8Tf78bIb_yy-qbWSkSGj46FVBGLY',
    appId: '1:430573276237:ios:df53fa4ed2293d68192004',
    messagingSenderId: '430573276237',
    projectId: 'flutter-cuoiky',
    storageBucket: 'flutter-cuoiky.appspot.com',
    iosBundleId: 'com.example.openaiChatgptChatapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAcKqz8Tf78bIb_yy-qbWSkSGj46FVBGLY',
    appId: '1:430573276237:ios:df53fa4ed2293d68192004',
    messagingSenderId: '430573276237',
    projectId: 'flutter-cuoiky',
    storageBucket: 'flutter-cuoiky.appspot.com',
    iosBundleId: 'com.example.openaiChatgptChatapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBxiWYWsKWmLNvu192HS6sOfI6oecorBUY',
    appId: '1:430573276237:web:e7c1dcbb0fbcd585192004',
    messagingSenderId: '430573276237',
    projectId: 'flutter-cuoiky',
    authDomain: 'flutter-cuoiky.firebaseapp.com',
    storageBucket: 'flutter-cuoiky.appspot.com',
    measurementId: 'G-ZJD2BS3T07',
  );
}
