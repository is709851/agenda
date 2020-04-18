import 'package:flutter/material.dart';

class ItemNota extends StatelessWidget {
  final String nota;
  final int index;

  ItemNota({Key key, this.nota, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(top: 10, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white60,
      ),
      child: Text("$nota")
    );
  }
}