import 'package:flutter/material.dart';

class UserStatsBox extends StatelessWidget {
  final String statType;
  final String stat;
  UserStatsBox({this.statType, this.stat});
  final Shader linearGradient = LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Colors.orangeAccent, Color(0xffff535e)])
      .createShader(Rect.fromLTWH(0.0, 0.0, 100.0, 50.0));
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(statType,
            style: TextStyle(
                foreground: Paint()..shader = linearGradient,
                fontWeight: FontWeight.bold,
                fontSize: 20.0)),
        Container(
          width: 100.0,
          height: 65.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(2, 4),
                )
              ]),
          child: Center(
            child: Text(
              stat,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
