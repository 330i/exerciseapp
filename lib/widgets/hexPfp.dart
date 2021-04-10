import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class HexPfp extends StatelessWidget {
  final String imageUrl;
  final double size;
  HexPfp({this.imageUrl = "", this.size = 30});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: ClipPolygon(
        sides: 6,
        child:Container(
          color: Colors.white,
        padding:EdgeInsets.all(4.0),
        child: ClipPolygon(
          sides: 6,
          borderRadius: 4.0,
          child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(imageUrl))),
          ),
        ),
      ),),
    );
  }
}
