import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/hexPfp.dart';
import '../widgets/user_stats_box.dart';
import '../widgets/user_main_stats.dart';
import 'package:exerciseapp/model/user.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  int calculateLevel(int score) {
    int leftScore = score;
    int level = 0;
    while(leftScore>0) {
      if(level<100){
        leftScore -= ((1/8)*level*level).round();
        level++;
      }
      else {
        leftScore -= ((10)*sqrt(leftScore-100)+1250).round();
      }
    }
    return level;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).get(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return Center(
            child: Container(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }
        else {
          print(snapshot.data['score']);
          return Scaffold(
            body: SizedBox.expand(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          UserStatsBox(
                            stat: "${((snapshot.data['mile']) ~/ 60).toString()}:${NumberFormat('00.##').format((snapshot.data['mile']) % 60)}",
                            statType: 'Mile Time',
                          ),
                          UserStatsBox(
                            stat: snapshot.data['pushup'].toString(),
                            statType: 'Pushups',
                          ),
                          UserStatsBox(
                            stat: snapshot.data['crunch'].toString(),
                            statType: 'Crunches',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FutureBuilder(
                                future: FirebaseStorage.instance.ref(snapshot.data['photo']).getDownloadURL(),
                                builder: (context, photoSnap) {
                                  if(!photoSnap.hasData) {
                                    return Container();
                                  }
                                  else {
                                    return HexPfp(imageUrl: photoSnap.data, size: 125.0);
                                  }
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 10.0,
                                    ),
                                    child: Text(
                                      snapshot.data['username'],
                                      style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 50.0),
                                child: UserMainStats(
                                  rank: calculateLevel((snapshot.data['score'])).toString(),
                                  score: snapshot.data['score'].toString(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
