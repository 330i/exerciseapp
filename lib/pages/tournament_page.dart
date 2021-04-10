import 'package:flutter/material.dart';
import 'package:exerciseapp/widgets/opponent_listView.dart';
import 'dart:ui';

class TournamentPage extends StatefulWidget {
  @override
  _TournamentPageState createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> {
  TextEditingController mileTime = new TextEditingController();
  TextEditingController pushup = new TextEditingController();
  TextEditingController crunches = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Tournament Tracker",
            style: TextStyle(
                color: Colors.orangeAccent,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic)),
        backgroundColor: Colors.white,
      ),
      body: ListView(children: [
        Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(height: 300, child: OpponentsListView()),
              Column(
                children: [
                  Row(children: [
                    SizedBox(
                      width: 20,
                    ),
                    _entryField("Submit a mile time", mileTime),
                    SizedBox(width: 30,),
                    ElevatedButton.icon(onPressed: null, icon: Icon(Icons.add), label: Text(''))
                  ]),
                  Row(children: [
                    SizedBox(
                      width: 20,
                    ),
                    _entryField("Submit a pushup count", pushup),
                    SizedBox(width: 30,),
                    ElevatedButton.icon(onPressed: null, icon: Icon(Icons.add), label: Text(''))
                  ]),
                  Row(children: [
                    SizedBox(
                      width: 20,
                    ),
                    _entryField("Submit a crunch count", crunches),
                    SizedBox(width: 30,),
                    ElevatedButton.icon(onPressed: null, icon: Icon(Icons.add), label: Text(''))
                  ])
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

Widget _entryField(String title, TextEditingController controller) {
  return Container(
    height: 110,
    width: 250,
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: Colors.orange,
            fontStyle: FontStyle.italic
          ),
        ),
        SizedBox(height: 10),
        TextField(
            controller: controller,
            decoration: InputDecoration(
                fillColor: Colors.orange[100],
                border: InputBorder.none,
                filled: true))
      ],
    ),
  );
}
