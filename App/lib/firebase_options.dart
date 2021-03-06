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
    apiKey: 'AIzaSyBT-kLbhsbPylhLdEJhcMqNlCb9ZUhHI2c',
    appId: '1:175124542913:web:bb5cf553f4088a4430ab40',
    messagingSenderId: '175124542913',
    projectId: 'hackmanthan-lostminds',
    authDomain: 'hackmanthan-lostminds.firebaseapp.com',
    storageBucket: 'hackmanthan-lostminds.appspot.com',
    measurementId: 'G-02V476G918',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmDzlz-bhDQ4wGZNNbVWhsAgW7gE8vIyg',
    appId: '1:175124542913:android:fd230cd332265f8730ab40',
    messagingSenderId: '175124542913',
    projectId: 'hackmanthan-lostminds',
    storageBucket: 'hackmanthan-lostminds.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCEZgxHLu8isf99JyPkWkYXs6GBA7ViV38',
    appId: '1:175124542913:ios:7c0f9a96ec2798e730ab40',
    messagingSenderId: '175124542913',
    projectId: 'hackmanthan-lostminds',
    storageBucket: 'hackmanthan-lostminds.appspot.com',
    iosClientId: '175124542913-961nh3cn6or28icpvvp1dmhh206jn1tq.apps.googleusercontent.com',
    iosBundleId: 'com.example.hackmanthanApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCEZgxHLu8isf99JyPkWkYXs6GBA7ViV38',
    appId: '1:175124542913:ios:7c0f9a96ec2798e730ab40',
    messagingSenderId: '175124542913',
    projectId: 'hackmanthan-lostminds',
    storageBucket: 'hackmanthan-lostminds.appspot.com',
    iosClientId: '175124542913-961nh3cn6or28icpvvp1dmhh206jn1tq.apps.googleusercontent.com',
    iosBundleId: 'com.example.hackmanthanApp',
  );
}
