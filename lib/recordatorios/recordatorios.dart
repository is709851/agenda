import 'package:agenda/menu/side_menu.dart';
import 'package:agenda/recordatorios/formRecordatorio.dart';
import 'package:agenda/recordatorios/item_recordatorios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/recordatorios_bloc.dart';

class Recordatorios extends StatefulWidget {

  Recordatorios({Key key,}) : super(key: key);

  @override
  _RecordatoriosState createState() => _RecordatoriosState();
}

class _RecordatoriosState extends State<Recordatorios> {
  RecordatoriosBloc bloc;

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Center(
          child: Text('Recordatorios'),
        ),
        backgroundColor: Color(0xFF042434),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => FormRecordatorio()),
              );
            },
          )
        ],
      ),
      body:Container(
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
              child: BlocProvider(
        create: (context) {
          bloc = RecordatoriosBloc()..add(GetDataEvent());
          return bloc;
        },
        child: BlocListener<RecordatoriosBloc, RecordatoriosState>(
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
          child: BlocBuilder<RecordatoriosBloc, RecordatoriosState>(
                  builder: (context, state) {
                if (state is RecordatoriosInitial) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return bloc.getRecordatoriosList == null ?
                 Container() : ListView.builder(
                  itemCount: bloc.getRecordatoriosList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemRecordatorios(
                      key: UniqueKey(),
                      index: index,
                      title: bloc.getRecordatoriosList[index].titulo ?? "No title",
                      descripcion: bloc.getRecordatoriosList[index].descripcion ?? "No descripcion",
                    );
                  },
                );
              },
        ),
        ),
      ),
      )
    );
  }
}


