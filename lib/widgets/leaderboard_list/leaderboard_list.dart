import 'package:flutter/material.dart';
import './leaderboard_slot.dart';

class LeaderboardList extends StatelessWidget {
  final List<Map> leaderboard;
  LeaderboardList(this.leaderboard);

  Widget _buildSlot(Map slot) {
    return LeaderboardSlot(slot);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
            children:
                leaderboard.map((Map slot) => _buildSlot(slot))));
  }
}
