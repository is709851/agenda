import 'package:agenda/menu/side_menu.dart';
import 'package:agenda/recordatorios/formRecordatorio.dart';
import 'package:agenda/recordatorios/item_recordatorios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/recordatorios_bloc.dart';

class Recordatorios extends StatefulWidget {
  Recordatorios({
    Key key,
  }) : super(key: key);

  @override
  _RecordatoriosState createState() => _RecordatoriosState();
}

class _RecordatoriosState extends State<Recordatorios>
    with AutomaticKeepAliveClientMixin<Recordatorios> {
  RecordatoriosBloc bloc;
  
  // Booleanos para los días de la semana
  bool lun, mar, mie, jue, vie, sab, dom = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        drawer: SideMenu(),
        appBar: AppBar(
          title: Center(
            child: Text('Recordatorios'),
          ),
          backgroundColor: Color(0xFFe00e0f).withOpacity(0.5),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => FormRecordatorio()),
                );
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
          child: BlocProvider(
            create: (context) {
              bloc = RecordatoriosBloc()..add(GetDataEvent());
              return bloc;
            },
            child: BlocListener<RecordatoriosBloc, RecordatoriosState>(
              listener: (context, state) {
               if (state is CloudStoreGetData) {
                  Scaffold.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text("Todos los recordatorios se cargaron"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                } else if (state is CloudStoreRemoved) {
                  Scaffold.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text("Recordatorio eliminado"),
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
                        content: Text("Recordatorio guardado"),
                      ),
                    );
                }
              },
              child: BlocBuilder<RecordatoriosBloc, RecordatoriosState>(
                builder: (context, state) {
                  if(state is RecordatoriosInitial){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return bloc.getRecordatoriosList != null 
                      ? ListView.builder(
                          itemCount: bloc.getRecordatoriosList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ItemRecordatorios(
                                    key: UniqueKey(),
                                    index: index,
                                    title: bloc.getRecordatoriosList[index]
                                            .titulo ??
                                        "No title",
                                    descripcion: bloc
                                            .getRecordatoriosList[index]
                                            .descripcion ??
                                        "No descripcion",
                                  );
                          },
                        )
                      : Center(
                          child: Text(
                          "No tienes recordatorios agregados",
                          style: TextStyle(fontSize: 18),
                        ));
                },
              ),
            ),
          ),
        ));
  }
}
