import 'package:agenda/recordatorios/edit_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/recordatorios_bloc.dart';

class ItemRecordatorios extends StatefulWidget {
  final String title;
  final String descripcion;
  final bool lunEdit;
  final bool marEdit;
  final bool mieEdit;
  final bool jueEdit;
  final bool vieEdit;
  final bool sabEdit;
  final bool domEdit;
  final String cadaEdit;
  final String mhdmEdit;
  final DateTime horaEdit;
  final int index;

  ItemRecordatorios(
      {Key key, @required this.title, this.index, this.descripcion, this.lunEdit, this.marEdit, this.mieEdit, this.jueEdit, this.vieEdit, this.sabEdit, this.domEdit, this.cadaEdit, this.mhdmEdit, this.horaEdit})
      : super(key: key);

  @override
  _ItemRecordatoriosState createState() => _ItemRecordatoriosState();
}

class _ItemRecordatoriosState extends State<ItemRecordatorios> {
  bool importante;
  final _iconKey = GlobalKey<FormState>();

  RecordatoriosBloc bloc;

  @override
  void initState() {
    importante = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(top: 10, right: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFe00e0f).withOpacity(0.2)),
      child: Row(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(right: 5),
              child: IconButton(
                icon: Icon(
                  Icons.label_important,
                ),
                color: importante == false ? Colors.black : Colors.blue,
                key: _iconKey,
                onPressed: () async {
                  setState(() {
                    importante = !importante;
                    if (importante == true) {
                      _addImportante();
                    } else if (importante == false) {
                      BlocProvider.of<RecordatoriosBloc>(context)
                          .add(DeleteImportanteEvent(
                        index: widget.index,
                      ));
                    }
                  });
                },
              )),
          Expanded(
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
            flex: 3,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                  height: 25,
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).push( MaterialPageRoute(
                                  builder: (context) => EditForm(
                        tituloEdit: widget.title,
                        descripcionEdit: widget.descripcion,
                        index: widget.index,
                        lunEdit: widget.lunEdit,
                        marEdit: widget.marEdit,
                        mieEdit: widget.marEdit,
                        jueEdit: widget.jueEdit,
                        vieEdit: widget.vieEdit,
                        sabEdit: widget.sabEdit,
                        domEdit: widget.domEdit,
                        cadaEdit: widget.cadaEdit,
                        horaEdit: widget.horaEdit,
                        mhdmEdit: widget.mhdmEdit,
                      
                      )));
                    },
                  )),
              Container(
                  height: 25,
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      _showConfirmDelete();
                    },
                  ))
            ],
          )
        ],
      ),
    );
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
                    Text('¿Estas seguro que deseas eliminar el recordatorio?'),
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
                            BlocProvider.of<RecordatoriosBloc>(context)
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
        .collection('recordatoriosDestacados')
        .document()
        .setData({
      'titulo': widget.title,
      'descripcion': widget.descripcion,
    });
  }
}
