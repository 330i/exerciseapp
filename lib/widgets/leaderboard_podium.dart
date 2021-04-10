import 'package:flutter/material.dart';
import './pfp.dart';

class LeaderboardPodium extends StatelessWidget {
  final List<Map> topThree;
  LeaderboardPodium(this.topThree);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.red,
        height: 250.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Pfp(imageUrl: topThree[1]['pfp'], size: 60.0)
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 25.0),
              child: Column(
                children: [
                  Pfp(imageUrl: topThree[0]['pfp'], size: 80.0)
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Pfp(imageUrl: topThree[2]['pfp'], size: 60.0)
              ],
            )
          ],
        ));
  }
}
