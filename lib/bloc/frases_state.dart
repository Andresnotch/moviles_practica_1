part of 'frases_bloc.dart';

abstract class FrasesState extends Equatable {
  const FrasesState();

  @override
  List<Object> get props => [];
}

class FrasesInitial extends FrasesState {}

class FrasesNoDataState extends FrasesState {}

class FrasesLoadingState extends FrasesState {}

class FrasesUpdatedState extends FrasesState {
  final Map frase;
  final String imagen;

  FrasesUpdatedState(this.frase, this.imagen);

  List<Object> get props => [frase, imagen];
}

class FrasesErrorState extends FrasesState {
  final String error;

  FrasesErrorState(this.error);

  List<Object> get props => [error];
}

class FrasesCountriesLoadingState extends FrasesState {}

class FrasesCountriesUpdatedState extends FrasesState {
  final Map<String, String> tzToCountries;
  final Map<String, String> flagsDirs;
  final String hora;

  FrasesCountriesUpdatedState(this.tzToCountries, this.flagsDirs, this.hora);

  List<Object> get props => [tzToCountries, flagsDirs, hora];
}
