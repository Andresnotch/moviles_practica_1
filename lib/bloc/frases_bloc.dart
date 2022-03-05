import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practica_1/utils/secrets.dart';

part 'frases_event.dart';
part 'frases_state.dart';

class FrasesBloc extends Bloc<FrasesEvent, FrasesState> {
  FrasesBloc() : super(FrasesInitial()) {
    on<FrasesIniciar>(_updateCountries);
  }
}

FutureOr<void> _updateCountries(FrasesEvent event, Emitter emit) async {
  if (event is FrasesIniciar) {
    emit(FrasesLoadingState());
  }
  emit(FrasesCountriesLoadingState());
  var tz_to_country_uri = Uri.parse(
      'http://api.timezonedb.com/v2.1/list-time-zone?format=json&key=' +
          TZCONVERTKEY);

  var times_tz_uri = Uri.parse('http://worldtimeapi.org/api/timezone');
  try {
    var res = await get(tz_to_country_uri);
    if (res.statusCode != 200) {
      throw Exception();
    }
    List tz_to_country =
        (jsonDecode(res.body) as Map)['zones']; // List of tz to countries

    res = await get(times_tz_uri);
    if (res.statusCode != 200) {
      throw Exception();
    }
    List times_tz = jsonDecode(res.body); // List of timezones in worldtimeapi

    Map<String, String> available_tz = Map();
    Map<String, String> tz_countries_imgs = Map();
    Directory flagDir = await getTemporaryDirectory();

    for (var tz in tz_to_country.getRange(0, 6)) {
      if (times_tz.contains(tz['zoneName'])) {
        // Try to get flag
        var flag_uri = Uri.parse('https://flagcdn.com/w40/' +
            tz['countryCode'].toString().toLowerCase() +
            '.png');

        var res = await get(flag_uri);
        if (res.statusCode != 200) {
          throw Exception('There is no flag');
        }
        File flag_file = new File(
            '${flagDir.path}/${tz['countryCode'].toString().toLowerCase()}.png');

        await flag_file.writeAsBytes(res.bodyBytes);

        available_tz[tz['zoneName']] = tz['countryCode'];
        tz_countries_imgs[tz['zoneName']] =
            '${flagDir.path}/${tz['countryCode'].toString().toLowerCase()}.png';
      }
    }
    emit(FrasesCountriesUpdatedState(available_tz, tz_countries_imgs, ''));
    await _updatePhrase(event, emit);
  } catch (e) {
    emit(FrasesErrorState('No se pudo cargar'));
  }
}

FutureOr<void> _updatePhrase(FrasesEvent event, Emitter emit) async {
  emit(FrasesLoadingState());
  await Future.delayed(
      Duration(seconds: 1)); //Simulate loading to see loading widget

  var image_uri = Uri.parse('https://picsum.photos/600/900');
  Directory imgDir = await getTemporaryDirectory();

  var phrase_uri = Uri.parse('https://zenquotes.io/api/random');

  try {
    var res = await get(image_uri);
    if (res.statusCode != 200) {
      throw Exception();
    }
    File flag_file = new File('${imgDir.path}/today.png');
    await flag_file.writeAsBytes(res.bodyBytes);

    res = await get(phrase_uri);
    if (res.statusCode != 200) {
      throw Exception();
    }
    Map decoded = (jsonDecode(res.body) as List)[0];
    emit(FrasesUpdatedState(decoded, '${imgDir.path}/today.png'));
  } catch (e) {
    emit(FrasesErrorState('No se pudieron cargar las frases'));
  }
}
