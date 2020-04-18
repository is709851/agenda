import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: null,
    body: Column(
      children: <Widget>[
        Expanded(
          child:Container(
            width: 500,
        padding: EdgeInsets.only(bottom: 40),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const
            Color(0xFFbfddde),
                Color(0xFF83c3d1),
                Color(0xFF228693),
                Color(0xFF075061),
                Color(0xFF042434),
          ], stops: [
            0.0,
            0.1,
            0.2,
            0.6,
            1.0
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Center( child: Text('INFO APP')),
    ),)
      ],)
    );
  }
}