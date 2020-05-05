import 'dart:ui';

import 'package:agenda/alarmas/form_alarmas.dart';
import 'package:agenda/alarmas/item_alarma.dart';
import 'package:agenda/menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/alarmas_bloc.dart';

class Alarmas extends StatefulWidget {
  Alarmas({Key key}) : super(key: key);

  @override
  _AlarmasState createState() => _AlarmasState();
}

class _AlarmasState extends State<Alarmas> 
with AutomaticKeepAliveClientMixin<Alarmas>{
  AlarmasBloc bloc;

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
            child: Text('Alarmas'),
          ),
          backgroundColor: Color(0xFF737284),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => FormAlarmas()),
                );
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
          child: BlocProvider(
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
              }, child: BlocBuilder<AlarmasBloc, AlarmasState>(
                      builder: (context, state) {
                if (state is AlarmasInitial) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return  bloc.getNotasList != null 
                      ? ListView.builder(
                  itemCount: bloc.getNotasList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemAlarma(
                      key: UniqueKey(),
                      index: index, 
                      title: bloc.getNotasList[index].titulo ?? '',
                      tiempo: bloc.getNotasList[index].tiempo,
                      activada: bloc.getNotasList[index].activada ?? false,
                      lun: bloc.getNotasList[index].lun,
                      mar: bloc.getNotasList[index].mar,
                      mie: bloc.getNotasList[index].mie,
                      jue: bloc.getNotasList[index].jue,
                      vie: bloc.getNotasList[index].vie,
                      sab: bloc.getNotasList[index].sab,
                      dom: bloc.getNotasList[index].dom,
                    );
                  },
                ):  Center(
                          child: Text(
                          "No tienes alarmas guardadas",
                          style: TextStyle(fontSize: 18),
                        ));
                },
              ))),
        ));
  }
}
