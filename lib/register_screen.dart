// import 'package:firebase/Archive/login_screen.dart';


// import 'package:firebase/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:hill_des_encryption/controller/fb_auth.dart';
import 'package:hill_des_encryption/widget/AppTextField.dart';

import 'helper/helpers.dart';
import 'helper/shared_component.dart';

// import '../controller/fb_auth.dart';

// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:twitter_login/twitter_login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {
  late UserCredential userCredential;
  int clicked = 0;

  String? username, email, password; //0 default,1 clickedLoading,2 clickingStop
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // print("is Logged:${FirebaseAuth.instance.currentUser!=null}");
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Hill DES",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Form(
              key: formstate,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                      hintText: "Enter your Username",
                      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.teal.shade300)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.teal.shade300)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.teal.shade500)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                    validator: (val) {
                      if (val != null && val.length > 25) {
                        return "username can not to be larger than 100";
                      } else if (val != null && val.length < 3) {
                        return "username can not to be less than 3";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      username = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // TextFormField(
                  //   keyboardType: TextInputType.emailAddress,
                  //   decoration: InputDecoration(
                  //     prefixIcon: Icon(
                  //       Icons.email,
                  //     ),
                  //     hintText: "Enter your Email",
                  //     // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.teal.shade300)),
                  //     enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(20),
                  //         borderSide: BorderSide(color: Colors.teal.shade300)),
                  //     focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(20),
                  //         borderSide: BorderSide(color: Colors.teal.shade500)),
                  //     errorBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(20),
                  //         borderSide: BorderSide(color: Colors.red)),
                  //   ),
                  //   validator: (val) {
                  //     if (val != null && val!.length > 25) {
                  //       return "email can not to be larger than 100";
                  //     } else if (val != null && val!.length < 3) {
                  //       return "email can not to be less than 3";
                  //     }
                  //     return null;
                  //   },
                  //   onSaved: (val) {
                  //     email = val;
                  //   },
                  // ),
                  AppTextField(
                    hintText: "Enter your Email",
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validationFn: (val) {
                      if (val != null && val.length > 25) {
                        return "email can not to be larger than 100";
                      } else if (val != null && val.length < 3) {
                        return "email can not to be less than 3";
                      }
                      return null;
                    },
                    savedFn: (val) {
                      email = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AppTextField(
                    hintText: "Enter your Password",
                    obscure: true,
                    icon: Icons.lock,
                    keyboardType: TextInputType.visiblePassword,
                    validationFn: (val) {
                      if (val != null && val.length > 25) {
                        return "password can not to be larger than 100";
                      } else if (val != null && val.length < 3) {
                        return "password can not to be less than 3";
                      }
                      return null;
                    },
                    savedFn: (val) {
                      password = val;
                    },
                  ),

                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            ElevatedButton(
                child: Text(
                  "Create Account",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  primary: Colors.teal.shade300,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(20))),
                ),
                onPressed: () async {
                  await signUp();
                }),
            SizedBox(
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("if you have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/login_screen");
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  style: ButtonStyle(
                      overlayColor:
                      MaterialStateProperty.all(Colors.transparent)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  signUp() async {
    FormState? formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      SharedComponent.showLoading(context);
      String? created = await FbAuth()
          .createAccount(emailAddress: email!, password: password!);
      Navigator.of(context).pop();
      String message =
      created == null ? 'Created successfully' : 'Create failed:$created';
      if (created == null) {
        await FirebaseFirestore.instance.collection("users").add({
          "username": username,
          "email": email,
          "userId": FirebaseAuth.instance.currentUser?.uid
        }).then((value) {
          Navigator.of(context).pushReplacementNamed("/home_screen");
          print("done");
        }).onError((error, stackTrace){print("Error: " + error.toString());});
      }
      showSnackBar(
          context: context, message: message, error: !(created == null));
      print("created:$created");
    }
  }
}
