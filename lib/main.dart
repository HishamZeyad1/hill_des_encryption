import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hill_des_encryption/encryption/hill_cipher.dart';
import 'package:hill_des_encryption/encryption/des_cipher.dart';

import 'package:hill_des_encryption/launch_screen.dart';
import 'package:hill_des_encryption/register_screen.dart';

import 'home_screen.dart';
import 'login_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hill DES Encryption',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (BuildContext) => LaunchScreen(),
        '/register_screen': (BuildContext) => RegisterScreen(),
        '/login_screen': (BuildContext) => LoginScreen(),
        '/home_screen': (BuildContext) => HomeScreen(),
        '/des_cipher': (BuildContext) => DesCipher(),

        // '/add_note': (BuildContext) => AddNote(),
        // '/test': (BuildContext) => Test(),
        // '/home_screen':(BuildContext)=>HomeScreen(),
        // '/fb_storage':(BuildContext)=>FbStorage(),
      },
    );
  }
}
