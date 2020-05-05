import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/notas_bloc.dart';

class ItemNota extends StatefulWidget {
  final String nota;
  final String titulo;
  final String urlImage;
  final int index;

  ItemNota(
      {Key key, this.nota, this.index, this.titulo, this.urlImage})
      : super(key: key);

  @override
  _ItemNotaState createState() => _ItemNotaState();
}

class _ItemNotaState extends State<ItemNota> {
  bool importante = false;
  Uint8List imageBytes;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.urlImage != "") {
      return Container(
          height: 240,
          padding: EdgeInsets.only(top: 10, bottom: 15),
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFffd545).withOpacity(0.3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /* Expanded(
                  child: Container(
                      width: 40,
                      margin: EdgeInsets.only(right: 15),
                      child: IconButton(
                        icon: Icon(
                          Icons.label_important,
                        ),
                        color: importante == false ? Colors.black : Colors.blue,
                        onPressed: () {
                          setState(() {
                            importante = !importante;
                          });
                        },
                      ))), */
              Expanded(
                child: Container(
                  height: 200,
                  width: 200,
                  child: Image.file(File(widget.urlImage)),
                ),
                flex: 4,
              ),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          height: 25,
                          margin: EdgeInsets.only(bottom: 10),
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {},
                          )),
                    Container(
                        height: 25,
                        margin: EdgeInsets.only(bottom: 10),
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            _showConfirmDelete();
                          },
                        ))
                  ],
                ),
              ),
            ],
          ));
    }
    return Container(
        height: 120,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFffd545).withOpacity(0.4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                  width: 40,
                  margin: EdgeInsets.only(right: 15),
                  child: IconButton(
                    icon: Icon(
                      Icons.label_important,
                    ),
                    color: importante == false ? Colors.black : Colors.blue,
                    onPressed: () {
                      setState(() {
                        importante = !importante;
                        if (importante == true ) {
                            _addImportante();
                          } 
                      });
                    },
                  )),
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
            Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 25,
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  )),
                Container(
                    height: 25,
                    margin: EdgeInsets.only(bottom: 10),
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        _showConfirmDelete();
                      },
                    ))
              ],
            ),
          ],
        ));
  }

  _showConfirmDelete() {
    return showDialog(
        context: context,
        child: AlertDialog(
            content: Container(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('¿Estas seguro que deseas eliminar la nota?'),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          child: Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FlatButton(
                          color: Color(0xFF042434).withOpacity(0.2),
                          child: Text('Aceptar'),
                          onPressed: () {
                            BlocProvider.of<NotasBloc>(context)
                                .add(RemoveDataEvent(
                              index: widget.index,
                            ));
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    )
                  ],
                ))));
  }

   void _addImportante() async {
    await Firestore.instance
        .collection('notasDestacadas')
        .document()
        .setData({
      'titulo': widget.titulo,
      'nota': widget.nota,
    });
  }
}
