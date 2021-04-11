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
                        color: Color(0xffff9800),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50.0),
                          bottomRight: Radius.circular(50.0),
                        ),
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
                                          fontWeight: FontWeight.w900,
                                          fontSize: 24.0,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 50.0),
                                child: UserMainStats(
                                  rank: snapshot.data['rank'].toString(),
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
