import 'package:flutter/material.dart';
import 'pages/global_users_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      home: GlobalUsersPage(),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


