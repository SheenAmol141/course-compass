// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:course_compass/hex_colors.dart';
import 'package:course_compass/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:course_compass/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:js' as js;

class AdminLoginScreen extends StatefulWidget {
  AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final User? user = Auth().currentUser;
  bool loading = false;
  final _key = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      title: "Admin Profile",
      widget: [
        Container(
          color: Colors.white,
          child: Row(
            children: [
              MediaQuery.of(context).size.width < 1050
                  ? Container()
                  : Expanded(child: Container()),
              //CONTENT HERE expanded below ----------------------- white
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        FirebaseAuth.instance.currentUser == null
                            ? SizedBox(
                                height: 300,
                                child: Form(
                                  key: _key,

                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _email,
                                        validator: (value) => value == null ||
                                                value.isEmpty
                                            ? "This field must not be empty!"
                                            : !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$")
                                                    .hasMatch(value)
                                                ? "Email must be in the correct format!"
                                                : null,
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          // hintText: "email@example.com",
                                          border: OutlineInputBorder(),

                                          suffixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.email_rounded,
                                                  color: Colors.black
                                                      .withOpacity(0.2)),
                                              SizedBox(
                                                width: 5,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        obscureText: true,
                                        controller: _password,
                                        validator: (value) => value == null ||
                                                value.isEmpty
                                            ? "This field must not be empty!"
                                            : null,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Password',
                                          suffixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.password_rounded,
                                                  color: Colors.black
                                                      .withOpacity(0.2)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                              onPressed: () async {
                                                if (_key.currentState!
                                                    .validate()) {
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  try {
                                                    await Auth()
                                                        .signInWithEmailPassword(
                                                            email: _email.text,
                                                            password:
                                                                _password.text);

                                                    showDialog(
                                                      // login success!
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        content: Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .check_circle_rounded,
                                                              color: Colors
                                                                  .green
                                                                  .withOpacity(
                                                                      .7),
                                                              size: 70,
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              "Login Success!",
                                                              style: TextStyle(
                                                                  fontSize: 40,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                          ],
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(),
                                                              child:
                                                                  Text("Okay"))
                                                        ],
                                                      ),
                                                    );
                                                  } on FirebaseAuthException catch (e) {
                                                    showDialog(
                                                      // error during login!
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .error_rounded,
                                                                  color: Colors
                                                                      .red
                                                                      .withOpacity(
                                                                          .7),
                                                                  size: 70,
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Text(
                                                                  "Error during login!",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          40,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text(e.message!),
                                                          ],
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(),
                                                              child:
                                                                  Text("Okay"))
                                                        ],
                                                      ),
                                                    );
                                                  }

                                                  setState(() {
                                                    loading = false;
                                                  });
                                                } else {}
                                              },
                                              child: Text(
                                                "Login",
                                                style: TextStyle(
                                                    fontFamily:
                                                        GoogleFonts.inter()
                                                            .fontFamily,
                                                    fontSize: 17,
                                                    color: PSU_YELLOW,
                                                    fontWeight:
                                                        FontWeight.w900),
                                              )),
                                          loading
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 30.0),
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: PSU_BLUE
                                                        .withOpacity(.7),
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      )
                                    ],
                                  ),
                                  // key: _key,
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "You are currently logged in as: " +
                                        FirebaseAuth
                                            .instance.currentUser!.email!,
                                    style: GoogleFonts.inter(fontSize: 25),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        showDialog(
                                          // login success!
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            content: Row(
                                              children: [
                                                Icon(
                                                  Icons.check_circle_rounded,
                                                  color: Colors.green
                                                      .withOpacity(.7),
                                                  size: 70,
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "Logout?",
                                                  style: TextStyle(
                                                      fontSize: 40,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  child: Text("Cancel")),
                                              TextButton(
                                                  onPressed: () async {
                                                    await Auth().signOut();
                                                    setState(() {});
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Yes"))
                                            ],
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Logout",
                                        style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.inter().fontFamily,
                                            fontSize: 17,
                                            color: PSU_YELLOW,
                                            fontWeight: FontWeight.w900),
                                      )),
                                ],
                              ),
                        SizedBox(
                          height: 100,
                        ),
                        RichText(
                          text: new TextSpan(
                            style: GoogleFonts.inter(fontSize: 12),
                            children: [
                              new TextSpan(
                                text:
                                    'Learn more about your personality type and how it influences your learning style with insights from ',
                                style: new TextStyle(color: Colors.black),
                              ),
                              new TextSpan(
                                text: '16personalities.com.',
                                style: new TextStyle(color: Colors.blue),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    js.context.callMethod('open', [
                                      "https://www.16personalities.com/free-personality-test"
                                    ]);
                                  },
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: new TextSpan(
                            style: GoogleFonts.inter(fontSize: 12),
                            children: [
                              new TextSpan(
                                text: 'Onboarding icons created by ',
                                style: new TextStyle(color: Colors.black),
                              ),
                              new TextSpan(
                                text: 'Freepik - Flaticon',
                                style: new TextStyle(color: Colors.blue),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    js.context.callMethod(
                                        'open', ["https://www.flaticon.com"]);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ],
      currentpage: "admin-login",
    );
  }
}
