import 'package:flutter/material.dart';

class ItemRecordatorios extends StatefulWidget {
  final String title;
  final String descripcion;
  final int index;

  ItemRecordatorios(
      {Key key, @required this.title, this.index, this.descripcion})
      : super(key: key);

  @override
  _ItemRecordatoriosState createState() => _ItemRecordatoriosState();
}

class _ItemRecordatoriosState extends State<ItemRecordatorios> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(top: 10, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white60,
      ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Text(
                  "${widget.title}",
                  style: Theme.of(context).textTheme.title.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color(0xFF042434)),
                  textAlign: TextAlign.center,
                ),
              ),
              flex: 2,
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                ),
                child: Text(
                  "${widget.descripcion}",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              flex: 2,
            ),
            Container(
                padding: EdgeInsets.only(right: 5),
                child: Icon(Icons.label_important)),
          ],
        ),
    );
  }
}
