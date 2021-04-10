import 'package:flutter/material.dart';
import '../pfp.dart';

class Topbar extends StatelessWidget {
  final String userPfp;
  Topbar({this.userPfp = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orangeAccent,
      width: MediaQuery.of(context).size.height,
      height: 85.0,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 25.0, left: 10.0),
            child: Pfp(imageUrl:userPfp, size: 50.0),
          ),
          Container(
            alignment: Alignment.center,
              margin: EdgeInsets.only(top: 25.0, left: 30),
              width: 200.0,
              height: 30.0,
              child: Text("Leaderboard"))
        ],
      ),
    );
  }
}
