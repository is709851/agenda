import 'dart:async';

import 'package:agenda/tipos/alarma.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'alarmas_event.dart';
part 'alarmas_state.dart';

class AlarmasBloc extends Bloc<AlarmasEvent, AlarmasState> {
  
  List<Alarma> _alarmaList;
  List<Alarma> get getNotasList => _alarmaList;
  final Firestore _firestoreInstance = Firestore.instance;
  List<DocumentSnapshot> _documentsList;

  @override
  AlarmasState get initialState => AlarmasInitial();

  @override
  Stream<AlarmasState> mapEventToState(
    AlarmasEvent event,
  ) async* {
  if(event is GetDataEvent){
      bool dataRetrieved = await _getData();
      if (dataRetrieved)
        yield CloudStoreGetData();
      else
        yield CloudStoreError(
          errorMessage: "No se ha podido conseguir datos.",
        );
    }else if (event is SaveDataEvent) {
      bool saved = await _saveAlarma(
        event.hora, 
        event.min,
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
        _alarmaList.removeAt(event.index);
        yield CloudStoreRemoved();
      } catch (err) {
        yield CloudStoreError(
          errorMessage: "Ha ocurrido un error. Intente borrar mas tarde.",
        );
      }
    }else if(event is AlarmasMenuEvent){
       bool dataRetrieved = await _getData();
      if (dataRetrieved)
        yield CloudStoreGetData();
      else
        yield CloudStoreError(
          errorMessage: "No se ha podido conseguir datos.",
        );
    }
  }

  Future<bool> _getData() async {
    try {
      var alarma =
          await _firestoreInstance.collection("alarmas").getDocuments();
      _alarmaList = alarma.documents
          .map(
            (alarma) => Alarma(
              tiempo: alarma["tiempo"], 
              titulo: alarma["titulo"],
              lun: alarma["lun"],
              mar: alarma["mar"],
              mie: alarma["mie"],
              jue: alarma["jue"],
              vie: alarma["vie"],
              sab: alarma["sab"],
              dom: alarma["dom"],
              activada: alarma["activada"]
            ),
          )
          .toList();
      _documentsList = alarma.documents;
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future<bool> _saveAlarma(
    int hora,
    int minuto,
  ) async {
    try {
      await _firestoreInstance.collection("alarmas").document().setData({
        "hora": hora,
        "min": minuto,
      });
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }
}

