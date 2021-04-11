import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Pfp extends StatelessWidget {
  final String imageUrl;
  final double size;
  Pfp({this.imageUrl = "", this.size = 30});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseStorage.instance.ref(imageUrl).getDownloadURL(),
        builder: (context, photoSnap) {
          if (!photoSnap.hasData) {
            return Container();
          } else {
            return GestureDetector(
              child: Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  color: Color(0xed6f24),
                  borderRadius: BorderRadius.circular(size),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(photoSnap.data)),
                ),
              ),
            );
          }
        });
  }
}
