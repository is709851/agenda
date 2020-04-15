import 'dart:async';

import 'package:agenda/recordatorios/recordatorio.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'recordatorios_event.dart';
part 'recordatorios_state.dart';

class RecordatoriosBloc extends Bloc<RecordatoriosEvent, RecordatoriosState> {
  List<Recordatorio> _recordatoriosList;
  List<Recordatorio> get getRecordatoriosList => _recordatoriosList;
  final Firestore _firestoreInstance = Firestore.instance;
  List<DocumentSnapshot> _documentsList;


  @override
  RecordatoriosState get initialState => RecordatoriosInitial();
    
  // TODO: implement initialState;

  @override
  Stream<RecordatoriosState> mapEventToState(
    RecordatoriosEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if(event is GetDataEvent){
      bool dataRetrieved = await _getData();
      if (dataRetrieved)
        yield CloudStoreGetData();
      else
        yield CloudStoreError(
          errorMessage: "No se han podido conseguir datos.",
        );
    }else if (event is SaveDataEvent) {
      bool saved = await _saveRecordatorio(
        event.titulo,
        event.descripcion,
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
        _recordatoriosList.removeAt(event.index);
        yield CloudStoreRemoved();
      } catch (err) {
        yield CloudStoreError(
          errorMessage: "Ha ocurrido un error. Intente borrar mas tarde.",
        );
      }
    }
  }

  Future<bool> _getData() async {
    try {
      var recordatorios =
          await _firestoreInstance.collection("/recordatorios").getDocuments();
      _recordatoriosList = recordatorios.documents
          .map(
            (recordatorio) => Recordatorio(
              titulo: recordatorio["titulo"], 
              descripcion: recordatorio["descripcion"],
            ),
          )
          .toList();
      _documentsList = recordatorios.documents;
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future<bool> _saveRecordatorio(
    String titulo,
    String descripcion,
  ) async {
    try {
      await _firestoreInstance.collection("recordatorios").document().setData({
        "titulo": titulo,
        "descripcion": descripcion,
      });
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }
}