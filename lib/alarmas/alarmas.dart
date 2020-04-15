import 'package:agenda/alarmas/bloc/alarmas_bloc.dart';
import 'package:agenda/alarmas/form_alarmas.dart';
import 'package:agenda/alarmas/item_alarma.dart';
import 'package:agenda/menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Alarmas extends StatefulWidget {
  Alarmas({Key key}) : super(key: key);

  @override
  _AlarmasState createState() => _AlarmasState();
}

class _AlarmasState extends State<Alarmas> {
  AlarmasBloc bloc;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Center(
          child:Text('Alarmas'),
        ),
         backgroundColor: Color(0xFF042434), 
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => FormAlarmas()),
              );
            },
          )
        ],
      ),
      body: Container(
              padding:
                  EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0xFFbfddde),
                  Color(0xFF83c3d1),
                  Color(0xFF228693),
                  Color(0xFF075061),
                  Color(0xFF042434),
                ], stops: [
                  0.0,
                  0.1,
                  0.2,
                  0.6,
                  1.0
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              child:  BlocProvider(
        create: (context) {
          bloc = AlarmasBloc()..add(GetDataEvent());
          return bloc;
        },
        child: BlocListener<AlarmasBloc, AlarmasState>(
          listener: (context, state) {
            if (state is CloudStoreRemoved) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Se ha eliminado el elemento."),
                  ),
                );
            } else if (state is CloudStoreError) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("${state.errorMessage}"),
                  ),
                );
            } else if (state is CloudStoreSaved) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Se ha guardado el elemento."),
                  ),
                );
            } else if (state is CloudStoreGetData) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Descargando datos..."),
                  ),
                );
            }
          },
          child: BlocBuilder<AlarmasBloc, AlarmasState>(
                  builder: (context, state) {
                if (state is AlarmasInitial) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: bloc?.getRecordatoriosList?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemAlarma(
                      key: UniqueKey(),
                      
                    );
                  },
                );
              }))),
      )
    );
  }
}