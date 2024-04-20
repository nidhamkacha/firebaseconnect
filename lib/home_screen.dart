import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseconnect/screens/email_auth/login_acc.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: Icon(Icons.exit_to_app),
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
