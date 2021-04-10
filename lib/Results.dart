import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  int placement = 1;
  int total = 50;
  int elo = 15;

  int miletime = 670;
  int pushups = 20;
  int crunches = 40;

  bool gain = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // == SPACE ==
              Container(
                height: 50,
              ),

              // == PLACEMENT ==
              Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  border: Border.all(color: Colors.black38),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: const Offset(
                        3.0,
                        3.0,
                      ),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text("$placement/$total",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 46),
                  ),
                ),
              ),

              // == SPACE ==
              Container(
                height: 15,
              ),

              // == ELO ==
              Text(
                  elo>0?"+$elo EXP":"$elo EXP",
                      style: TextStyle(fontSize: 20),
                ),

              // == SPACE ==
              Container(
                height: 70,
              ),

              // == MILE TIME ==
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: <Widget>[
                      Text(" Mile Time:",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Text("${(miletime/60).round()}:${NumberFormat("00").format(miletime%60)} ",
                        style: TextStyle(fontSize: 22))
                    ],
                  ),
                  ),
                ],
                ),

              // == PUSH UPS ==
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: <Widget>[
                        Text(" Push Ups:",
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        Text("$pushups ",
                            style: TextStyle(fontSize: 22))
                      ],
                    ),
                  ),
                ],
              ),

              // == CRUNCHES ==
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: <Widget>[
                        Text(" Crunches:",
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        Text("$crunches ",
                            style: TextStyle(fontSize: 22))
                      ],
                    ),
                  ),
                ],
              ),

              // == SPACE ==
              Container(
                height: 55,
              ),

              // == HOME BUTTON ==
              Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orangeAccent,
                    ),
                    child: Text('OK',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      print('Link to home');
                    },
                  )
              ),


            ],

        )

      )
    );
  }
}
