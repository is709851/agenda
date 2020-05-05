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
  final String titulo;
  final String image;

  SaveDataEvent(this.titulo, this.image, {
    @required this.nota
  });
  @override
  List<Object> get props => [nota, titulo, image];
}

class TakePictureEvent extends NotasEvent{
  @override
  List<Object> get props => [];
}

class ImportantesEvent extends NotasEvent{
  @override
  List<Object> get props => [];
}
