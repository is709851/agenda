part of 'notas_bloc.dart';

abstract class NotasState extends Equatable{
  const NotasState();
}

class NotasInitial extends NotasState{
  @override
  List<Object> get props => [];
}

class CloudStoreError extends NotasState {
  final String errorMessage;

  CloudStoreError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class CloudStoreRemoved extends NotasState {
  @override
  List<Object> get props => [];
}

class CloudStoreSaved extends NotasState {
  @override
  List<Object> get props => [];
}

class CloudStoreGetData extends NotasState {
  @override
  List<Object> get props => [];
}
