import 'package:flutter/material.dart';
import '../hexPfp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PodiumSpot extends StatelessWidget {
  final String pfpUrl;
  final double pfpSize;
  final String username;
  final String score;
  final int rank;
  PodiumSpot({this.pfpUrl, this.pfpSize, this.username, this.score, this.rank});

  Widget _crownBuilder(int rank) {
    switch (rank) {
      case 1:
        return Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(5.0)),
            child: Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 3.2, bottom: 2.0),
                  child: Icon(FontAwesomeIcons.crown,
                      size: 18.0, color: Colors.yellow),
                )));
      case 2:
        return Container(
            width: 22.0,
            height: 22.0,
            decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(5.0)),
            child: Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 3.2, bottom: 1.0),
                  child: Icon(FontAwesomeIcons.crown,
                      size: 13.0, color: Colors.redAccent),
                )));
      case 3:
        return Container(
            width: 22.0,
            height: 22.0,
            decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(5.0)),
            child: Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 3.2, bottom: 1.0),
                  child: Icon(FontAwesomeIcons.crown,
                      size: 13.0, color: Colors.white),
                )));
      default:
        return Icon(FontAwesomeIcons.crown,
            size: 15.0, color: Colors.yellowAccent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                HexPfp(imageUrl: pfpUrl, size: pfpSize),
                Positioned(right: 0.0, top: 0.0, child: _crownBuilder(rank)),
              ],
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 80.0, maxHeight: 100),
              margin: EdgeInsets.only(top: 5.0),
              child: Text(
                username,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 30.0,
              width: 45.0,
              margin: EdgeInsets.only(top: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [Color(0xffff6174), Color(0xfffd795e)]),
              ),
              alignment: Alignment.center,
              child: Text(score,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
            )
          ],
        ));
  }
}