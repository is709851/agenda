import 'package:agenda/alarmas/alarmas.dart';
import 'package:agenda/calendario/calendario.dart';
import 'package:agenda/menu/menu.dart';
import 'package:agenda/recordatorios/recordatorios.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Center( child: Text('',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  
                ),
              )
            ),
            decoration: BoxDecoration(
              color: Color(0xFF042434),
              image: DecorationImage(
                image: AssetImage('assets/icon.png'),
                fit: BoxFit.cover,
              ),
            )
          ),
          ListTile(
            leading: Icon(Icons.menu),
            title: Text('INICIO',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Menu()),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.add_alert),
            title: Text('Recordatorios',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Recordatorios()),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.alarm),
            title: Text('Alarma',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Alarmas()),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Calendario',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>Calendario()),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.note_add),
            title: Text('Notas',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => null),
              ),
            },
          ),
        ],
      ),
    );
  }
}