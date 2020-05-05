import 'package:flutter/material.dart';

class ItemMenuNota extends StatefulWidget {
  final String nota;
  final String titulo;
  final int index;

  ItemMenuNota({Key key, this.nota, this.titulo, this.index}) : super(key: key);

  @override
  _ItemMenuNotaState createState() => _ItemMenuNotaState();
}

class _ItemMenuNotaState extends State<ItemMenuNota> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
          padding: EdgeInsets.only(top: 10, bottom: 15),
          margin: EdgeInsets.only(top: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFff971e).withOpacity(0.2),
          ),
       child: Row(
         children: <Widget>[
           Expanded(
              child: Column(children: <Widget>[
                Text(
                  widget.titulo,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(widget.nota),
              ]),
              flex: 3,
            ),
         ],
       ),
    );
  }
}