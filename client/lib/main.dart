import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'injection.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = getIt<SharedPreferences>();
  bool isLogin = prefs.getBool('isLogin') ?? false;
  String? timeLogin = prefs.getString('timeLogin');
  if (isLogin &&
      timeLogin != null &&
      timeLogin.toDateTime().compareTo(DateTime.now()) <= 0) {
    GoogleSignIn().signOut();
    prefs.setBool("isLogin", false);
    prefs.setString("storeID", "");
    prefs.setBool("isBringBack", false);
  }
  FirebaseMessaging.instance.getToken().then((value) {
    print(value);
  });
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  // runApp(const MyApp());
}
