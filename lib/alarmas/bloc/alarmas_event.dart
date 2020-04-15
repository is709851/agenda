part of 'alarmas_bloc.dart';

abstract class AlarmasEvent extends Equatable {
  const AlarmasEvent();
}


class GetDataEvent extends AlarmasEvent {
  @override
  List<Object> get props => [];
}

class RemoveDataEvent extends AlarmasEvent{
  final int index;

  RemoveDataEvent({
    @required this.index,
  });
  @override
  List<Object> get props => [index];
}

class SaveDataEvent extends  AlarmasEvent{
  final int min;
  final int hora;

  SaveDataEvent({
    @required this.min,
    @required this.hora
  });
  @override
  List<Object> get props => [hora, min];
}