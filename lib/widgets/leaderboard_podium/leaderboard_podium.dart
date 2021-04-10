import 'package:flutter/material.dart';
import './podium_spot.dart';

class LeaderboardPodium extends StatelessWidget {
  final List<Map> topThree;
  LeaderboardPodium(this.topThree);

  Widget _podiumSpotBuilder({username, pfpSize, pfpUrl, score, rank}) {
    return PodiumSpot(
      username: username,
      pfpSize: pfpSize,
      pfpUrl: pfpUrl,
      score: score.toString(),
      rank: rank,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Color(0xffff9800),
        height: 355.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              _podiumSpotBuilder(
                  pfpSize: 60.0,
                  pfpUrl: topThree[1]['photo'],
                  username: topThree[1]['username'],
                  score: topThree[1]['score'],
                  rank: 2)
            ]),
            Container(
                margin: EdgeInsets.only(top: 60.0),
                child: _podiumSpotBuilder(
                    pfpSize: 90.0,
                    pfpUrl: topThree[0]['photo'],
                    username: topThree[0]['username'],
                    score: topThree[0]['score'],
                    rank: 1)),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              _podiumSpotBuilder(
                  pfpSize: 60.0,
                  pfpUrl: topThree[2]['photo'],
                  username: topThree[2]['username'],
                  score: topThree[2]['score'],
                  rank: 3)
            ])
          ],
        ));
  }
}
