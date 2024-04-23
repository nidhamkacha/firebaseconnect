// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseconnect/firebase_options.dart';
import 'package:firebaseconnect/home_screen.dart';
import 'package:firebaseconnect/screens/phone_auth/signin_with_phone.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection("user").get();
  log(snapshot.docs.toString());
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
