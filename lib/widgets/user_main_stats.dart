import 'package:flutter/material.dart';

class UserMainStats extends StatelessWidget {
  final String rank;
  final String score;
  UserMainStats({this.rank, this.score});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * .8,
      height: 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(rank,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25.0,
                      color: Colors.white)),
              Text("Rank",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17.0,
                      color: Colors.white))
            ],
          ),
          VerticalDivider(
            width: 50,
            color: Colors.white,
            thickness: 1.5,
          ),
          Column(
            children: [
              Text(score,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25.0,
                      color: Colors.white)),
              Text("Score",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17.0,
                      color: Colors.white))
            ],
          )
        ],
      ),
    );
  }
}
