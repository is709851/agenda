part of 'recordatorios_bloc.dart';

abstract class RecordatoriosEvent extends Equatable {
  const RecordatoriosEvent();
}

class GetDataEvent extends RecordatoriosEvent {
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

class SaveDataEvent extends RecordatoriosEvent{
  final String titulo;
  final String descripcion;

  SaveDataEvent({
    @required this.titulo,
    @required this.descripcion
  });
  @override
  List<Object> get props => [titulo, descripcion];
}