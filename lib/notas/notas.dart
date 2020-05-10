import 'dart:io';

import 'package:agenda/notas/item_nota.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

import 'bloc/notas_bloc.dart';

class Notas extends StatefulWidget {
  final CameraDescription camera;

  Notas({Key key, this.camera}) : super(key: key);

  @override
  _NotasState createState() => _NotasState();
}

class _NotasState extends State<Notas> 
with AutomaticKeepAliveClientMixin<Notas>{
  
  NotasBloc bloc;
  File _picture;
  String _uploadedFileUrl;
  
  final _formKey = GlobalKey<FormState>();

  @override
  bool get wantKeepAlive => true;

  Future getImage() async {
    _picture = await ImagePicker.pickImage(source: ImageSource.camera);
    showFoto();
  }

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
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Center(
            child: Text('Notas'),
          ),
          backgroundColor: Color(0xFFff971e).withOpacity(0.6),
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
                getImage();
              },
            )
          ],
        ),
        body: Container(
            padding: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
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
                          content: Text("Nota eliminada"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                  } else if (state is CloudStoreError) {
                    Scaffold.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text("${state.errorMessage}"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                  } else if (state is CloudStoreSaved) {
                    Scaffold.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text("Nota guardada"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                  } else if (state is CloudStoreGetData) {
                    Scaffold.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text("Todas las notas se cargaron"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                  }
                }, child: BlocBuilder<NotasBloc, NotasState>(
                  builder: (context, state) {
                    if (state is NotasInitial) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return bloc.getNotasList == null
                        ? Center(
                            child: Text('No tienes notas agregadas'),
                          )
                        : ListView.builder(
                            itemCount: bloc.getNotasList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ItemNota(
                                key: UniqueKey(),
                                index: index,
                                nota: bloc.getNotasList[index].nota ??
                                    "No hay notas",
                                titulo: bloc.getNotasList[index].titulo ?? "",
                                urlImage: bloc.getNotasList[index].image ?? '',
                              );
                            },
                          );
                  },
                )))));
  }

  TextEditingController nota = new TextEditingController();
  TextEditingController titulo = new TextEditingController();
  void _addNota() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Color(0xFFffd545).withOpacity(0.9),
              content: new Form(
                key: _formKey,
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.transparent)),
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              decoration: InputDecoration(labelText: 'Título'),
                              autofocus: true,
                              maxLength: 20,
                              maxLines: 1,
                              controller: titulo,
                            )),
                        flex: 4,
                      ),
                      Expanded(
                        child: Container(
                          child: IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () async {
                                if (_formKey.currentState.validate()){
                                  createNota();
                                  Future.delayed(Duration(milliseconds: 1000))
                                      .then((_) {
                                    Navigator.of(context).pop();
                                  });
                                  nota.clear();
                                }
                              }),
                        ),
                      )
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: 300,
                        height: 450,
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Tu nota esta vacía';
                            }
                          },
                          controller: nota,
                          autofocus: true,
                          maxLines: 50,
                          maxLength: 500,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    )
                  ])
              )
            );
        });
  }

  void createNota() async {

    await Firestore.instance.collection('notas').document().setData({
      'nota': nota.text,
      'titulo': titulo.text,
      'image': _uploadedFileUrl,
    });
  }

  showFoto() async {
    if (_picture != null) {
      showDialog(
          context: context,
          child: AlertDialog(
            content: Container(
              height: 500,
              child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        color: Color(0xFFffd545).withOpacity(0.9),
                        child: Text('Guardar'),
                        onPressed: (){
                          saveFoto();
                          Navigator.of(context).pop();
                          },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  child: Image.file(_picture),
                )
              ],
            ),),
          ));
    }
  }

  Future<void> saveFoto() async {
    StorageReference reference = FirebaseStorage.instance
    .ref()
    .child('images/${Path.basename(_picture.path)}');

    StorageUploadTask uploadTask = reference.putFile(_picture);
    await uploadTask.onComplete;

   _uploadedFileUrl = _picture.path;
   /*  reference.getDownloadURL().then((fileUrl){
      setState((){
        _uploadedFileUrl = fileUrl;
      });
    }); */
    createNota();
  }
}
