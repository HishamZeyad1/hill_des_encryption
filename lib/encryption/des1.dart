import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_des/flutter_des.dart';
import 'package:hill_des_encryption/encryption/des_cipher.dart';
import 'package:hill_des_encryption/launch_screen.dart';
import 'package:hill_des_encryption/register_screen.dart';
import 'dart:convert';

import '../home_screen.dart';
import '../login_screen.dart';

const _key = "u1BvOHzUOcklgNpn1MaWvdn9DT4LyzSX";
const _iv = "12345678";
Future<void> crypt() async {
  String str="[66,250,184,190,189,21,124,107]";
  String hexistr="21AC53B2E1CEA260";

  // Codec<String, String> stringToBase64Url = utf8.fuse(base64Url);

  // byte[] bytesToDecrypt = Base64(base64TextToDecrypt);
  //
  // String credentials = "username:password";
  // Codec<String, String> stringToBase64Url = utf8.fuse(base64Url);
  // String encoded = stringToBase64Url.encode(credentials);      // dXNlcm5hbWU6cGFzc3dvcmQ=
  // String decoded = stringToBase64Url.decode("dXNlcm5hbWU6cGFzc3dvcmQ=");          // username:password
  // print(decoded);
  // List<int> decoded = utf8.encode(base64Url.encode([66,250,184,190,189,21,124,107]));     // username:password
  // print(base64Url.decode([66,250,184,190,189,21,124,107].toString()));
  // Uint8List? _encrypt;
  String _decrypt,_decryptHex = '';
  try {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);
    // _encrypt = (await FlutterDes.encrypt(_text, _key, iv: _iv))!;
    _decrypt = (await FlutterDes.decrypt(unit8List, _key, iv: _iv))!;
    _decryptHex = (await FlutterDes.decryptFromHex(hexistr, _key, iv: _iv))!;

    print(unit8List);
    print("********************************");
    print(_decryptHex);

  } catch (e) {
    print(e);
  }
}



void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await crypt();
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