import 'package:agenda/calendario/item_c_evento.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import 'bloc/calendario_bloc.dart';

// Example holidays
final Map<DateTime, List> _holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};

class Calendario extends StatefulWidget {
  Calendario({
    Key key,
  }) : super(key: key);

  @override
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  // Mi prueba
  Map<DateTime, List<dynamic>> _misEventos;
  List<dynamic> milista = new List();

// Para el formulario  de añadir evento
  DateTime dayI;
  DateTime dayF;
  DateTime timeI;
  DateTime timeF;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _descripcion = new TextEditingController();
  TextEditingController _titulo = new TextEditingController();
  DateTime _selectedDay;
  FocusNode _focus = new FocusNode();
  CalendarioBloc bloc;

  void _onFocusChange() {
    debugPrint("Focus: " + _focus.hasFocus.toString());
  }

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    _selectedDay = DateTime.now();

    /* _events = {
      _selectedDay.subtract(Duration(days: 30)): [
        'Event A0',
        'Event B0',
        'Event C0'
      ],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      _selectedDay.subtract(Duration(days: 20)): [
        'Event A2',
        'Event B2',
        'Event C2',
        'Event D2'
      ],
      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(Duration(days: 10)): [
        'Event A4',
        'Event B4',
        'Event C4'
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        'Event A5',
        'Event B5',
        'Event C5'
      ],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      //_selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _selectedDay.add(Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event D8'
      ],
      _selectedDay.add(Duration(days: 3)):
          Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      _selectedDay.add(Duration(days: 7)): [
        'Event A10',
        'Event B10',
        'Event C10'
      ],
      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
      _selectedDay.add(Duration(days: 17)): [
        'Event A12',
        'Event B12',
        'Event C12',
        'Event D12'
      ],
      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
      _selectedDay.add(Duration(days: 26)): [
        'Event A14',
        'Event B14',
        'Event C14'
      ], 
    };*/

   // _selectedEvents = bloc.getEventosList; /* events[_selectedDay] ?? [] */;
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected' + day.toString());
    setState(() {
      _selectedDay = day;
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Calendario'),
          ),
          backgroundColor: Color(0xFF009975).withOpacity(0.6),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildTableCalendar(),
            // _buildTableCalendarWithBuilders(),
            const SizedBox(height: 8.0),
            // _buildButtons(),
            const SizedBox(height: 8.0),
            Expanded(
                child: BlocProvider(
                    create: (context) {
                      bloc = CalendarioBloc()..add(GetDataEvent());
                      return bloc;
                    },
                    child: BlocListener<CalendarioBloc, CalendarioState>(
                      listener: (context, state) {
                        if (state is CloudStoreGetData) {
                          Scaffold.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text("Todo listo"),
                                duration: Duration(seconds: 1),
                              ),
                            );
                        }
                      },
                      child: BlocBuilder<CalendarioBloc, CalendarioState>(
                          builder: (context, state) {
                            if (state
                                                    is CalendarioInitial) {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                        return _buildEventList();
                      }),
                    )))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Color(0xFF009975).withOpacity(0.6),
          onPressed: _showModalForm,
        ));
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,//bloc.getEventosList,//_misEventos, //_events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'pl_PL',
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  /* Widget _buildButtons() {
    final dateTime = _events.keys.elementAt(_events.length - 2);

    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('Month'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.month);
                });
              },
            ),
            RaisedButton(
              child: Text('2 weeks'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.twoWeeks);
                });
              },
            ),
            RaisedButton(
              child: Text('Week'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.week);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        RaisedButton(
          child: Text('Set day ${dateTime.day}-${dateTime.month}-${dateTime.year}'),
          onPressed: () {
            _calendarController.setSelectedDay(
              DateTime(dateTime.year, dateTime.month, dateTime.day),
              runCallback: true,
            );
          },
        ),
      ],
    );
  }
 */
  Widget _buildEventList() {
    return bloc.getEventosList != null
        ? ListView.builder(
            itemCount: bloc.getEventosList.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemCEvento(
                  key: UniqueKey(),          
                  index: index,
                  titulo: bloc.getEventosList[index].titulo ?? 'Sin titulo',
                  descripcion: bloc.getEventosList[index].descripcion ?? 'No descripcion',
                );
            },
          ) : Center(
            child: Text('sin eventos'),
          );
  }

  void _showModalForm() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
              padding:
                  EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: DateTimeField(
                              decoration: InputDecoration(
                                  icon: Icon(Icons.calendar_today),
                                  labelText: 'Fecha inicio'),
                              onChanged: (val) {
                                setState(() => dayI = val);
                              },
                              format: DateFormat("MMMMd"),
                              onShowPicker: (context, currentValue) async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2018),
                                  lastDate: DateTime(2026),
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return Theme(
                                      data: ThemeData.dark(),
                                      child: child,
                                    );
                                  },
                                );
                                if (date != null) {
                                  final time =
                                      TimeOfDay.fromDateTime(DateTime.now());
                                  return DateTimeField.combine(date, time);
                                } else {
                                  return currentValue;
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 14),
                          Expanded(
                            child: DateTimeField(
                              onChanged: (val) {
                                setState(() => timeI = val);
                              },
                              format: DateFormat("H:mm a"),
                              decoration: InputDecoration(
                                  icon: Icon(Icons.access_time),
                                  labelText: 'Hora inicio'),
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
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: DateTimeField(
                              onChanged: (val) {
                                setState(() => dayF = val);
                              },
                              format: DateFormat("MMMMd"),
                              decoration: InputDecoration(
                                  icon: Icon(Icons.calendar_today),
                                  labelText: 'Fecha fin'),
                              onShowPicker: (context, currentValue) async {
                                final dateF = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2018),
                                  lastDate: DateTime(2026),
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return Theme(
                                      data: ThemeData.dark(),
                                      child: child,
                                    );
                                  },
                                );
                                if (dateF != null) {
                                  final time =
                                      TimeOfDay.fromDateTime(DateTime.now());
                                  return DateTimeField.combine(dateF, time);
                                } else {
                                  return currentValue;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: DateTimeField(
                              decoration: InputDecoration(
                                  icon: Icon(Icons.access_time),
                                  labelText: 'Hora fin'),
                              onChanged: (val) {
                                setState(() => timeF = val);
                              },
                              format: DateFormat("H:mm a"),
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
                        ],
                      ),
                      TextFormField(
                        focusNode: _focus,
                        controller: _titulo,
                        decoration: InputDecoration(hintText: 'Título'),
                        maxLength: 30,
                        maxLines: 1,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Añade un titulo';
                          }
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _descripcion,
                        maxLength: 60,
                        maxLines: 4,
                        decoration: InputDecoration(hintText: 'Descripción'),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            color: Color(0xFF101113),
                            child: MaterialButton(
                              child: Text(
                                'Guardar',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  createEvent();
                                  Future.delayed(Duration(milliseconds: 1300))
                                      .then((_) {
                                    Navigator.of(context).pop();
                                  });
                                }
                              },
                            ),
                          ))
                        ],
                      )
                    ],
                  )));
        });
  }

  void createEvent() async {
    await Firestore.instance.collection('eventos').document().setData({
      'titulo': _titulo.text,
      'descripcion': _descripcion.text,
      'hora inicio': timeI.toLocal().millisecondsSinceEpoch,
      'hora fin': timeF.toLocal().millisecondsSinceEpoch,
      'fecha inicio': dayI.toString(),
      'fecha fin': dayF.toString()
    });
  }
}
