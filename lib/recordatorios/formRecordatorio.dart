import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FormRecordatorio extends StatefulWidget {
  FormRecordatorio({Key key}) : super(key: key);

  @override
  _FormRecordatorioState createState() => _FormRecordatorioState();
}

class _FormRecordatorioState extends State<FormRecordatorio> {
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

  //Notificaciones
  //FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    /* var initializationSettingsAndroid =
        new AndroidInitializationSettings('assets/icon.png');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text('Nuevo recordatorio'),
        ),
        backgroundColor: Color(0xFFe00e0f).withOpacity(0.2),
      ),
      body: Container(
          padding: EdgeInsets.only(top: 40),
          child: Form(
                      key: _formKey,
                      child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
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
                  child: TextFormField(
                    validator: (value) {
                            if (value.isEmpty) {
                              return 'Recordatorio vacío';
                            }
                          },
                    controller: descripcionController,
                    decoration: InputDecoration(
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
                  children: <Widget>[checkbox("S", sab), checkbox("D", dom)],
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
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                      ),
                    ),
                    DropdownButton(
                      hint: Text('Selecciona'),
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
                Expanded(
                  child: SizedBox(
                    height: 0,
                  ),
                  flex: 1,
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
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              createRecord();
                            Future.delayed(Duration(milliseconds: 1500))
                                .then((_) {
                              Navigator.of(context).pop();
                            });
                            }
                            // _showNotificationWithSound();
                          }),
                      flex: 1,
                    )
                  ]),
                ),
              ])),
      )
    );
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

  void createRecord() async {
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
  }

  /* Future _showNotificationWithSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        //sound: RawResourceAndroidNotificationSound('notification'),
        importance: Importance.Max,
        priority: Priority.High);
    var androidInitializationSettings = AndroidInitializationSettings('icon');
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(sound: "notification.aiff");
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      tituloController.text,
      descripcionController.text,
      platformChannelSpecifics,
      payload: 'Custom_sound',
    );

    var initializationSettings =
        new InitializationSettings(androidInitializationSettings, null);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future onSelectNotification(String payload) async {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
            title: const Text("Here is"),
            content: new Text("Payload: $payload")));
  }
 */
}
