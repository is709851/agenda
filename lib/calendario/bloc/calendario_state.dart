part of 'calendario_bloc.dart';

@immutable
abstract class CalendarioState extends Equatable{
  const CalendarioState();
}

class CalendarioInitial extends CalendarioState {
  @override
  List<Object> get props => [];
}

class CloudStoreGetCData extends CalendarioState {
  @override
  List<Object> get props => [];
}

class CloudStoreGetData extends CalendarioState {
  @override
  List<Object> get props => [];
}

class CloudStoreRemoved extends CalendarioState {
  @override
  List<Object> get props => [];
}

class CloudStoreSaved extends CalendarioState {
  @override
  List<Object> get props => [];
}

