import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class FormAlarmas extends StatefulWidget {
  FormAlarmas({Key key}) : super(key: key);

  @override
  _FormAlarmasState createState() => _FormAlarmasState();
}

class _FormAlarmasState extends State<FormAlarmas> {
  TextEditingController tituloController = new TextEditingController();
  TextEditingController horController = new TextEditingController();
  TextEditingController minController = new TextEditingController();
  
  DateTime hora;

  bool isSonido = false;
  bool activada = true;

  bool lun = false;
  bool mar = false;
  bool mie = false;
  bool jue = false;
  bool vie = false;
  bool sab = false;
  bool dom = false;
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text('Nueva Alarma'),
        ),
        backgroundColor: Color(0xFF042434),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Ingresa una hora:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    width: 230,
                    height: 100,
                    margin: EdgeInsets.only(top: 5, left: 13),
                    child: DateTimeField(
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
            Container(
              margin: EdgeInsets.only(bottom: 20, left: 30, right: 30),
              child: TextField(
                maxLength: 16,
                controller: tituloController,
                decoration: InputDecoration(
                  hintText: 'Título',
                  hintMaxLines: 1,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Container(
              child: null,
            ),
            Container(
              margin: EdgeInsets.only(top: 50, bottom: 10),
              child: Text(
                'Repetir',
                style: TextStyle(fontSize: 16),
              ),
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
              children: <Widget>[checkbox("S", sab), checkbox("D", dom)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    'Sonido: ',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Switch(
                  value: isSonido,
                  onChanged: (value) {
                    setState(() {
                      isSonido = value;
                      print(isSonido);
                    });
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
              ],
            ),
            Expanded(
              child: SizedBox(
                height: 0,
              ),
              flex: 1,
            ),
            Container(
              margin: EdgeInsets.only(top: 80),
              width: 450,
              height: 60,
              decoration: BoxDecoration(color: Color(0xFF075061)),
              child: MaterialButton(
                onPressed: () async {
                  createAlarma();
                  Future.delayed(Duration(milliseconds: 1500)).then((_) {
                    Navigator.of(context).pop();
                  });
                },
                child: Text(
                  'GUARDAR',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void createAlarma() async {

    await Firestore.instance.collection('alarmas').document().setData({
      'titulo': tituloController.text,
      'lun': lun,
      'mar': mar,
      'mie': mie,
      'jue': jue,
      'vie': vie,
      'sab': sab,
      'dom': dom,
      'tiempo': hora.toLocal().millisecondsSinceEpoch,
      'sonido': isSonido,
      'activada' : activada
    });
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
}
