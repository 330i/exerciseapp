import 'package:exerciseapp/pages/login_page.dart';
import 'package:exerciseapp/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Container(
            color: Colors.red,
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(home: SignUpPage());
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    return MaterialApp(
      home: SignUpPage(),
    );
  }
}