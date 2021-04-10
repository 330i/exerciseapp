import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  String username;
  String email;
  String uid;
  String url;
  int rank;
  double mile;
  int pushup;
  int crunch;

  DocumentReference reference;

  User({this.username, this.email, this.uid, this.url, this.rank, this.mile, this.pushup, this.crunch});

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    User newUser = User.fromJson(snapshot.data);
    newUser.reference = snapshot.reference;
    return newUser;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] as String,
      email: json['email'] as String,
      uid: json['uid'] as String,
      url: json['photo'] as String,
      rank: json['rank'] as int,
      mile: json['mile'] as double,
      pushup: json['pushup'] as int,
      crunch: json['crunch'] as int,
    );
  }

  Map<String, dynamic> toJson() => _UserToJson(this);

  Map<String, dynamic> _UserToJson(User instance) {
    return <String, dynamic> {
      'username': instance.username,
      'email': instance.email,
      'uid': instance.uid,
      'photo': instance.url,
      'rank': instance.rank,
      'mile': instance.mile,
      'pushup': instance.pushup,
      'crunch': instance.crunch,
    };
  }

}