import 'dart:async';

import 'package:agenda/tipos/evento.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'calendario_event.dart';
part 'calendario_state.dart';

class CalendarioBloc extends Bloc<CalendarioEvent, CalendarioState> {
  List<Evento> _eventosList;
  List<Evento> get getEventosList => _eventosList;
  final Firestore _firestoreInstance = Firestore.instance;
  List<DocumentSnapshot> _documentList;
  
  
  @override
  CalendarioState get initialState => CalendarioInitial();

  @override
  Stream<CalendarioState> mapEventToState(
    CalendarioEvent event,
  ) async* {
    if(event is GetDataCEvent){
      bool dataRetrieved = await _getData();
      if(dataRetrieved)
        yield CloudStoreGetCData();
    }
  }
  
  Future<bool> _getData() async{
    try{
      var eventos = await _firestoreInstance.collection("/eventos")
      .getDocuments();
      _eventosList = eventos.documents.map(
        (evento) => Evento(
          descripcion: evento["descripcion"],
          titulo: evento["titulo"]
        ),
      ).toList();

      _documentList = eventos.documents;
      return true;
    }catch(err){
      print(err.toString());
      return false;
    }
  }

}
