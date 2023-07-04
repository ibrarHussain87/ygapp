import 'package:flutter/material.dart';

class EachPage extends StatelessWidget {

  final String title;
  final String message;
  final String bg;
  final String circle;
  final String image;

  EachPage(this.title,this.message, this.bg,this.circle,this.image);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Colors.amberAccent,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildImage(context, bg, circle, image),
              Text(title),
              Text(message)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context,String bg,String circle,String image) {
    return Stack(
      children: [
        Image.asset(bg, width: MediaQuery.of(context).size.width,fit: BoxFit.fitWidth,),
        Center(child: Image.asset(circle,width: MediaQuery.of(context).size.width/1.4,)),
        Center(child: Image.asset(image,scale: 1.5,)),
      ],
    );
  }
}