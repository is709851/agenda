import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notificacion extends StatefulWidget {
  final String titulo;
  final String descripcion;
  final bool lun, mar, mie, jue, vie, sab, dom;
  final DateTimeField hora;

  Notificacion({Key key, this.titulo, this.descripcion,
    this.lun, this.mar, this.mie, this.jue, this.vie, this.sab, this.dom, this.hora
  }) : super(key: key);


  @override
  _NotificacionState createState() => _NotificacionState();
}

class _NotificacionState extends State<Notificacion> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  DateTime horaN = DateTime.now();
  
  @override
  initState() {
    super.initState();

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('assets/icon.png');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future _showNotificationWithSound() async {
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
      widget.titulo,
      widget.descripcion,
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

  @override
  Widget build(BuildContext context) {
    return null;
  }
}