import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'notas_event.dart';
part 'notas_state.dart';

class NotasBloc extends Bloc<NotasEvent, NotasState> {
  @override
  NotasState get initialState => NotasInitial();

  @override
  Stream<NotasState> mapEventToState(
    NotasEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
