import 'package:flutter/material.dart';

class UserStatsCircle extends StatelessWidget {
  final double size;
  final String statType;
  final String stat;
  UserStatsCircle({this.size, this.statType, this.stat});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          statType,
          style: TextStyle(
            color:Color(0xffdf304b),
            fontWeight: FontWeight.bold,
            fontSize:20.0,
          ),
        ),
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(size)),
          child: Center(
            child: Text(
              stat,
              style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 20.0
              ),
            ),
          ),
        ),
      ],
    );
  }
}
