import 'package:agenda/notas/bloc/notas_bloc.dart';
import 'package:agenda/notas/nota_camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:agenda/menu/side_menu.dart';


class Notas extends StatefulWidget {
  final CameraDescription camera;

  Notas({Key key, this.camera}) : super(key: key);

  @override
  _NotasState createState() => _NotasState();
}

class _NotasState extends State<Notas> {
  NotasBloc bloc;

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
              _showDialog();
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
              child: null,
            )
    );
  }

  TextEditingController nota = new TextEditingController();
  void _showDialog(){
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
              onPressed: null,
            ),
          ),
          Container(
            width: 380,
            color: Colors.white60,
            child: 
          Center( child: Text('_________________________'),),),
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

