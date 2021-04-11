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
              topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0))),
      child: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Container(
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
    );
  }
}
