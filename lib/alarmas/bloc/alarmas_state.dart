part of 'alarmas_bloc.dart';

abstract class AlarmasState extends Equatable {
  const AlarmasState();
}

class AlarmasInitial extends AlarmasState {
  @override
  List<Object> get props => [];
}

class CloudStoreError extends AlarmasState {
  final String errorMessage;

  CloudStoreError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class CloudStoreRemoved extends AlarmasState {
  @override
  List<Object> get props => [];
}

class CloudStoreSaved extends AlarmasState {
  @override
  List<Object> get props => [];
}

class CloudStoreGetData extends AlarmasState {
  @override
  List<Object> get props => [];
}
