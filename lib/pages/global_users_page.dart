import 'package:flutter/material.dart';
import '../widgets/leaderboard_podium/leaderboard_podium.dart';
import '../widgets/leaderboard_list/leaderboard_list.dart';

class GlobalUsersPage extends StatefulWidget {
  @override
  _GlobalUsersPageState createState() => _GlobalUsersPageState();
}

class _GlobalUsersPageState extends State<GlobalUsersPage> {
  var leaderboard = [
    {
      "rank": 1,
      "pfp": "https://i.imgur.com/AtjuEkK.png",
      "username": "Bob",
      "score": 1000
    },
    {
      "rank": 2,
      "pfp": "https://i.imgur.com/AtjuEkK.png",
      "username": "Joe",
      "score": 999
    },
    {
      "rank": 3,
      "pfp": "https://i.imgur.com/AtjuEkK.png",
      "username": "George",
      "score": 998
    },
    {
      "rank": 4,
      "pfp": "https://i.imgur.com/AtjuEkK.png",
      "username": "Jack",
      "score": 997
    },
    {
      "rank": 5,
      "pfp": "https://i.imgur.com/AtjuEkK.png",
      "username": "Jack",
      "score": 997
    },
    {
      "rank": 6,
      "pfp": "https://i.imgur.com/AtjuEkK.png",
      "username": "Jack",
      "score": 997
    },
    {
      "rank": 7,
      "pfp": "https://i.imgur.com/AtjuEkK.png",
      "username": "Jack",
      "score": 997
    },
    {
      "rank": 8,
      "pfp": "https://i.imgur.com/AtjuEkK.png",
      "username": "Jack",
      "score": 997
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Stack(
              children: [
                LeaderboardPodium(leaderboard.sublist(0, 3)),
                Positioned(
                    width: MediaQuery.of(context).size.width,
                    height: 480.0,
                    bottom: 10,
                    child: Container(
                      decoration: BoxDecoration(color: Color(0xffff9800)),
                      child: LeaderboardList(leaderboard.sublist(0)),
                    )),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
