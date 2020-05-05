part of 'recordatorios_bloc.dart';

abstract class RecordatoriosState extends Equatable{
  const RecordatoriosState();
}

class RecordatoriosInitial extends RecordatoriosState{
  @override
  List<Object> get props => [];
}

class CloudStoreError extends RecordatoriosState {
  final String errorMessage;

  CloudStoreError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class CloudStoreRemoved extends RecordatoriosState {
  @override
  List<Object> get props => [];
}

class CloudStoreSaved extends RecordatoriosState {
  @override
  List<Object> get props => [];
}

class CloudStoreGetData extends RecordatoriosState {
  @override
  List<Object> get props => [];
}

class CloudStoreGetDestacados extends RecordatoriosState {
  @override
  List<Object> get props => [];
}
