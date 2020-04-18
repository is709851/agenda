part of 'notas_bloc.dart';


abstract class NotasEvent extends Equatable {
  const NotasEvent();
}

class GetDataEvent extends NotasEvent {
  @override
  List<Object> get props => [];
}

class RemoveDataEvent extends NotasEvent{
  final int index;

  RemoveDataEvent({
    @required this.index,
  });
  @override
  List<Object> get props => [index];
}

class SaveDataEvent extends NotasEvent{
  final String nota;

  SaveDataEvent({
    @required this.nota
  });
  @override
  List<Object> get props => [nota];
}
