import 'dart:developer';

import 'package:firebaseconnect/common/global_text.dart';
import 'package:firebaseconnect/screens/email_auth/login_acc.dart';
import 'package:firebaseconnect/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAcc extends StatefulWidget {
  const CreateAcc({super.key});

  @override
  State<CreateAcc> createState() => _CreateAccState();
}

final _EmailController = TextEditingController();
final _CreatepassController = TextEditingController();
final _ConfirmpassController = TextEditingController();
bool _validate = false;
void createAccount() async {
  String email = _EmailController.text.trim();
  String password = _CreatepassController.text.trim();
  String confirmpassword = _ConfirmpassController.text.trim();

  if (email == "" && password == "" && confirmpassword == "") {
    log("Please Fill All The Details");
  } else if (password != confirmpassword) {
    log("Passwords Do Not Match!");
  } else {
    //Create a new Account
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    log("User Created");
  }
}

class _CreateAccState extends State<CreateAcc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          // child: Text("data"),
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
                SizedBox(
                  height: 52,
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
                          blurRadius: 2, // Increased blurRadius
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
                            controller: _EmailController,
                            decoration: InputDecoration(
                              errorText:
                                  _validate ? 'Value Cant be empty' : null,
                              contentPadding: EdgeInsets.all(10),
                              hintStyle: TextStyle(color: tdGrey),
                              hintText: 'Email',
                              suffixIcon: Icon(Icons.email_outlined),
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
                            controller: _CreatepassController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintStyle: TextStyle(color: tdGrey),
                              hintText: 'Create Password',
                              suffixIcon: Icon(Icons.remove_red_eye_outlined),
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
                            controller: _ConfirmpassController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintStyle: TextStyle(color: tdGrey),
                              hintText: 'Confirm Password',
                              suffixIcon: Icon(Icons.remove_red_eye_outlined),
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
                                  createAccount();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                child: Text(
                                  "Create Account",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                )),
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
