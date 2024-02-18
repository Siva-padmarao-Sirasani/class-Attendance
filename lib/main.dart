import 'package:attendance/HomeScreen.dart';
import 'package:attendance/SignUp.dart';
import 'package:attendance/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthenticationWrapper(),
      routes: {
        '/login': (context) => SignUp(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is already authenticated, go to home screen
      return HomeScreen();
    } else {
      // User is not authenticated, go to signup screen
      return SignUp();
    }
  }
}
