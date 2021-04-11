import 'package:flutter/material.dart';
import '../widgets/pfp.dart';
import '../widgets/hexPfp.dart';
import '../widgets/user_stats_box.dart';
import '../widgets/user_main_stats.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  var user = {
    "rank": 1,
    'photo': "https://i.imgur.com/AtjuEkK.png",
    "username": "Bob",
    "score": 1001,
    "mile": 1545,
    "pushup": 50,
    "crunch": 50,
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
              height: MediaQuery.of(context).size.height * 0.4,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    UserStatsBox(
                      stat: "${((user['mile'] as int) ~/ 60).toString()}:${((user['mile'] as int) % 60).toString()}",
                      statType: 'Mile Time',
                    ),
                    UserStatsBox(
                      stat: user['pushup'].toString(),
                      statType: 'Pushups',
                    ),
                    UserStatsBox(
                      stat: user['crunch'].toString(),
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
                        HexPfp(imageUrl: user['photo'], size: 125.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: 10.0,
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
                          child: UserMainStats(
                            rank: user['rank'].toString(),
                            score: user['score'].toString(),
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
}
