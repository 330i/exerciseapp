import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Competitions extends StatefulWidget {
  @override
  _CompetitionsState createState() => _CompetitionsState();
}

class _CompetitionsState extends State<Competitions> {
  bool _value1 = false;
  bool _value2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/img/running.jpg"),
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
                  fit: BoxFit.cover
              ),
          ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // == BUTTON ==
                Container(
                  height: 170,
                  width: 170,
                  margin: const EdgeInsets.only(top: 100.0),
                  child: ElevatedButton(
                      child: Center(child: Text('Find a Competition', style: TextStyle(fontWeight: FontWeight.bold))),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Colors.deepOrangeAccent,
                        onPrimary: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 10,
                        side: BorderSide(color: Colors.black26, width: 1),
                      ),
                      onPressed: () {
                        print('Do Something');
                      }
                  ),
                ),

                // == RANKED ==
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.black38),
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
                    ],),
                  child: CheckboxListTile(
                    activeColor: Colors.deepOrange,
                    checkColor: Colors.white,
                    title: const Text('Ranked', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('A competitive event which will affect your ranking'),
                    value: _value1,
                    onChanged: (bool value) {
                      _value2 = false;
                      setState(() {
                        _value1 = value;
                      });
                    },

                  ),
                ),

                // == UNRANKED ==
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.black38),
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
                    ],),
                  child: CheckboxListTile(
                    activeColor: Colors.deepOrange,
                    checkColor: Colors.white,
                    title: const Text('Unranked', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('A casual event which will NOT affect your ranking'),
                    value: _value2,
                    onChanged: (bool value) {
                      _value1 = false;
                      setState(() {
                        _value2 = value;
                      });
                    },

                  ),
                )
              ],
            )
        )
    );
  }
}