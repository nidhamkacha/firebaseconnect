import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseconnect/firebase_options.dart';
import 'package:firebaseconnect/screens/email_auth/create_acc.dart';
import 'package:firebaseconnect/screens/email_auth/login_acc.dart';
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
      home: const LoginScreen(),
    );
  }
}