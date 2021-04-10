import 'package:flutter/material.dart';
import '../pfp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PodiumSpot extends StatelessWidget {
  final String pfpUrl;
  final double pfpSize;
  final String username;
  final String xp;
  final int rank;
  PodiumSpot({this.pfpUrl, this.pfpSize, this.username, this.xp, this.rank});

  Widget _crownBuilder(int rank) {
    switch (rank) {
      case 1:
        return Icon(FontAwesomeIcons.crown,
            size: 15.0, color: Colors.yellowAccent);
      case 2:
        return Icon(FontAwesomeIcons.crown,
            size: 15.0, color: Colors.blueAccent);
      case 3:
        return Icon(FontAwesomeIcons.crown,
            size: 15.0, color: Colors.redAccent);
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
        _crownBuilder(rank),
        Pfp(imageUrl: pfpUrl, size: pfpSize),
        Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Text(username),
        ),
        Container(
          margin: EdgeInsets.only(top: 5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(width: 5.0, color: Colors.white)),
          alignment: Alignment.center,
          child: Text(xp),
        )
      ],
    ));
  }
}
