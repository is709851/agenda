import 'dart:async';

import 'package:agenda/tipos/recordatorio.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'recordatorios_event.dart';
part 'recordatorios_state.dart';

class RecordatoriosBloc extends Bloc<RecordatoriosEvent, RecordatoriosState> {
  List<Recordatorio> _recordatoriosList;
  List<Recordatorio> get getRecordatoriosList => _recordatoriosList;
  final Firestore _firestoreInstance = Firestore.instance;
  List<DocumentSnapshot> _documentsList;

// Lista de destacados
  List<Recordatorio> _listImportante;
  List<Recordatorio> get getImportanteList => _listImportante;
  List<DocumentSnapshot> _documentsListD;

  @override
  RecordatoriosState get initialState => RecordatoriosInitial();

  @override
  Stream<RecordatoriosState> mapEventToState(
    RecordatoriosEvent event,
  ) async* {
    if(event is GetDataEvent){
      bool dataRetrieved = await _getData();
      if (dataRetrieved)
        yield CloudStoreGetData();
    }else if (event is SaveDataEvent) {
     /*  bool saved = await _saveRecordatorio(
        event.titulo,
        event.descripcion,
       /*  event.lun,
        event.mar,
        event.mie,
        event.jue,
        event.vie,
        event.sab,
        event.dom,
        event.hora */
      );
      if (saved) {
        await _getData();
        yield CloudStoreSaved();
      } else
        yield CloudStoreError(
          errorMessage: "Ha ocurrido un error. Intente guardar mas tarde.",
        ); */
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
    } else if(event is ImportanteEvent){
      bool dataRetrieved = await _getDestacado();
      if (dataRetrieved)
        yield CloudStoreGetData();
    } else if(event is DeleteImportanteEvent){
      try {
        await _documentsList[event.index].reference.delete();
        _documentsList.removeAt(event.index);
        _listImportante.removeAt(event.index);
        //yield CloudStoreRemoved();
      } catch (err) {
        yield CloudStoreError(
          errorMessage: "Ha ocurrido un error.",
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

  Future<bool> _getDestacado() async {
    try {
      var recordatoriosD =
          await _firestoreInstance.collection("/recordatoriosDestacados").getDocuments();
      _listImportante = recordatoriosD.documents
          .map(
            (recordatorio) => Recordatorio(
              titulo: recordatorio["titulo"], 
              descripcion: recordatorio["descripcion"],  
            ),
          )
          .toList();
      _documentsListD = recordatoriosD.documents;
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }


  /* Future<bool> _saveRecordatorio(
    String titulo,
    String descripcion,
   /*  bool lun,
    bool mar,
    bool mie,
    bool jue,
    bool vie,
    bool sab,
    bool dom,
    DateTimeField hora, */

  ) async {
    try {
      await _firestoreInstance.collection("recordatorios").document().setData({
        "titulo": titulo,
        "descripcion": descripcion,
      /*   "lun": lun,
        "mar": mar,
        "mie": mie,
        "jue": jue,
        "vie": vie,
        "sab": sab,
        "dom": dom,
        "hora": hora */
      });
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  } */
}