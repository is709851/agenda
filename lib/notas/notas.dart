import 'package:agenda/notas/bloc/notas_bloc.dart';
import 'package:agenda/notas/item_nota.dart';
import 'package:agenda/notas/nota_camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:agenda/menu/side_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Notas extends StatefulWidget {
  final CameraDescription camera;

  Notas({Key key, this.camera}) : super(key: key);

  @override
  _NotasState createState() => _NotasState();
}

class _NotasState extends State<Notas> {
  NotasBloc bloc;
  bool _isLoading = false;

  @override
  void initState(){
    super.initState();
  }


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
          child: Text('Notas'),
        ),
        backgroundColor: Color(0xFF042434),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _addNota();
            },
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => NotaCamera()),
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
              child: BlocProvider(
        create: (context) {
          bloc = NotasBloc()..add(GetDataEvent());
          return bloc;
        },
        child: BlocListener<NotasBloc, NotasState>(
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
          child: BlocBuilder<NotasBloc, NotasState>(
                  builder: (context, state) {
                if (state is NotasInitial) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return bloc.getNotasList == null ?
                 Container() : ListView.builder(
                  itemCount: bloc.getNotasList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemNota(
                      key: UniqueKey(),
                      index: index,
                      nota: bloc.getNotasList[index].nota ?? "No hay notas",
                    );
                  },
                );
              },
        )))));
  }

TextEditingController nota = new TextEditingController();
  void _addNota(){
  showDialog(
   context: context,
   builder: (BuildContext context){
     return AlertDialog( 
       backgroundColor: Colors.transparent,
       content: new Column(
         mainAxisAlignment: MainAxisAlignment.end,
         children: <Widget>[
           Container(
             width: 380,
             color: Colors.white60,
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: (){ BlocProvider.of<NotasBloc>(context).add(
                              SaveDataEvent(
                                 nota: nota.text),
                            );
                            setState(() {
                              _isLoading = false;
                            });
                            Future.delayed(Duration(milliseconds: 1500))
                                .then((_) {
                              Navigator.of(context).pop();
                                });
                            }
            ),
          ),
          Container(
            width: 380,
            color: Colors.white60,
            child: Center( child: Text('_________________________'),),),
         Expanded(
           child: Container(
           padding: EdgeInsets.all(20),
         width: 300,
         height: 450,
         color: Colors.white60,
         child: TextField(
           autofocus: true,
                        maxLines: 50,
                        maxLength: 500,
                        style: TextStyle(fontSize: 16),
                        
                    ),
       ),
         ),
         ])
     );
   } 
  );
  }
}

