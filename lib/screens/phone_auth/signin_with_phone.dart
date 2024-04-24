// ignore_for_file: dead_code

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseconnect/common/global_text.dart';
import 'package:firebaseconnect/screens/email_auth/create_acc.dart';
import 'package:firebaseconnect/screens/phone_auth/verify_otp.dart';
import 'package:firebaseconnect/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SinginWithPhone extends StatefulWidget {
  const SinginWithPhone({super.key});

  @override
  State<SinginWithPhone> createState() => _SinginWithPhoneState();
}

class _SinginWithPhoneState extends State<SinginWithPhone> {
  final phonecontroller = TextEditingController();
  void sendOTP() async {
    String phone = "+91" + phonecontroller.text.trim();
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        codeSent: (verificationId, forceResendingToken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerifyOtp(
                  verificationId: verificationId,
                ),
              ));
        },
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {
          log(error.code.toString());
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: Duration(seconds: 30));
  }

  @override
  Widget build(BuildContext context) {
    bool _validate = false;
    return Scaffold(
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
                            controller: phonecontroller,
                            decoration: InputDecoration(
                              errorText:
                                  _validate ? 'Value Cant be empty' : null,
                              contentPadding: EdgeInsets.all(10),
                              hintStyle: TextStyle(color: tdGrey),
                              hintText: 'Phone No',
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
                                sendOTP();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Text(
                                "Create Account",
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
