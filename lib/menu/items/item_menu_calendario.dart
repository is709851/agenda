import 'package:flutter/material.dart';

class ItemCMEvento extends StatelessWidget {
  final int index;
  final String titulo;
  final String descripcion;
  
  ItemCMEvento({Key key, this.titulo, this.descripcion, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical:10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        children: <Widget>[
          Align(child: Text(titulo, style: TextStyle(fontSize: 16),)),
          Align(child: Text(descripcion, style: TextStyle(fontSize: 12),))
        ],
      ),
    );
  }
}