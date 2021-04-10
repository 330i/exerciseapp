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
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // == BUTTON ==
                Container(
                  height: 200,
                  width: 200,
                  child: ElevatedButton(
                      child: Center(child: Text('Find a Competition')),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Colors.deepOrangeAccent,
                      ),
                      onPressed: () {
                        print('Do Something');
                      }
                  ),
                ),

                // == RANKED ==
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.black38)),
                  child: CheckboxListTile(
                    title: const Text('Ranked'),
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
                  decoration: BoxDecoration(border: Border.all(color: Colors.black38)),
                  child: CheckboxListTile(
                    title: const Text('Unranked'),
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



    /*
                // == RANKED ==
                Container(

                ),

                // == UNRANKED ==
                Container(

                )






    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Center(child: Text('Find a Competition')),
          // CENTER THIS
          onPressed: () {
            print('===Do Something===');
          },
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              primary: Colors.blue,
              padding: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
              textStyle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    ); */


/*class MyCheckboxes extends StatefulWidget {
  @override
  _MyCheckboxes createState() => _MyCheckboxes();
}

class _MyCheckboxes extends State<MyCheckboxes> {
  @override
  bool _isChecked = false;

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: CheckboxListTile(
            title: const Text('Ranked'),
            value: _isChecked,
            onChanged: (bool value) {
              setState(() {
                _isChecked = value;
              });
            },
          ),
        )
      ],
    );
  }
} */

