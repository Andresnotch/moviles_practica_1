part of 'frases_bloc.dart';

abstract class FrasesEvent extends Equatable {
  const FrasesEvent();

  @override
  List<Object> get props => [];
}

class FrasesObtenerHora extends FrasesEvent {
  final String tz;

  FrasesObtenerHora(this.tz);

  List<Object> get props => [tz];
}

class FrasesIniciar extends FrasesEvent {}
