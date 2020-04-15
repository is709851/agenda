import 'package:agenda/alarmas/alarmas.dart';
import 'package:agenda/calendario/calendario.dart';
import 'package:agenda/inicio.dart';
import 'package:agenda/menu/menu.dart';
import 'package:agenda/notas/notas.dart';
import 'package:agenda/recordatorios/recordatorios.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final menu = Menu();
  final recordatorios = Recordatorios();
  final notas = Notas();
  final calendario = Calendario();
  final alarmas = Alarmas();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        "/Menu": (BuildContext context) => menu,
        "/Recordatorios": (BuildContext context) => recordatorios,
        "/Notas": (BuildContext context) => notas,
        "/Calendario": (BuildContext context) => calendario,
        "/Alarmas": (BuildContext context) => alarmas,

      },
        title: 'Material App',
        theme: ThemeData(
            //primaryColor: Color(0xFFFBE9E7),
            textTheme: TextTheme(
                //TODO: INTRODUCE TEMAS (TIPO DE LETRA, COLOR DEFAULT)
                )),
        home: Scaffold(
          backgroundColor: Color(0xFF042434),
          body: MyHome(),
        ));
  }
}

class MyHome extends StatelessWidget {
  const MyHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Inicio()),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 150, horizontal: 40),
        child: Image.asset('assets/icon.png'),
      ),
    );
  }
}
