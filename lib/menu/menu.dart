import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:agenda/calendario/bloc/calendario_bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:agenda/alarmas/alarmas.dart';
import 'package:agenda/calendario/calendario.dart';
import 'package:agenda/menu/items/item_menu_recordatorio.dart';
import 'package:agenda/notas/notas.dart';
import 'package:agenda/recordatorios/recordatorios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:video_player/video_player.dart';

//Items de las ventanas del menu
import 'package:agenda/menu/items/item_menu_alarma.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agenda/recordatorios/bloc/recordatorios_bloc.dart';
import 'package:agenda/alarmas/bloc/alarmas_bloc.dart';
import 'package:agenda/notas/bloc/notas_bloc.dart';

import 'items/item_menu_calendario.dart';
import 'items/item_menu_nota.dart';

//Notificaciones
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Menu extends StatefulWidget {
  final String name;

  Menu({Key key, this.name}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var saludos = [
    '¿Qué vamos a hacer hoy?',
    'Hoy tendremos un día grandioso',
    'Empecemos!',
    '¿Qué novedades tendremos hoy?',
    'Nos esperan varias cosas por hacer'
  ];
  int cont = 0;
  int rdm = 0;
  RecordatoriosBloc bloc;
  AlarmasBloc blocA;
  NotasBloc blocN;
  CalendarioBloc blocC;

  //VideoPlayerController _videoPlayer;

  // Función para mostrar mensajes aleatorios
  final hoyH = DateTime.now().hour;
  final hoyM = DateTime.now().minute;
  void mnsjAleatorios() {
    if (cont <= saludos.length && hoyH == 03 && 00 == hoyM) {
      cont++;
      rdm = Random().nextInt(saludos.length);
    } else {
      cont = 0;
    }
  }

  @override
  void initState() {
    super.initState();
    mnsjAleatorios();

    /*    _videoPlayer = VideoPlayerController.asset('assets/Agenda.mp4');
    _videoPlayer.addListener((){
      setState((){});
    });

    _videoPlayer.setLooping(true);
    _videoPlayer.initialize().then((_) => setState((){}));
    _videoPlayer.play(); */

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('icon.png');
    var initializationSettingsIOS = new IOSInitializationSettings();

    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  @override
  void dispose() {
    bloc.close();
    blocA.close();
    blocN.close();
    blocC.close();
    /* 
    _videoPlayer.dispose(); */
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'AGENDA',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
        backgroundColor: Color(0xFFffd545).withOpacity(0.8),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Video()),
                );
              })
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const Color(0xFFffd545).withOpacity(0.1),
            Color(0xFFffd545).withOpacity(0.2),
            Color(0xFFffd545).withOpacity(0.3),
            Color(0xFFffd545).withOpacity(0.4),
            Color(0xFFffd545).withOpacity(0.5),
          ], stops: [
            0.0,
            0.1,
            0.2,
            0.5,
            1.0
          ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
        ),
        padding: EdgeInsets.only(bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  margin:
                      EdgeInsets.only(top: 30, bottom: 30, right: 10, left: 35),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://lh3.googleusercontent.com/a-/AOh14Gjfpk1PymxMYC4CBv39AMxD4NSk8x9vUX5z8Nktwg"),
                    radius: 60,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Text(
                  "Hola ",
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
                Text(
                  'Francis Macias' ?? widget.name,
                  style: TextStyle(color: Colors.black, fontSize: 22),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: 35, bottom: 15),
              child: Align(
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Bienvenido \n',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      TextSpan(
                          text: saludos[rdm].toString() ?? '',
                          style: TextStyle(color: Colors.black, fontSize: 14)),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 2),
                child: ListView(
                  padding: EdgeInsets.only(top: 10),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      width: 340,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 5.0,
                              color: Color(0xFFFFFFFF).withOpacity(0.5))),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Recordatorios()),
                          );
                        },
                        child: Container(
                          width: 340,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Card(
                            elevation: 0.0,
                            color: Colors.transparent, //Color
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.view_agenda,
                                      color: Color(0xFF042434),
                                    ),
                                    onPressed: _showNotification,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(left: 10, top: 5),
                                      child: BlocProvider(
                                          create: (context) {
                                            bloc = RecordatoriosBloc()
                                              ..add(ImportanteEvent());
                                            return bloc;
                                          },
                                          child: BlocListener<RecordatoriosBloc,
                                              RecordatoriosState>(
                                            listener: (context, state) {
                                              if (state
                                                  is CloudStoreGetDestacados) {
                                                Scaffold.of(context)
                                                  ..hideCurrentSnackBar()
                                                  ..showSnackBar(
                                                    SnackBar(
                                                      content:
                                                          Text("Todo listo"),
                                                      duration:
                                                          Duration(seconds: 1),
                                                    ),
                                                  );
                                              }
                                            },
                                            child: BlocBuilder<
                                                RecordatoriosBloc,
                                                RecordatoriosState>(
                                              builder: (context, state) {
                                                if (state
                                                    is RecordatoriosInitial) {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                                return bloc.getImportanteList
                                                            .length >
                                                        0
                                                    ? ListView.builder(
                                                        itemCount: bloc
                                                            .getImportanteList
                                                            .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return ItemMenuRecordatorio(
                                                            key: UniqueKey(),
                                                            index: index,
                                                            title: bloc
                                                                    .getImportanteList[
                                                                        index]
                                                                    .titulo ??
                                                                "No title",
                                                            descripcion: bloc
                                                                    .getImportanteList[
                                                                        index]
                                                                    .descripcion ??
                                                                "No descripcion",
                                                          );
                                                        },
                                                      )
                                                    : Center(
                                                        child: Text(
                                                        "Sin recordatorios para hoy",
                                                      ));
                                              },
                                            ),
                                          ))),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  width: 300,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.transparent)),
                                  child: Text("Recordatorios",
                                      style: TextStyle(
                                          fontSize: 34, color: Colors.black),
                                      textAlign: TextAlign.left),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    "____________________",
                                    style: TextStyle(color: Color(0xFF042434)),
                                    textAlign: TextAlign.left,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 340,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 5.0,
                              color: Color(0xFFFFFFFF).withOpacity(0.4))),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Notas()),
                            );
                          },
                          child: Container(
                            width: 340,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Card(
                              elevation: 0.0,
                              color: Colors.transparent, //Color
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.view_agenda,
                                        color: Color(0xFF042434),
                                      ),
                                      onPressed: null,
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                          margin:
                                              EdgeInsets.only(left: 10, top: 5),
                                          child: BlocProvider(
                                              create: (context) {
                                                blocN = NotasBloc()
                                                  ..add(ImportantesEvent());
                                                return blocN;
                                              },
                                              child: BlocListener<NotasBloc,
                                                  NotasState>(
                                                listener: (context, state) {
                                                  if (state
                                                      is CloudStoreGetDestacadas) {
                                                    Scaffold.of(context)
                                                      ..hideCurrentSnackBar()
                                                      ..showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              "Todo listo"),
                                                          duration: Duration(
                                                              seconds: 1),
                                                        ),
                                                      );
                                                  }
                                                },
                                                child: BlocBuilder<NotasBloc,
                                                    NotasState>(
                                                  builder: (context, state) {
                                                    if (state is NotasInitial) {
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    }
                                                    return blocN.getImportantesList
                                                                .length >
                                                            0
                                                        ? ListView.builder(
                                                            itemCount: blocN
                                                                .getImportantesList
                                                                .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return ItemMenuNota(
                                                                key:
                                                                    UniqueKey(),
                                                                index: index,
                                                                titulo: blocN
                                                                        .getImportantesList[
                                                                            index]
                                                                        .titulo ??
                                                                    "No title",
                                                                nota: blocN
                                                                        .getImportantesList[
                                                                            index]
                                                                        .nota ??
                                                                    "Sin contenido",
                                                              );
                                                            },
                                                          )
                                                        : Center(
                                                            child: Text(
                                                            "No tienes notas destacadas",
                                                          ));
                                                  },
                                                ),
                                              )))),
                                  Container(
                                    margin: EdgeInsets.only(left: 15),
                                    width: 300,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.transparent)),
                                    child: Text("Notas",
                                        style: TextStyle(
                                            fontSize: 34, color: Colors.black),
                                        textAlign: TextAlign.left),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      "____________________",
                                      style:
                                          TextStyle(color: Color(0xFF042434)),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ),
                    Container(
                      width: 340,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 5.0,
                              color: Color(0xFFFFFFFF).withOpacity(0.4))),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Calendario()),
                            );
                          },
                          child: Container(
                            width: 340,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Card(
                              elevation: 0.0,
                              color: Colors.transparent, //Color
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.view_agenda,
                                        color: Color(0xFF042434),
                                      ),
                                      onPressed: null,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        margin:
                                            EdgeInsets.only(left: 10, top: 5),
                                        child: BlocProvider(
                                            create: (context) {
                                              blocC = CalendarioBloc()
                                                ..add(GetDataCEvent());
                                              return blocC;
                                            },
                                            child: BlocListener<CalendarioBloc,
                                                CalendarioState>(
                                              listener: (context, state) {
                                                if (state
                                                    is CloudStoreGetCData) {
                                                  Scaffold.of(context)
                                                    ..hideCurrentSnackBar()
                                                    ..showSnackBar(
                                                      SnackBar(
                                                        content:
                                                            Text("Todo listo"),
                                                        duration: Duration(
                                                            seconds: 1),
                                                      ),
                                                    );
                                                }
                                              },
                                              child: BlocBuilder<CalendarioBloc,
                                                  CalendarioState>(
                                                builder: (context, state) {
                                                  if (state
                                                      is CalendarioInitial) {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  }
                                                  return blocC.getEventosList !=
                                                          null
                                                      ? ListView.builder(
                                                          itemCount: blocC
                                                              .getEventosList
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return ItemCMEvento(
                                                              key: UniqueKey(),
                                                              index: index,
                                                              titulo: blocC
                                                                      .getEventosList[
                                                                          index]
                                                                      .titulo ??
                                                                  'Sin titulo',
                                                              descripcion: blocC
                                                                      .getEventosList[
                                                                          index]
                                                                      .descripcion ??
                                                                  'No descripcion',
                                                            );
                                                          },
                                                        )
                                                      : Center(
                                                          child: Text(
                                                              'sin eventos'),
                                                        );
                                                },
                                              ),
                                            ))),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 15),
                                    width: 300,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.transparent)),
                                    child: Text("Calendario",
                                        style: TextStyle(
                                            fontSize: 34, color: Colors.black),
                                        textAlign: TextAlign.left),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      "____________________",
                                      style:
                                          TextStyle(color: Color(0xFF042434)),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ),
                    Container(
                      width: 340,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 5.0,
                              color: Color(0xFFFFFFFF).withOpacity(0.4))),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Alarmas()),
                            );
                          },
                          child: Container(
                            width: 340,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Card(
                              elevation: 0.0,
                              color: Colors.transparent, //Color
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.view_agenda,
                                        color: Color(0xFF042434),
                                      ),
                                      onPressed: _showNotification,
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                          margin:
                                              EdgeInsets.only(left: 10, top: 5),
                                          child: BlocProvider(
                                            create: (context) {
                                              blocA = AlarmasBloc()
                                                ..add(AlarmasMenuEvent());
                                              return blocA;
                                            },
                                            child: BlocBuilder<AlarmasBloc,
                                                AlarmasState>(
                                              builder: (context, state) {
                                                if (state is AlarmasInitial) {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                                return blocA.getNotasList !=
                                                        null
                                                    ? ListView.builder(
                                                        itemCount: blocA
                                                            .getNotasList
                                                            .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return ItemMenuAlarma(
                                                            key: UniqueKey(),
                                                            index: index,
                                                            title: blocA
                                                                    .getNotasList[
                                                                        index]
                                                                    .titulo ??
                                                                '',
                                                            tiempo: blocA
                                                                .getNotasList[
                                                                    index]
                                                                .tiempo,
                                                          );
                                                        },
                                                      )
                                                    : Center(
                                                        child: Text(
                                                        "No tienes alarmas guardadas",
                                                      ));
                                              },
                                            ),
                                          ))),
                                  Container(
                                    margin: EdgeInsets.only(left: 15),
                                    width: 300,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.transparent)),
                                    child: Text("Alarmas",
                                        style: TextStyle(
                                            fontSize: 34, color: Colors.black),
                                        textAlign: TextAlign.left),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      "____________________",
                                      style:
                                          TextStyle(color: Color(0xFF042434)),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _showNotification() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Post',
      'How to Show Notification in Flutter',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  Future onSelectNotification(String payload) async {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
            title: const Text("Here is"),
            content: new Text("Payload: $payload")));
  }
}

class Video extends StatefulWidget {
  Video({Key key}) : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  VideoPlayerController _videoPlayer;
  @override
  void initState() {
    super.initState();

    _videoPlayer = VideoPlayerController.asset('assets/Agenda.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    _videoPlayer.play();
    _videoPlayer.setLooping(true);
  }

  @override
  void dispose() {
    _videoPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _videoPlayer.value.initialized
            ? AspectRatio(
                aspectRatio: _videoPlayer.value.aspectRatio,
                child: VideoPlayer(_videoPlayer),
              )
            : Container());
  }
}
