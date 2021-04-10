import 'package:flutter/material.dart';
import './podium_spot.dart';

class LeaderboardPodium extends StatelessWidget {
  final List<Map> topThree;
  LeaderboardPodium(this.topThree);

  Widget _podiumSpotBuilder({username, pfpSize, pfpUrl, xp, rank}) {
    return PodiumSpot(
      username: username,
      pfpSize: pfpSize,
      pfpUrl: pfpUrl,
      xp: xp.toString(),
      rank: rank,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.orangeAccent,
        height: 355.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              _podiumSpotBuilder(
                  pfpSize: 60.0,
                  pfpUrl: topThree[1]['pfp'],
                  username: topThree[1]['username'],
                  xp: topThree[1]['xp'],
                  rank: 2)
            ]),
            Container(
                margin: EdgeInsets.only(top: 60.0),
                child: _podiumSpotBuilder(
                    pfpSize: 80.0,
                    pfpUrl: topThree[0]['pfp'],
                    username: topThree[0]['username'],
                    xp: topThree[0]['xp'],
                    rank: 1)),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              _podiumSpotBuilder(
                  pfpSize: 60.0,
                  pfpUrl: topThree[2]['pfp'],
                  username: topThree[2]['username'],
                  xp: topThree[2]['xp'],
                  rank: 3)
            ])
          ],
        ));
  }
}
