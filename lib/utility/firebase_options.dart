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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBAkMOvN6vtI6ZY7m64j3FjtP_XEJ1QoC8',
    appId: '1:10202826840:android:9778aa755f5da6d99fe22d',
    messagingSenderId: '10202826840',
    projectId: 'hyper-garage-sale-fbc44',
    storageBucket: 'hyper-garage-sale-fbc44.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBUbPA2y1rx3IIujwE46STIdeCwmN4lxB0',
    appId: '1:10202826840:ios:7971ab3367fcbc759fe22d',
    messagingSenderId: '10202826840',
    projectId: 'hyper-garage-sale-fbc44',
    storageBucket: 'hyper-garage-sale-fbc44.appspot.com',
    iosClientId: '10202826840-4lfc9f6dv7r2cmsq0u2bhcli1lp9bnv4.apps.googleusercontent.com',
    iosBundleId: 'edu.neu.zequn.hyperGarageSale',
  );
}
