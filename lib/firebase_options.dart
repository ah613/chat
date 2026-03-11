
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
    apiKey: 'AIzaSyACFNJScqByPqQONNQrG9epwXvELZA49ac',
    appId: '1:965994992585:web:1e9fc18fae017f12d0ce18',
    messagingSenderId: '965994992585',
    projectId: 'chat-boys-b466d',
    authDomain: 'chat-boys-b466d.firebaseapp.com',
    storageBucket: 'chat-boys-b466d.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAMm4xcGDjzMTRYWav4bT6tmYTFgJDEvNE',
    appId: '1:965994992585:android:9ab8a5a77385c999d0ce18',
    messagingSenderId: '965994992585',
    projectId: 'chat-boys-b466d',
    storageBucket: 'chat-boys-b466d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDsrhJWh0iCAHLcTuICFO11mmuI7QDHLC0',
    appId: '1:965994992585:ios:a2e7528d5ff8273cd0ce18',
    messagingSenderId: '965994992585',
    projectId: 'chat-boys-b466d',
    storageBucket: 'chat-boys-b466d.firebasestorage.app',
    iosClientId: '965994992585-mgtjg7tphaq1dus9g7uep6rl77pj2abg.apps.googleusercontent.com',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDsrhJWh0iCAHLcTuICFO11mmuI7QDHLC0',
    appId: '1:965994992585:ios:a2e7528d5ff8273cd0ce18',
    messagingSenderId: '965994992585',
    projectId: 'chat-boys-b466d',
    storageBucket: 'chat-boys-b466d.firebasestorage.app',
    iosClientId: '965994992585-mgtjg7tphaq1dus9g7uep6rl77pj2abg.apps.googleusercontent.com',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyACFNJScqByPqQONNQrG9epwXvELZA49ac',
    appId: '1:965994992585:web:2505aa76430248e9d0ce18',
    messagingSenderId: '965994992585',
    projectId: 'chat-boys-b466d',
    authDomain: 'chat-boys-b466d.firebaseapp.com',
    storageBucket: 'chat-boys-b466d.firebasestorage.app',
  );

}