import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerciseapp/pages/competitions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:exerciseapp/widgets/opponent_listView.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui';

import 'package:validators/sanitizers.dart';

class TournamentPage extends StatefulWidget {
  @override
  _TournamentPageState createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> {
  TextEditingController mileTime = new TextEditingController();
  TextEditingController pushup = new TextEditingController();
  TextEditingController crunches = new TextEditingController();

  setVideo(int type) async {
    File _videoFile;
    PickedFile _pickedImage = await ImagePicker().getVideo(source: ImageSource.gallery);
    setState(() {
      _videoFile = File(_pickedImage.path);
    });
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).get().then((userValue) {
      DocumentReference reference = FirebaseFirestore.instance.collection('competitions').doc(userValue.data()['competition']).collection('competitors').doc(FirebaseAuth.instance.currentUser.uid).collection('videos').doc();
      reference.set({
        'type': type,
        'location':'${FirebaseAuth.instance.currentUser.uid}/${userValue.data()['competition']}/${reference.id}'
      }).whenComplete(() {
        FirebaseStorage.instance.ref().child('${FirebaseAuth.instance.currentUser.uid}').child(userValue.data()['competition']).child(reference.id).putFile(_videoFile);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).snapshots(),
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
              child: Competitions(),
            );
          }
          else {
            return StreamBuilder(
              stream: FirebaseFirestore.instance.collection('competitions').doc(userSnap.data['competition']).snapshots(),
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
                        color: Colors.white,
                        height: 10,
                      ),
                      Container(
                        color: Colors.white,
                        height: 50,
                        child: Row(
                          children: [
                            Container(
                              width: 25,
                            ),
                            Text(
                              snapshot.data['type']==3?userSnap.data['competition']:'Tournament',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                              ),
                            ),
                            Spacer(
                              flex: 1,
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    _entryField("Mile time (in seconds)", mileTime),
                                    SizedBox(width: 10,),
                                    Column(
                                      children: [
                                        Container(
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if(mileTime.text.isNotEmpty) {
                                                FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).update({
                                                  'mile':toDouble(mileTime.text),
                                                }).then((value) {
                                                  print('${pow(2,(-0.005)*(userSnap.data['mile']-1550))}+${(1/100)*pow(userSnap.data['crunch'], 2)}+${(1/3)*pow(userSnap.data['pushup'], 1.5)}');
                                                  FirebaseFirestore.instance.collection('competitions').doc(userSnap.data['competition']).collection('competitors').doc(FirebaseAuth.instance.currentUser.uid).update({
                                                    'mile': toDouble(mileTime.text),
                                                    'score': pow(2,(-0.005)*(userSnap.data['mile']-1550))+(1/100)*pow(userSnap.data['crunch'], 2)+(1/3)*pow(userSnap.data['pushup'], 1.5),
                                                  });
                                                });
                                                setVideo(1);
                                              }
                                            },
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
                                        Container(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    _entryField("Pushup in 1 Minute", pushup),
                                    SizedBox(width: 10,),
                                    Column(
                                      children: [
                                        Container(
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if(pushup.text.isNotEmpty) {
                                                FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).update({
                                                  'pushup':toInt(pushup.text),
                                                }).then((value) {
                                                  FirebaseFirestore.instance.collection('competitions').doc(userSnap.data['competition']).collection('competitors').doc(FirebaseAuth.instance.currentUser.uid).update({
                                                    'pushup': toInt(pushup.text),
                                                    'score': pow(2,(-0.005)*(userSnap.data['mile']-1550))+(1/100)*pow(userSnap.data['crunch'], 2)+(1/3)*pow(userSnap.data['pushup'], 1.5),
                                                  });
                                                });
                                                setVideo(1);
                                              }
                                            },
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
                                        Container(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    _entryField("Crunches in 1 Minute", crunches),
                                    SizedBox(width: 10,),
                                    Column(
                                      children: [
                                        Container(
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if(crunches.text.isNotEmpty) {
                                                FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).update({
                                                  'crunch':toInt(crunches.text),
                                                }).then((value) {
                                                  FirebaseFirestore.instance.collection('competitions').doc(userSnap.data['competition']).collection('competitors').doc(FirebaseAuth.instance.currentUser.uid).update({
                                                    'crunch': toInt(crunches.text),
                                                    'score': pow(2,(-0.005)*(userSnap.data['mile']-1550))+(1/100)*pow(userSnap.data['crunch'], 2)+(1/3)*pow(userSnap.data['pushup'], 1.5),
                                                  });
                                                });
                                                setVideo(1);
                                              }
                                            },
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
                                        Container(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 20,
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
    height: 90,
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
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                fillColor: Colors.orange[100],
                border: InputBorder.none,
                filled: true))
      ],
    ),
  );
}
