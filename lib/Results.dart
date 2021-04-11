import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  // placeholder numbers
  int placement = 1;
  int total = 50;
  int elo = 15;

  int miletime = 670;
  int pushups = 20;
  int crunches = 40;

  bool gain = true; // if person gains exp or not

  ConfettiController _controllerCenterRight =  ConfettiController(duration: const Duration(seconds: 1));
  ConfettiController _controllerCenterLeft =   ConfettiController(duration: const Duration(seconds: 1));
  ConfettiController _controllerTopCenter = ConfettiController(duration: const Duration(seconds: 1));

  @override
  void initState() {


    super.initState();
    _controllerCenterRight.play();
    _controllerCenterLeft.play();
    _controllerTopCenter.play();
  }

  @override
  void dispose() {
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    _controllerTopCenter.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              //CENTER -- Blast
                Container(
                  child: Center(
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
                                  print('yes');
                                },
                              )
                          ),


                        ],

                      )

                  ),
                ),


              //CENTER RIGHT -- Emit left
              Align(
                alignment: Alignment.centerRight,
                child: ConfettiWidget(
                  confettiController: _controllerCenterRight,
                  blastDirection: pi,
                  particleDrag: 0.05,
                  emissionFrequency: 0.05,
                  numberOfParticles: 10,
                  gravity: 0.05,
                  shouldLoop: false,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink
                  ], // manually specify the colors to be used
                ),
              ),

              //CENTER LEFT - Emit right
              Align(
                alignment: Alignment.centerLeft,
                child: ConfettiWidget(
                  confettiController: _controllerCenterLeft,
                  blastDirection: 0, // radial value - RIGHT
                  emissionFrequency: 0.6,
                  minimumSize: const Size(10,
                      10), // set the minimum potential size for the confetti (width, height)
                  maximumSize: const Size(50,
                      50), // set the maximum potential size for the confetti (width, height)
                  numberOfParticles: 1,
                  gravity: 0.1,
                ),
              ),

              //TOP CENTER - shoot down
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _controllerTopCenter,
                  blastDirection: pi / 2,
                  maxBlastForce: 5, // set a lower max blast force
                  minBlastForce: 2, // set a lower min blast force
                  emissionFrequency: 0.05,
                  numberOfParticles: 10, // a lot of particles at once
                  gravity: 1,
                ),
              ),


            ],
          ),
        ),
    );
  }
}

