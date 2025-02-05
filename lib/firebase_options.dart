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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDtIR82x2CKMRyr9zWMm6fj2H2au3ejUZ4',
    appId: '1:442436144574:web:ed303c3443f3984adcfdef',
    messagingSenderId: '442436144574',
    projectId: 'onjung-392b5',
    authDomain: 'onjung-392b5.firebaseapp.com',
    storageBucket: 'onjung-392b5.firebasestorage.app',
    measurementId: 'G-Y05VECJMFX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAYuaxVk0PbS79xQcL3XUSNmUtYLblx9Kc',
    appId: '1:442436144574:android:8e802a020cf6fc49dcfdef',
    messagingSenderId: '442436144574',
    projectId: 'onjung-392b5',
    storageBucket: 'onjung-392b5.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCgA3-ggu8RqzuBbvJYdr1n_prYPgBLqNU',
    appId: '1:442436144574:ios:c5178dd059eab702dcfdef',
    messagingSenderId: '442436144574',
    projectId: 'onjung-392b5',
    storageBucket: 'onjung-392b5.firebasestorage.app',
    iosBundleId: 'com.example.flutterOnjung',
  );
}
