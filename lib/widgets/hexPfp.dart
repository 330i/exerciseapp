import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class HexPfp extends StatelessWidget {
  final String imageUrl;
  final double size;
  HexPfp({this.imageUrl = "", this.size = 30});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseStorage.instance.ref(imageUrl).getDownloadURL(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return Container();
        }
        else {
          return Container(
            height: size,
            width: size,
            child: ClipPolygon(
              sides: 6,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xffff6174),
                        Color(0xfffd795e),
                        Color(0xfffc9544)
                      ]),
                ),
                padding: EdgeInsets.all(4.0),
                child: ClipPolygon(
                  sides: 6,
                  borderRadius: 4.0,
                  child: Container(
                    height: size,
                    width: size,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(snapshot.data))),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}