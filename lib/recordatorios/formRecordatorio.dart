import 'package:agenda/recordatorios/bloc/recordatorios_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class FormRecordatorio extends StatefulWidget {
  FormRecordatorio({Key key}) : super(key: key);

  @override
  _FormRecordatorioState createState() => _FormRecordatorioState();
}

class _FormRecordatorioState extends State<FormRecordatorio> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  //FocusNode _textFocus = new FocusNode();
  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text('Nuevo recordatorio'),
        ),
        backgroundColor: Color(0xFF042434),
      ),
      body: Container(
          padding: EdgeInsets.only(top: 40),
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Título:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 20, left: 50, right: 50),
                    child: TextField(
                      controller: tituloController,
                      decoration: InputDecoration(
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
                    child: TextField(
                      controller: descripcionController,
                      decoration: InputDecoration(
                        hintText: 'Ingresa descripción',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          'Fecha inicio:',
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () {
                              showRoundedDatePicker(
                                context: context,
                                theme: ThemeData(primarySwatch: Colors.pink),
                              );
                            }),
                        Text(
                          'Fecha fin:',
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () {
                              showRoundedDatePicker(
                                context: context,
                                theme: ThemeData(primarySwatch: Colors.pink),
                              );
                            })
                      ],
                    ),
                  ),
                  Container(
                    height: 80,
                    color: Color(0xFF042434),
                    child: Row(children: <Widget>[
                    Expanded(
                      child: FlatButton(
                      child: Text(
                        'GUARDAR',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () async {
                        BlocProvider.of<RecordatoriosBloc>(context).add(
                          SaveDataEvent(
                              titulo: tituloController.text,
                              descripcion: descripcionController.text),
                        );
                        
                      },
                    ),
                    flex: 2,
                  ),
                  ]),
                  ),
                  
                ])
          
      ),
    );
  }
}

