import 'package:flutter/material.dart';
import '../pfp.dart';
import '../hexPfp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardSlot extends StatelessWidget {
  final QueryDocumentSnapshot slot;
  final int rank;
  LeaderboardSlot(this.slot, this.rank);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 25.0),
            child: Text(rank.toString(),
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w800)),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0),
            child: Pfp(
              imageUrl: slot['photo'],
              size: 50.0,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25.0),
            child: Text(slot['username'],
                style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700)),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 25.0),
            child: Text(slot['score'].toString(),
                style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w800)),
          )
        ],
      ),
    );
  }
}
