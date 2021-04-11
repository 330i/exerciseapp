import 'package:cloud_firestore/cloud_firestore.dart';

class Athlete {

  String username;
  String email;
  String uid;
  String url;
  int score;
  double mile;
  int pushup;
  int crunch;
  String competition;

  DocumentReference reference;

  Athlete({this.username, this.email, this.uid, this.url, this.score, this.mile, this.pushup, this.crunch, this.competition});

  factory Athlete.fromSnapshot(DocumentSnapshot snapshot) {
    Athlete newUser = Athlete.fromJson(snapshot.data());
    newUser.reference = snapshot.reference;
    return newUser;
  }

  factory Athlete.fromJson(Map<String, dynamic> json) {
    return Athlete(
      username: json['username'] as String,
      email: json['email'] as String,
      uid: json['uid'] as String,
      url: json['photo'] as String,
      score: json['score'] as int,
      mile: json['mile'] as double,
      pushup: json['pushup'] as int,
      crunch: json['crunch'] as int,
      competition: json['competition'] as String,
    );
  }

  Map<String, dynamic> toJson() => _AthleteToJson(this);

  Map<String, dynamic> _AthleteToJson(Athlete instance) {
    return <String, dynamic> {
      'username': instance.username,
      'email': instance.email,
      'uid': instance.uid,
      'photo': instance.url,
      'score': instance.score,
      'mile': instance.mile,
      'pushup': instance.pushup,
      'crunch': instance.crunch,
      'competition' : instance.competition,
    };
  }

}