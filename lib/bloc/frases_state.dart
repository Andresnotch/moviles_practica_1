part of 'frases_bloc.dart';

@immutable
abstract class FrasesState {}

class FrasesInitial extends FrasesState {}

class FrasesNoDataState extends FrasesState {}

class FrasesLoadingState extends FrasesState {}

class FrasesUpdatedState extends FrasesState {
  final Map frase;
  final Map imagen;
  final Map hora;
  final Map paises;

  List<Object> get props => [decodedResult];
}
