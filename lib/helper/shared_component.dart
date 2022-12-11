import 'package:flutter/material.dart';

class SharedComponent{
  SharedComponent();
  static showLoading(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("waiting..."),
            content: Container(
              height: 100,
              child: Center(
                child: Column(
                  children: [
                    Text("The process will take a few second"),
                    SizedBox(height: 2,),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  // static TextStyle getStyle(double size,FontWeight fontWeight){
  //   return GoogleFonts.laila(fontSize: size,fontWeight:fontWeight,);
  // }
}
