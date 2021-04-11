import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:exerciseapp/themes.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';


class OpponentsListView extends StatefulWidget {
  @override
  _OpponentsListViewState createState() => _OpponentsListViewState();
}

class _OpponentsListViewState extends State<OpponentsListView> {

  List<OpponentListData> opList = [];

  getOpponentListData() async {
    List<OpponentListData> opponentList = [];
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).get().then((userData) async {
      await FirebaseFirestore.instance.collection('competitions').doc(userData.data()['competition']).collection('competitors').get().then((competitorData) async {
        for(var i=0;i<competitorData.size;i++) {
          String photoUrl = await FirebaseStorage.instance.ref(competitorData.docs[i].data()['photo']).getDownloadURL();
          opponentList.add(
            OpponentListData(
              titleTxt: competitorData.docs[i].data()['name'],
              score: (competitorData.docs[i].data()['score']).round(),
              stats: <String>["${(competitorData.docs[i].data()['mile']/60).floor()}:${NumberFormat('00.##').format(competitorData.docs[i].data()['mile']%60)}","${competitorData.docs[i].data()['pushup']}", "${competitorData.docs[i].data()['crunch']}"],
              startColor: '#FA7D82',
              endColor: '#FFB295',
              photo: photoUrl,
            ),
          );
        }
      });
    });
    print(opponentList.length);
    setState(() {
      opList = opponentList;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getOpponentListData();
    if(opList==null) {
      return Center(
        child: Container(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(),
        ),
      );
    }
    else {
      final int count =
      opList.length > 10 ? 10 : opList.length;
      return Container(
        height: 216,
        width: double.infinity,
        child: ListView.builder(
          padding: const EdgeInsets.only(
              top: 0, bottom: 0, right: 16, left: 16),
          itemCount: count,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return OpponentsView(
              opponentsListData: opList[index],
            );
          },
        ),
      );
    }
  }
}

class OpponentsView extends StatelessWidget {
  const OpponentsView(
      {Key key, this.opponentsListData})
      : super(key: key);

  final OpponentListData opponentsListData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 32, left: 8, right: 8, bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: HexColor(opponentsListData.endColor)
                                  .withOpacity(0.6),
                              offset: const Offset(1.1, 4.0),
                              blurRadius: 8.0),
                        ],
                        gradient: LinearGradient(
                          colors: <HexColor>[
                            HexColor(opponentsListData.startColor),
                            HexColor(opponentsListData.endColor),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(54.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 54, left: 16, right: 16, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              opponentsListData.titleTxt,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 0.2,
                                color: FitnessAppTheme.white,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(top: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Mile: \nPushup: \nCrunch: ',
                                      style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        letterSpacing: 0.2,
                                        color: FitnessAppTheme.white,
                                      ),
                                    ),
                                    Text(
                                      opponentsListData.stats.join('\n'),
                                      style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        letterSpacing: 0.2,
                                        color: FitnessAppTheme.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  opponentsListData.score.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24,
                                    letterSpacing: 0.2,
                                    color: FitnessAppTheme.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4, bottom: 3),
                                  child: Text(
                                    'Score',
                                    style: TextStyle(
                                      fontFamily:
                                      FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      letterSpacing: 0.2,
                                      color: FitnessAppTheme.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Stack(
                      children: [
                        Container(
                          width: 84,
                          height: 84,
                          decoration: BoxDecoration(
                            color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          child: Container(
                            child: Image.network(
                              opponentsListData.photo,
                              fit: BoxFit.cover,
                            ),
                            width: 84,
                            height: 84,
                            decoration: BoxDecoration(
                              color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(42),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 8,
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      //child: Image.asset(opponentsListData.imagePath),
                    ),
                  )
                ],
              ),
            );
  }
}

class OpponentListData {
  OpponentListData({
    //this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.stats,
    this.score = 0,
    this.photo = '',
  });

  //String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String> stats;
  int score;
  String photo;
}