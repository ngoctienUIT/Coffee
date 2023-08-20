import 'package:coffee/injection.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'my_app.dart';

int? language;
bool isLogin = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = getIt<SharedPreferences>();
  language = prefs.getInt('language');
  isLogin = prefs.getBool('isLogin') ?? false;
  String? timeLogin = prefs.getString('timeLogin');
  if (isLogin &&
      timeLogin != null &&
      timeLogin.toDateTime().compareTo(DateTime.now()) <= 0) {
    isLogin = false;
    GoogleSignIn().signOut();
    SharedPreferences.getInstance().then((value) {
      value.setBool("isLogin", false);
      value.setString("storeID", "");
      value.setBool("isBringBack", false);
    });
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
