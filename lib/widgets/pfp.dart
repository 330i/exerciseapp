import 'package:flutter/material.dart';

class Pfp extends StatelessWidget {
  final String imageUrl;
  final double size;
  Pfp({this.imageUrl = "", this.size = 30});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            color: Color(0xed6f24),
            borderRadius: BorderRadius.circular(size),
            image: DecorationImage(
                fit: BoxFit.fill, image: NetworkImage(imageUrl))),
      ),
    );
  }
}
