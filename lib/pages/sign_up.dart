import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerciseapp/model/user.dart';
import 'package:exerciseapp/pages/place_holder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:exerciseapp/widgets/bezier_container.dart';
import 'package:validators/sanitizers.dart';
import 'login_page.dart';
import 'place_holder.dart';

import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController username = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController mileTime = new TextEditingController();
  TextEditingController pushups = new TextEditingController();
  TextEditingController crunches = new TextEditingController();
  String url;


  @override
  void initState(){

    super.initState();
  }

  setUser(BuildContext context) async{
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text).then((currentUser) {
      FirebaseFirestore.instance.collection('users').doc(currentUser.user.uid).set(Athlete(
        username: username.text,
        email: email.text,
        uid: currentUser.user.uid,
        url: url,
        rank: 1,
        mile: toDouble(mileTime.text),
        pushup: toInt(pushups.text),
        crunch: toInt(crunches.text),
      ).toJson());
    });




    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlaceHolder()),
    );
  }




  Widget _entryField(String title, TextEditingController controller, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return TextButton(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.orangeAccent[100], Colors.orangeAccent[200]])),
        child: Text(
          'Register Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      onPressed: () {
        setUser(context);
      },
    );
  }



  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Step',
          style: TextStyle(color: Colors.orange, fontSize: 30),
          children: [
            TextSpan(
              text: ' by ',
              style: TextStyle(color: Colors.red, fontSize: 30),
              children: [TextSpan(
                text: 'Step',
                style: TextStyle(color: Colors.orange, fontSize: 30),
                )
              ]
            ),
          ]),
    );
  }



  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Username", username),
        _entryField("Email", email),
        _entryField("Password", password, isPassword: true),
        _entryField("Mile Time", mileTime),
        _entryField("Pushups in 1 minute", pushups),
        _entryField("Crunches in 1 minute", crunches,),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(context),
                    SizedBox(height: height * .01),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}