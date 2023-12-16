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
    apiKey: 'AIzaSyAi-LNg9K18N9buxFMWlRynnFsPPTgryy4',
    appId: '1:732486862331:web:5700f303edb3581876375e',
    messagingSenderId: '732486862331',
    projectId: 'vmodel-9109b',
    authDomain: 'vmodel-9109b.firebaseapp.com',
    storageBucket: 'vmodel-9109b.appspot.com',
    measurementId: 'G-RJQS1JB4WW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAMOWUsdzCcFhhXRKGMFXAZgtu9sCdHBDE',
    appId: '1:732486862331:android:248b0681582b4f7576375e',
    messagingSenderId: '732486862331',
    projectId: 'vmodel-9109b',
    storageBucket: 'vmodel-9109b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxKfCFicI6_TPrQOdvlS5vGyuoKzmSCE0',
    appId: '1:732486862331:ios:0c45f8b825fc337e76375e',
    messagingSenderId: '732486862331',
    projectId: 'vmodel-9109b',
    storageBucket: 'vmodel-9109b.appspot.com',
    androidClientId:
        '732486862331-ccconbt0ejgm3hsbbbul38arioi4fj4t.apps.googleusercontent.com',
    iosClientId:
        '732486862331-p67kvuoioo5vkt3rph6gc0221crp47nd.apps.googleusercontent.com',
    iosBundleId: 'app.vmodel.social',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCxKfCFicI6_TPrQOdvlS5vGyuoKzmSCE0',
    appId: '1:732486862331:ios:b0a94929da57cfd276375e',
    messagingSenderId: '732486862331',
    projectId: 'vmodel-9109b',
    storageBucket: 'vmodel-9109b.appspot.com',
    androidClientId:
        '732486862331-ccconbt0ejgm3hsbbbul38arioi4fj4t.apps.googleusercontent.com',
    iosClientId:
        '732486862331-4it2jqb5v7smvqvmk44jo03r9uea4gdj.apps.googleusercontent.com',
    iosBundleId: 'app.vmodel.social',
  );
}
