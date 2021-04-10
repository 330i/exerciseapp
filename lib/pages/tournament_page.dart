import 'package:flutter/material.dart';
import 'package:exerciseapp/widgets/opponent_listView.dart';

class TournamentPage extends StatefulWidget {
  @override
  _TournamentPageState createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 300,
              child: OpponentsListView()
            )
          ],
        ),
      ),
    );
  }
}
