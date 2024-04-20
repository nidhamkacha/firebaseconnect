import 'package:firebaseconnect/common/global_text.dart';
import 'package:firebaseconnect/home_screen.dart';
import 'package:firebaseconnect/screens/email_auth/create_acc.dart';
import 'package:firebaseconnect/static/colors.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final _formKey = GlobalKey<FormState>();
final _EmailController = TextEditingController();
final _passController = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  String Email = "";
  String Password = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 64,
                  ),
                  GlobalText(
                    text: "Hello!",
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                  GlobalText(
                    text: "WELCOME BACK",
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Center(
                    child: Container(
                      height: 327,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 0.5,
                          ),
                        ],
                      ),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            height: 66,
                            width: 290,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Email address';
                                }
                                return null;
                              },
                              controller: _EmailController,
                              decoration: InputDecoration(
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
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Password';
                                }
                                return null;
                              },
                              controller: _passController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                hintStyle: TextStyle(color: tdGrey),
                                hintText: 'Entrer Password',
                                suffixIcon: Icon(Icons.remove_red_eye_outlined),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 4),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          GlobalText(
                            text: "Forgot Password",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: SizedBox(
                              height: 55,
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (_EmailController.text == Email &&
                                        _passController.text == Password) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));
                                    } else {
                                      _dialogBuilder(context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  child: Text(
                                    "Log In",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateAcc(),
                                  ));
                            },
                            child: GlobalText(
                              text: "Sign up",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Wrong Details'),
        content: const Text(
          'Please Enter Correct Details',
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
