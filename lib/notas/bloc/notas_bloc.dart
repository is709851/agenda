import 'dart:async';
import 'dart:io';

import 'package:agenda/tipos/nota.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'notas_event.dart';
part 'notas_state.dart';

class NotasBloc extends Bloc<NotasEvent, NotasState> {
  List<Nota> _notasList;
  List<Nota> get getNotasList => _notasList;
  final Firestore _firestoreInstance = Firestore.instance;
  List<DocumentSnapshot> _documentsList;
  File _picture;

  List<Nota> _notasImportanteList;
  List<Nota> get getImportantesList => _notasImportanteList;
  List<DocumentSnapshot> _documentsListD;

  @override
  NotasState get initialState => NotasInitial();

  @override
  Stream<NotasState> mapEventToState(
    NotasEvent event,
  ) async* {
    if(event is GetDataEvent){
      bool dataRetrieved = await _getData();
      if (dataRetrieved)
        yield CloudStoreGetData();
      else
        yield CloudStoreError(
          errorMessage: "No se han podido conseguir datos.",
        );
    }else if (event is SaveDataEvent) {
      bool saved = await _saveNota(
        event.nota,
        event.titulo,
        event.image
      );
      if (saved) {
        await _getData();
        yield CloudStoreSaved();
      } else
        yield CloudStoreError(
          errorMessage: "Ha ocurrido un error. Intente guardar mas tarde.",
        );
    } else if (event is RemoveDataEvent) {
      try {
        await _documentsList[event.index].reference.delete();
        _documentsList.removeAt(event.index);
        _notasList.removeAt(event.index);
        yield CloudStoreRemoved();
      } catch (err) {
        yield CloudStoreError(
          errorMessage: "Ha ocurrido un error. Intente borrar mas tarde.",
        );
      }
    } else if( event is TakePictureEvent){
      await _takePicture();
      if(_picture != null){
        yield PictureChosenState(image: _picture);
      }else{
        yield ErrorState(message: "No se tomó la foto");
      }
    }
    else if(event is ImportantesEvent){
      bool dataRetrieved = await _getDestacado();
      if (dataRetrieved)
       yield CloudStoreGetData();
    }
  }

  Future<void> _takePicture() async {
    _picture = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 320,
      maxWidth: 320,
    );
  }

  Future<bool> _getData() async {
    try {
      var notas =
          await _firestoreInstance.collection("/notas").getDocuments();
      _notasList = notas.documents
          .map(
            (nota) => Nota(
              nota: nota["nota"],
              titulo: nota["titulo"],
              image: nota["image"]
            ),
          )
          .toList();
      _documentsList = notas.documents;
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future<bool> _getDestacado() async {
    try {
      var notasD =
          await _firestoreInstance.collection("/notasDestacadas").getDocuments();
      _notasImportanteList = notasD.documents
          .map(
            (nota) => Nota(
              nota: nota["nota"], 
              titulo: nota["titulo"],  
            ),
          )
          .toList();
      _documentsListD = notasD.documents;
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future<bool> _saveNota(
    String nota,
    String titulo,
    String image
  ) async {
    try {
      await _firestoreInstance.collection("notas").document().setData({
        "nota": nota,
        "titulo": titulo,
        "image": image
      });
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }
}
