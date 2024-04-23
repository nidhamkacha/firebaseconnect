// ignore_for_file: dead_code

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseconnect/common/global_text.dart';
import 'package:firebaseconnect/screens/email_auth/login_acc.dart';
import 'package:firebaseconnect/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void saveuser() async {
    String name = namecontroller.text.trim();
    String email = emailcontroller.text.trim();
    if (name == " " && email == " ") {
      Map<String, dynamic> userData = {
        "name": name,
        "email": email,
      };
      FirebaseFirestore.instance.collection("user").add(userData);
      log("User Created: ");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _validate = false;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home "),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 74,
                ),
                GlobalText(
                  text: "WELCOME",
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
                Center(
                  child: Container(
                    height: 420,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: 66,
                          width: 290,
                          child: TextField(
                            controller: namecontroller,
                            decoration: InputDecoration(
                              errorText:
                                  _validate ? 'Value Cant be empty' : null,
                              contentPadding: EdgeInsets.all(10),
                              hintStyle: TextStyle(color: tdGrey),
                              hintText: 'Name',
                              suffixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 4),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 66,
                          width: 290,
                          child: TextField(
                            controller: emailcontroller,
                            decoration: InputDecoration(
                              errorText:
                                  _validate ? 'Value Cant be empty' : null,
                              contentPadding: EdgeInsets.all(10),
                              hintStyle: TextStyle(color: tdGrey),
                              hintText: 'Email',
                              suffixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 4),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: SizedBox(
                            height: 55,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                saveuser();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Text(
                                "Save",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
