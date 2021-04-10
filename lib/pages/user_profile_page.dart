import 'package:flutter/material.dart';
import '../widgets/pfp.dart';
import '../widgets/user_stats_box.dart';
import '../widgets/user_stats_circle.dart';
import '../widgets/user_main_stats.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  var user = {
    "rank": 1,
    "pfp": "https://i.imgur.com/AtjuEkK.png",
    "username": "Bob",
    "score": 1000,
    "mile_time": "13:00",
    "pushup_per_min": 50,
    "crunches_per_min": 50,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    UserStatsBox(
                      stat: user["mile_time"].toString(),
                      statType: 'Mile Time',
                    ),
                    UserStatsBox(
                      stat: user['pushup_per_min'].toString(),
                      statType: 'Pushups',
                    ),
                    UserStatsBox(
                      stat: user['crunches_per_min'].toString(),
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
                height: MediaQuery.of(context).size.height * 0.65,
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
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 4.0, color: Colors.white),
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: Pfp(imageUrl: user['pfp'], size: 100.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: 8.0,
                              ),
                              child: Text(
                                user['username'],
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
                          child: UserMainStats(),
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
}
