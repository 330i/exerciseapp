import 'package:exerciseapp/pages/user_profile_page.dart';
import 'package:flutter/material.dart';
import './widgets/bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.red),
      home: BottomBar(),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
