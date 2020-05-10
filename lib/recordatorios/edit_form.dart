import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'bloc/recordatorios_bloc.dart';

class EditForm extends StatefulWidget {
  final String tituloEdit;
  final String descripcionEdit;
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

  EditForm({
    Key key,
    this.tituloEdit,
    this.descripcionEdit,
    this.lunEdit,
    this.marEdit,
    this.mieEdit,
    this.jueEdit,
    this.vieEdit,
    this.sabEdit,
    this.domEdit,
    this.cadaEdit,
    this.mhdmEdit,
    this.horaEdit,
    this.index,
  }) : super(key: key);

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool lun = false;
  bool mar = false;
  bool mie = false;
  bool jue = false;
  bool vie = false;
  bool sab = false;
  bool dom = false;

  DateTime hora;

  TextEditingController cada = TextEditingController();
  String mhdm;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tituloController = TextEditingController(text: widget.tituloEdit);
    descripcionController = TextEditingController(text: widget.descripcionEdit);
   /* lun = widget.lunEdit;
    mar = widget.marEdit;
    mie = widget.mieEdit;
    jue = widget.jueEdit;
    vie = widget.vieEdit;
    sab = widget.sabEdit;
    dom = widget.domEdit;
    hora = widget.horaEdit; */
    /*cada = TextEditingController(text: widget.cadaEdit); */

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text('Edita recordatorio'),
          ),
          backgroundColor: Color(0xFFe00e0f).withOpacity(0.2),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 40),
          child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Título:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 20, left: 50, right: 50),
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: tituloController,
                        decoration: InputDecoration(
                          labelText: 'Título',
                          hintText: 'Título',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Detalles:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 20, left: 50, right: 50),
                      child: TextFormField(
                        controller: descripcionController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Recordatorio vacío';
                          }
                        },
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: 'Descripción',
                          hintText: 'Ingresa descripción',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      child: Text('Personalizar'),
                      onPressed: null,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        checkbox("L", lun),
                        checkbox("M", mar),
                        checkbox("Mi", mie),
                        checkbox("J", jue),
                        checkbox("V", vie),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        checkbox("S", sab),
                        checkbox("D", dom)
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Ingresa una hora:',
                            style: TextStyle(fontSize: 18),
                          ),
                          Container(
                            width: 130,
                            margin: EdgeInsets.only(top: 5, left: 13),
                            child: DateTimeField(
                              initialValue: widget.horaEdit,
                              onChanged: (val) {
                                setState(() => hora = val);
                              },
                              format: DateFormat("h:mm a"),
                              onShowPicker: (context, currentValue) async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      currentValue ?? DateTime.now()),
                                );
                                return DateTimeField.convert(time);
                              },
                            ),
                          ),
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Recuerda cada: ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Container(
                          width: 50,
                          margin: EdgeInsets.only(left: 15, right: 20),
                          child: TextField(
                            controller: cada,
                            decoration:
                                InputDecoration(labelText: widget.cadaEdit),
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                          ),
                        ),
                        DropdownButton(
                          hint: Text(widget.mhdmEdit),
                          value: mhdm,
                          items: <String>['Minutos', 'Horas', 'Días', 'Meses']
                              .map((mhdm) {
                            return DropdownMenuItem<String>(
                              value: mhdm,
                              child: Text(mhdm),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              mhdm = val;
                            });
                          },
                        ),
                      ],
                    ),
                    Container(
                      height: 60,
                      color: Color(0xFF101113),
                      child: Row(children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                              color: Colors.transparent,
                              child: Text(
                                'GUARDAR',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _edita();
                                  Future.delayed(Duration(milliseconds: 1500))
                                      .then((_) {
                                    Navigator.of(context).pop();
                                  });
                                }
                              }),
                          flex: 1,
                        )
                      ]),
                    ),
                  ])),
        ));
  }

  Widget checkbox(String titulo, bool value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(titulo),
        Checkbox(
          value: value,
          onChanged: (bool val) {
            setState(() {
              switch (titulo) {
                case 'L':
                  lun = val;
                  break;
                case 'M':
                  mar = val;
                  break;
                case 'Mi':
                  mie = val;
                  break;
                case 'J':
                  jue = val;
                  break;
                case 'V':
                  vie = val;
                  break;
                case 'S':
                  sab = val;
                  break;
                case 'D':
                  dom = val;
                  break;
              }
            });
          },
        )
      ],
    );
  }

  _edita() async {
    await Firestore.instance.collection('recordatorios').document().setData({
      'titulo': tituloController.text,
      'descripcion': descripcionController.text,
      'lun': lun,
      'mar': mar,
      'mie': mie,
      'jue': jue,
      'vie': vie,
      'sab': sab,
      'dom': dom,
      'hora': hora.toLocal().millisecondsSinceEpoch,
      'cada': cada.text,
      'mhdm': mhdm
    });
    BlocProvider.of<RecordatoriosBloc>(context).add(RemoveDataEvent(
      index: widget.index,
    ));
  }
}
