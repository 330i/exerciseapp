import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).get(),
      builder: (context, userSnap) {
        if(!userSnap.hasData) {
          return Center(
            child: Container(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }
        else {
          if(userSnap.data['competition']=='') {
            return Center(
              child: Text('Join Competition'),
            );
          }
          else {
            return FutureBuilder(
              future: FirebaseFirestore.instance.collection('competitions').doc(userSnap.data['competition']).get(),
              builder: (context, snapshot) {
                if(!snapshot.hasData) {
                  return Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                else {
                  return Scaffold(
                    body: ListView(children: [
                      Container(
                        height: 10,
                      ),
                      Container(
                        color: Colors.white,
                        height: 50,
                        child: Row(
                          children: [
                            Spacer(
                              flex: 1,
                            ),
                            Text(
                              'Tournament Tracker',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                              ),
                            ),
                            Spacer(
                              flex: 5,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(height: 300, child: OpponentsListView()),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    _entryField("Mile time (in seconds)", mileTime),
                                    SizedBox(width: 10,),
                                    Container(
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: null,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrangeAccent[100]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  _entryField("Pushup in 1 Minute", pushup),
                                  SizedBox(width: 10,),
                                  Container(
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: null,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrangeAccent[100]),
                                      ),
                                    ),
                                  ),
                                ]),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    _entryField("Crunches in 1 Minute", crunches),
                                    SizedBox(width: 10,),
                                    Container(
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: null,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrangeAccent[100]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
                  );
                }
              },
            );
          }
        }
      },
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
            fontWeight: FontWeight.w300,
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
