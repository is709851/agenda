import 'package:agenda/menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendario extends StatefulWidget {
  Calendario({Key key}) : super(key: key);

  @override
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Center( child: Text('Calendario'),),
        backgroundColor: Color(0xFF042434),
         
      ),
      body: Container(
        child: Column(
          children:<Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.navigate_before),
                  onPressed: null,
                ),
                IconButton(
                  icon: Icon(Icons.navigate_next),
                  onPressed: null,
                )
              ],
            ),
            SfCalendar( //Construcor para el calendario
            view: CalendarView.month, //Seleccion de la vista
            monthViewSettings: MonthViewSettings(showAgenda: true),
            ),
          ],
        ),
      ),
    );
  }
}