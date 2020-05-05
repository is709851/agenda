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
        backgroundColor: Color(0xFF009975).withOpacity(0.6),
         
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15),
        child: Column(
          children:<Widget>[
            
            SfCalendar( //Construcor para el calendario
            view: CalendarView.month, //Seleccion de la vista
            monthViewSettings: MonthViewSettings(showAgenda: true),
            ),
            Expanded(
              child: Container(
                
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){

        },
      ),
    );
  }
}

 /*Container(
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
                          onPressed: () async {
                            dateTimeInicial = await showRoundedDatePicker(
                              context: context,
                              theme: ThemeData(primarySwatch: Colors.red),
                            );
                          }),
                      Text(
                        'Fecha fin:',
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () async {
                            dateTimeFinal = await showRoundedDatePicker(
                              context: context,
                              theme: ThemeData(primarySwatch: Colors.red),
                            );
                          })
                    ],
                  ),
                ),*/