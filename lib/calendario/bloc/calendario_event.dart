part of 'calendario_bloc.dart';

abstract class CalendarioEvent extends Equatable{

  const CalendarioEvent();
}

class GetDataCEvent extends CalendarioEvent {
  @override
  List<Object> get props => [];
}

class GetDataEvent extends CalendarioEvent {
  @override
  List<Object> get props => [];
}

class RemoveDataEvent extends CalendarioEvent{
  final int index;

  RemoveDataEvent({
    @required this.index,
  });
  @override
  List<Object> get props => [index];
}