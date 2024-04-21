import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseconnect/firebase_options.dart';
import 'package:firebaseconnect/home_screen.dart';
import 'package:firebaseconnect/screens/email_auth/create_acc.dart';
import 'package:firebaseconnect/screens/email_auth/login_acc.dart';
import 'package:firebaseconnect/screens/phone_auth/signin_with_phone.dart';
import 'package:flutter/material.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const Text("oooo"),
      home: (FirebaseAuth.instance.currentUser != null)
          ? HomeScreen()
          // : LoginScreen(),
          : SinginWithPhone(),
    );
  }
}
