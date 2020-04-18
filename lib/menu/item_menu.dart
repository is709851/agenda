import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class ItemMenu extends StatefulWidget {
  final String title;
  
  ItemMenu({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  _ItemMenuState createState() => _ItemMenuState();
}

class _ItemMenuState extends State<ItemMenu> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  initState(){
    super.initState();

    var initializationSettingsAndroid = new AndroidInitializationSettings('icon');
    var initializationSettingsIOS = new IOSInitializationSettings();    
    var initializationSettings = new InitializationSettings(
       initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification
    );
  }

  Future onSelectNotification(String payload) async{
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: const Text("Here is"),
        content: new Text("Payload: $payload")
      )
    );
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
      'Agenda-U',
      'Nuevo recordatorio',
      platformChannelSpecifics,
      payload: 'Custom_sound',
  );
  var initializationSettings = new InitializationSettings(androidInitializationSettings, null);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      width: 340,
      decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
      child: Card(
        elevation: 0.0,
        color: Colors.transparent, //Color 
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.view_agenda, 
                  color: Color(0xFF042434),
              ), 
                onPressed: _showNotificationWithSound,
              ),
            ),
            Expanded(
              child: Container(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 5),
                      
                    )
                  ],
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15),
              width: 300,
              decoration: BoxDecoration(
                      //color: Color(0xFFD34C01),
                      border: Border.all(
                        color: Colors.transparent
                      )
                    ),
              child:  Text(
                  "${widget.title}",
                  style: TextStyle(fontSize: 34, color: Colors.black), 
                  textAlign: TextAlign.left
                ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text("____________________",
                style: TextStyle(color: Color(0xFF042434)), 
                textAlign: TextAlign.left,
              ),
            )
          ],
        ),
      ),
    );
  }
}
