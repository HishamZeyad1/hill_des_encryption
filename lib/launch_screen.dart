
import 'package:flutter/material.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, /*'/home_screen'*/'/register_screen'),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.orange, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Center(
          child: Text(
            "Hill DES Encryption",
          ),
        ),
      ),
    );
  }
}
