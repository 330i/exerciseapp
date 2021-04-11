import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/leaderboard_podium/leaderboard_podium.dart';
import '../widgets/leaderboard_list/leaderboard_list.dart';

class GlobalUsersPage extends StatefulWidget {
  @override
  _GlobalUsersPageState createState() => _GlobalUsersPageState();
}

class _GlobalUsersPageState extends State<GlobalUsersPage> {
  Widget _leaderboardPageBuilder(List<QueryDocumentSnapshot> leaderboard) {
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
                        height: 400.0,
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

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder(
      future: users.orderBy('score').limit(10).get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return _leaderboardPageBuilder(
                (snapshot.data as QuerySnapshot).docs.reversed.toList());
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}