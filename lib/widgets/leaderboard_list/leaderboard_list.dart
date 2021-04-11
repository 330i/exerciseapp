import 'package:flutter/material.dart';
import './leaderboard_slot.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardList extends StatelessWidget {
  final List<QueryDocumentSnapshot> leaderboard;
  LeaderboardList(this.leaderboard);

  Widget _buildSlot(QueryDocumentSnapshot slot, rank) {
    return LeaderboardSlot(slot, rank);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      child: Container(
        height: 375,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 15,
                ),
                Text(
                  'Place',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                Spacer(flex: 1,),
                Text(
                  'Score',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                Container(
                  width: 25,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Container(
                height: 334,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.zero,
                  children: [
                    ...leaderboard.map((QueryDocumentSnapshot slot) {
                      return _buildSlot(slot, leaderboard.indexOf(slot) + 1);
                    })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
