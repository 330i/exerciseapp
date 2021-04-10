import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exerciseapp/model/user.dart';
import 'package:exerciseapp/widgets/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validators/sanitizers.dart';
import 'login_page.dart';
import 'place_holder.dart';

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
  File _profileimg;
  FirebaseStorage _storage = FirebaseStorage.instance;


  @override
  void initState(){

    super.initState();
  }

  setUser(BuildContext context) async{
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text).then((currentUser) {
      FirebaseStorage.instance.ref().child('profilepicture').child('${currentUser.user.uid}').putFile(_profileimg);
      FirebaseFirestore.instance.collection('users').doc(currentUser.user.uid).set(Athlete(
        username: username.text,
        email: email.text,
        uid: currentUser.user.uid,
        url: _profileimg==null?'profilepicture/default.jpg':'profilepicture/${currentUser.user.uid}',
        rank: 1,
        mile: toDouble(mileTime.text),
        pushup: toInt(pushups.text),
        crunch: toInt(crunches.text),
        competition: '',
      ).toJson());
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomBar()),
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
                colors: [Color.fromRGBO(108, 159, 206, 1), Colors.blueAccent])),
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
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    PickedFile selected = await ImagePicker().getImage(source: source);
    setState(() {
      _profileimg = File(selected.path);
    });
  }

  Widget _picture() {
    return Container(
      height: 150,
      width: 150,
      child: ClipRRect(
        child: GestureDetector(
          child: Container(
            color: Colors.orangeAccent,
            child: _profileimg==null?
            Icon(Icons.add_a_photo_outlined, size: 50, color: Colors.white,):
            Image.file(
              _profileimg,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            showDialog<void>(
              context: context,
              barrierDismissible: true,
              // false = user must tap button, true = tap outside dialog
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  content: Container(
                    height: 110,
                    child: Row(
                      children: [
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                          width: 100,
                          child: TextButton(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.camera,
                                  size: 70,
                                  color: Colors.grey,
                                ),
                                Text(
                                  'Camera',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                            onPressed: () {
                              _pickImage(ImageSource.camera);
                            },
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith((states) => Colors.white),
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                          width: 100,
                          child: TextButton(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 70,
                                  color: Colors.grey,
                                ),
                                Text(
                                  'Gallery',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              _pickImage(ImageSource.gallery);
                            },
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith((states) => Colors.white),
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        borderRadius: BorderRadius.circular(75),
      ),
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
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                _picture(),
                _profileimg==null?
                Container():
                TextButton(
                  child: Text('Clear'),
                  onPressed: () {
                    setState(() {
                      _profileimg = null;
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                _emailPasswordWidget(),
                SizedBox(
                  height: 20,
                ),
                _submitButton(context),
                SizedBox(height: height * .14),
                _loginAccountLabel(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}