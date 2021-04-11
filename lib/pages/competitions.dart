import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Competitions extends StatefulWidget {
  @override
  _CompetitionsState createState() => _CompetitionsState();
}
enum TourType{ranked, unranked, custom}

class _CompetitionsState extends State<Competitions> {

  TourType _selectedType = TourType.unranked;

  findCompetition() async {
    int type;
    if(_selectedType==TourType.ranked)
      type = 1;
    if(_selectedType==TourType.unranked)
      type = 2;
    if(_selectedType==TourType.custom)
      type = 3;

    FirebaseFirestore.instance.collection('competitions').where('type',isEqualTo: type).get().then((competitionValue) async {
      if(type!=3) {
        if(competitionValue.size!=0) {
          bool play = false;
          int currentCount = 0;
          while(!play) {
            await FirebaseFirestore.instance.collection('competitions').doc(competitionValue.docs[currentCount].id).collection('competitors').get().then((compDoc) async {
              if(compDoc.size<50) {
                print(currentCount);
                play = true;
                await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).get().then((userValue) {
                  print(currentCount);
                  FirebaseFirestore.instance.collection('competitions').doc(competitionValue.docs[currentCount].id).collection('competitors').doc(FirebaseAuth.instance.currentUser.uid).set({
                    'name': userValue.data()['username'],
                    'uid': FirebaseAuth.instance.currentUser.uid,
                    'photo': userValue.data()['photo'],
                    'mile': userValue.data()['mile'],
                    'pushup': userValue.data()['pushup'],
                    'crunch': userValue.data()['crunch'],
                    'score': 0,
                  });
                  print(currentCount);
                  FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).update({
                    'competition': competitionValue.docs[currentCount].id,
                  });
                });
              }
              currentCount++;
            });
          }
        }
        else {
          FirebaseFirestore.instance.collection('competitions').add({
            'type': type,
          }).then((compDoc) {
            FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).get().then((userValue) {
              compDoc.collection('competitors').doc(FirebaseAuth.instance.currentUser.uid).set({
                'name': userValue.data()['username'],
                'uid': FirebaseAuth.instance.currentUser.uid,
                'photo': userValue.data()['photo'],
                'mile': userValue.data()['mile'],
                'pushup': userValue.data()['pushup'],
                'crunch': userValue.data()['crunch'],
                'score': 0,
              });
              FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).update({
                'competition': compDoc.id,
              });
            });
          });
        }
      }
      else {
        TextEditingController roomCode = new TextEditingController();
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text('Join/Create Tournament'),
              content: TextField(
                controller: roomCode,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if(roomCode.text.isNotEmpty) {
                      joinCustomRoom(roomCode.text);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Join'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  joinCustomRoom(String currentRoomCode) async {
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('competitions').doc(currentRoomCode).get();
    if(snap.exists) {
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).get().then((userValue) {
        FirebaseFirestore.instance.collection('competitions').doc(currentRoomCode).collection('competitors').doc(FirebaseAuth.instance.currentUser.uid).set({
          'name': userValue.data()['username'],
          'uid': FirebaseAuth.instance.currentUser.uid,
          'photo': userValue.data()['photo'],
          'mile': userValue.data()['mile'],
          'pushup': userValue.data()['pushup'],
          'crunch': userValue.data()['crunch'],
          'score': 0,
        });
        FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).update({
          'competition': currentRoomCode,
        });
      });
    }
    else {
      FirebaseFirestore.instance.collection('competitions').doc(currentRoomCode).set({
        'type': 3,
      }).whenComplete(() {
        FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).get().then((userValue) {
          FirebaseFirestore.instance.collection('competitions').doc(currentRoomCode).collection('competitors').doc(FirebaseAuth.instance.currentUser.uid).set({
            'name': userValue.data()['username'],
            'uid': FirebaseAuth.instance.currentUser.uid,
            'photo': userValue.data()['photo'],
            'mile': userValue.data()['mile'],
            'pushup': userValue.data()['pushup'],
            'crunch': userValue.data()['crunch'],
            'score': 0,
          });
          FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).update({
            'competition': currentRoomCode,
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // == BUTTON ==
                Container(
                  height: 170,
                  width: 170,
                  margin: const EdgeInsets.only(top: 100.0),
                  child: ElevatedButton(
                      child: Center(child: Text('Join a Competition', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: (Colors.orangeAccent),
                        onPrimary: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 10,
                        side: BorderSide(color: Colors.black26, width: 1),
                      ),
                      onPressed: () {
                        print('Find Stuff');
                        findCompetition();
                      }
                  ),
                ),

                // == SPACE ==
                Container(
                  height: 100,
                ),

                // == RANKED ==
                Container(
                  child: RadioListTile<TourType>(
                    activeColor: Colors.orangeAccent,
                    title: const Text('Ranked', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('A competitive event which will affect your ranking'),
                    groupValue: _selectedType,
                    value: TourType.ranked,
                    onChanged: (TourType value) {
                      setState(() {
                        _selectedType = value;
                      });
                    },
                  ),
                ),

                // == DIVIDER ==
                Divider(
                  indent: MediaQuery.of(context).size.width*0.04,
                  endIndent: MediaQuery.of(context).size.width*0.04,
                  color: Colors.grey,
                ),

                // == UNRANKED ==
                Container(
                  child: RadioListTile<TourType>(
                    activeColor: Colors.orangeAccent,
                    title: const Text('Unranked', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('A casual event which will NOT affect your ranking'),
                    groupValue: _selectedType,
                    value: TourType.unranked,

                    onChanged: (TourType value) {
                      setState(() {
                        _selectedType = value;
                      });
                    },
                  ),
                ),

                // == DIVIDER ==
                Divider(
                  indent: MediaQuery.of(context).size.width*0.04,
                  endIndent: MediaQuery.of(context).size.width*0.04,
                  color: Colors.grey,
                ),

                // == CUSTOM ==
                Container(
                  child: RadioListTile<TourType>(
                    activeColor: Colors.orangeAccent,
                    title: const Text('Custom', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('A custom event which will NOT affect your ranking'),
                    groupValue: _selectedType,
                    value: TourType.custom,
                    onChanged: (TourType value) {
                      setState(() {
                        _selectedType = value;
                      });
                    },
                  ),
                ),
              ],
            )
        )
    );
  }
}