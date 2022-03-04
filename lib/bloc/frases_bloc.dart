import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'frases_event.dart';
part 'frases_state.dart';

class FrasesBloc extends Bloc<FrasesEvent, FrasesState> {
  FrasesBloc() : super(FrasesInitial()) {
    on<FrasesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
