// ignore_for_file: dead_code

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseconnect/screens/phone_auth/signin_with_phone.dart';
import 'package:firebaseconnect/static/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final agecontroller = TextEditingController();
  File? profilepic;

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      // MaterialPageRoute(builder: (context) => LoginScreen()),
      MaterialPageRoute(builder: (context) => SinginWithPhone()),
    );
  }

  void saveuser() async {
    String name = namecontroller.text.trim();
    String email = emailcontroller.text.trim();
    String ageString = agecontroller.text.trim();
    int age = int.parse(ageString);
    namecontroller.clear();
    emailcontroller.clear();
    agecontroller.clear();
    log(name);
    log(email);
    if (name != " " && email != " " && age != "" && profilepic != null) {
      UploadTask uploadtask = FirebaseStorage.instance
          .ref()
          .child("profilepictures")
          .child(Uuid().v1())
          .putFile(profilepic!);

      StreamSubscription tasksubscription =
          uploadtask.snapshotEvents.listen((snapshot) {
        double percentage =
            snapshot.bytesTransferred / snapshot.totalBytes * 100;
        log(percentage.toString());
      });
      TaskSnapshot taskSnapshot = await uploadtask;
      String downloadurl = await taskSnapshot.ref.getDownloadURL();
      tasksubscription.cancel();
      Map<String, dynamic> userData = {
        "name": name,
        "age": age,
        "email": email,
        "profilepic": downloadurl
      };
      await FirebaseFirestore.instance.collection("user").add(userData);
      log("User Created: ");
    } else {
      log("error");
    }
    setState(() {
      profilepic = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _validate = false;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home "),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () => logout(), icon: Icon(Icons.logout)),
        ],
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
                  height: 64,
                ),
                CupertinoButton(
                  onPressed: () async {
                    try {
                      XFile? selectedImage = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (selectedImage != null) {
                        File convertedFile = File(selectedImage.path);
                        setState(() {
                          profilepic = convertedFile;
                        });
                        log("Image Selectd");
                      } else {
                        log("No Image Selected");
                      }
                    } catch (e) {
                      log("Error picking image: $e");
                    }
                  },
                  padding: EdgeInsets.zero,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        (profilepic != null) ? FileImage(profilepic!) : null,
                    backgroundColor: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 15,
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
                              suffixIcon: Icon(Icons.person),
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
                              suffixIcon: Icon(Icons.email),
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
                            controller: agecontroller,
                            decoration: InputDecoration(
                              errorText:
                                  _validate ? 'Value Cant be empty' : null,
                              contentPadding: EdgeInsets.all(10),
                              hintStyle: TextStyle(color: tdGrey),
                              hintText: 'Age',
                              suffixIcon: Icon(Icons.boy),
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
                        SizedBox(
                          height: 16,
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("user")
                                .where("age")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  return Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          Map<String, dynamic> userMap =
                                              snapshot.data!.docs[index].data()
                                                  as Map<String, dynamic>;
                                          return ListTile(
                                            title: Text(userMap["name"] +
                                                " " +
                                                userMap["age"].toString()),
                                            subtitle: Text(userMap["email"]),
                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  userMap["profilepic"]),
                                            ),
                                            trailing: IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.delete),
                                            ),
                                          );
                                        }),
                                  );
                                } else {
                                  return Text("No data");
                                }
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            })
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
