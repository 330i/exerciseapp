import 'package:flutter/material.dart';
import '../widgets/top_bar/top_bar.dart';
import '../widgets/leaderboard_podium.dart';
import '../widgets/leaderboard_list/leaderboard_list.dart';

class GlobalUsersPage extends StatefulWidget {
  @override
  _GlobalUsersPageState createState() => _GlobalUsersPageState();
}

class _GlobalUsersPageState extends State<GlobalUsersPage> {
  var leaderboard = [
    {
      "rank": 1,
      "pfp": "https://uifaces.co/our-content/donated/gPZwCbdS.jpg",
      "username": "Bob",
      "xp": 1000
    },
    {
      "rank": 2,
      "pfp": "https://upload.wikimedia.org/wikipedia/commons/a/a0/Pierre-Person.jpg",
      "username": "Joe",
      "xp": 999
    },
    {
      "rank": 3,
      "pfp": "https://i.pinimg.com/originals/ae/ec/c2/aeecc22a67dac7987a80ac0724658493.jpg",
      "username": "George",
      "xp": 998
    },
    {
      "rank": 4,
      "pfp": "https://i.imgur.com/AtjuEkK.png",
      "username": "Jack",
      "xp": 997
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Topbar(
            userPfp: 'https://i.imgur.com/AtjuEkK.png',
          ),
          LeaderboardPodium(leaderboard.sublist(0,3)),
          Expanded(
            child: LeaderboardList(leaderboard.sublist(4)),
          )
        ],
      ),
    ));
  }
}
