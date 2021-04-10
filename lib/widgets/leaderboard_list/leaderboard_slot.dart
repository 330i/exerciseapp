import 'package:flutter/material.dart';

class LeaderboardSlot extends StatelessWidget {
  final Map slot;
  LeaderboardSlot(this.slot);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('this is a leaderboard slot'),
    );
  }
}
