import 'dart:async';

import 'package:agenda/notas/nota.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'notas_event.dart';
part 'notas_state.dart';

class NotasBloc extends Bloc<NotasEvent, NotasState> {
   List<Nota> _notasList;
  List<Nota> get getNotasList => _notasList;
  final Firestore _firestoreInstance = Firestore.instance;
  List<DocumentSnapshot> _documentsList;

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
        event.nota
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
    }
  }

  Future<bool> _getData() async {
    try {
      var notas =
          await _firestoreInstance.collection("/notas").getDocuments();
      _notasList = notas.documents
          .map(
            (nota) => Nota(
              nota: nota["nota"],
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

  Future<bool> _saveNota(
    String nota
  ) async {
    try {
      await _firestoreInstance.collection("notas").document().setData({
        "nota": nota,
        
      });
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }
}
