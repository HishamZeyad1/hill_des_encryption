import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hill_des_encryption/helper/helpers.dart';
import 'package:hill_des_encryption/widget/AppTextField.dart';

import 'controller/fb_auth.dart';
import 'helper/shared_component.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers{
  late UserCredential userCredential;
  String?  email, password; //0 default,1 clickedLoading,2 clickingStop
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                  AppTextField(hintText: "Enter your Email",
                    icon: Icons.email,keyboardType:TextInputType.emailAddress,
                    validationFn: (val) {
                      if (val != null && val.length > 25) {
                        return "email can not to be larger than 100";
                      }
                      else if (val != null && val.length < 3) {
                        return "email can not to be less than 3";
                      }
                      return null;
                    },
                    savedFn: (val) {email = val;},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AppTextField(hintText: "Enter your Password",obscure:true,
                    icon: Icons.lock,keyboardType:TextInputType.visiblePassword,
                    validationFn: (val) {
                      if (val != null && val.length > 25) {
                        return "password can not to be larger than 100";
                      } else if (val != null && val.length < 3) {
                        return "password can not to be less than 3";
                      }
                      return null;
                    },
                    savedFn: (val) {password = val; },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            ElevatedButton(
                child: Text(
                  "Sign In",
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
                  await signIn();
                }),
            SizedBox(
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("if you have not an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/register_screen");
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
  signIn() async {
    FormState? formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      SharedComponent.showLoading(context);
      String? signed = await FbAuth().signEmailAndPassword(
          emailAddress: email!,
          password: password!);
      Navigator.of(context).pop();
      String message = signed==null? 'logged successfully' : 'logged failed:$signed';
      showSnackBar(context: context, message: message, error: !(signed==null));
      if(signed==null){
        Navigator.of(context).pushNamed("/home_screen");
      }
      print("signed:$signed");
    }
  }
}