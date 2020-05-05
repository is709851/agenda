part of 'recordatorios_bloc.dart';

abstract class RecordatoriosEvent extends Equatable {
  const RecordatoriosEvent();
}

class GetDataEvent extends RecordatoriosEvent {
  @override
  List<Object> get props => [];
}

class ImportanteEvent extends RecordatoriosEvent{
  
  @override
  List<Object> get props => [];
}

class RemoveDataEvent extends RecordatoriosEvent{
  final int index;

  RemoveDataEvent({
    @required this.index,
  });
  @override
  List<Object> get props => [index];
}

class DeleteImportanteEvent extends RecordatoriosEvent{
  final int index;

  DeleteImportanteEvent({
    @required this.index,
  });
  @override
  List<Object> get props => [index];
}

class SaveDataEvent extends RecordatoriosEvent{
  final String titulo;
  final String descripcion;
  /* final bool lun;
  final bool mar;
  final bool mie;
  final bool jue;
  final bool vie;
  final bool sab;
  final bool dom;
  DateTimeField hora; */

  SaveDataEvent({
    @required this.titulo,
    @required this.descripcion,
    /* @required this.lun,
    @required this.mar,
    @required this.mie,
    @required this.jue,
    @required this.vie,
    @required this.sab,
    @required this.dom, 
     this.hora,*/
  });
  @override
  List<Object> get props => [titulo, descripcion, /* lun, mar, mie, jue, vie, sab, dom, hora */];
}