import 'package:flutter/material.dart';

class ItemMenuRecordatorio extends StatefulWidget {
   final String title;
  final String descripcion;
  final int index;

  ItemMenuRecordatorio({Key key, this.title, this.descripcion, this.index}) : super(key: key);

  @override
  _ItemMenuRecordatorioState createState() => _ItemMenuRecordatorioState();
}

class _ItemMenuRecordatorioState extends State<ItemMenuRecordatorio> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(top: 10, right: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFe00e0f).withOpacity(0.1)),
      child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    flex: 3,
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
                    flex: 3,
                  ),
                ]),
    );
  }
}