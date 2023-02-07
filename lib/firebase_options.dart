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
    apiKey: 'AIzaSyCHQ7YjaqEQixQRmiSq6yk_28Vz9WdvnEI',
    appId: '1:172995413609:web:c9b7cb70d358993af804f8',
    messagingSenderId: '172995413609',
    projectId: 'secondproject-5e109',
    authDomain: 'secondproject-5e109.firebaseapp.com',
    storageBucket: 'secondproject-5e109.appspot.com',
    measurementId: 'G-H9RM282233',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdXPNj5rSVOMOLIzUFGr3ohTDGpiULfaE',
    appId: '1:172995413609:android:7dbcf86908cbafbdf804f8',
    messagingSenderId: '172995413609',
    projectId: 'secondproject-5e109',
    storageBucket: 'secondproject-5e109.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBT26i7wousVmYOU5IvkcBlxQBWwX6vCn4',
    appId: '1:172995413609:ios:01f7353645abc8e6f804f8',
    messagingSenderId: '172995413609',
    projectId: 'secondproject-5e109',
    storageBucket: 'secondproject-5e109.appspot.com',
    iosClientId: '172995413609-tnr2um8idjutcguuevtbcga5m1o8d9qi.apps.googleusercontent.com',
    iosBundleId: 'karon.tradingscrore.tradingscrore',
  );
}