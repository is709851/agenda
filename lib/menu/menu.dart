import 'package:agenda/alarmas/alarmas.dart';
import 'package:agenda/calendario/calendario.dart';
import 'package:agenda/menu/item_menu.dart';
import 'package:agenda/notas/notas.dart';
import 'package:agenda/recordatorios/recordatorios.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  final String alias;

  Menu({Key key, this.alias}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  String saludo = 'WELCOME!!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFF101113), //Color Gris oscuro
      //drawer: SideMenu(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'AGENDA-U',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color(0xFF042434),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => null),
              );
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 40),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const
            /*Color(0xFFbfddde),
                Color(0xFF83c3d1),
                Color(0xFF228693),
                Color(0xFF075061),
                Color(0xFF042434),*/
            Color(0xFFbfddde),
            Color(0xFFFFFD82),
            Color(0xFFFF9B71),
            Color(0xFF55DDFF),
            Color(0xFFED217C),
          ], stops: [
            0.0,
            0.1,
            0.2,
            0.6,
            1.0
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 80,
                    height: 80,
                    margin: EdgeInsets.only(
                        top: 30, bottom: 30, right: 10, left: 35),
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                          image: AssetImage('assets/mancha.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(38),
                    ),
                    child: Text('')),
                Text(
                  "Hola ${widget.alias}",
                    style: TextStyle(color: Colors.black, fontSize: 22),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 35),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '$saludo\n',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      TextSpan(
                          text: ' ¿Qué vamos a hacer hoy?',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                //height: 500,
                margin: EdgeInsets.only(left: 2),
                child: ListView(
                  padding: EdgeInsets.only(top: 10),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Recordatorios()),
                          );
                        },
                        child: ItemMenu(
                          title: "Recordatorios",
                          //image: "assets/recordatorio.jpg",
                        ),
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Notas()),
                          );
                        },
                        child: ItemMenu(
                          title: "Notas",
                          //image: "assets/notas.jpg",
                        ),
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Calendario()),
                          );
                        },
                        child: ItemMenu(
                          title: "Calendario",
                          //image: "assets/notas.jpg",
                        ),
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Alarmas()),
                          );
                        },
                        child: ItemMenu(
                          title: "Alarmas",
                          //image: "assets/notas.jpg",
                        ),
                      ),
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
}
