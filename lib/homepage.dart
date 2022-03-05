import 'dart:io';
import 'dart:ui';

import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_1/bloc/frases_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FrasesBloc>(context).add(
      FrasesIniciar(),
    );
    //BlocProvider.of<FrasesBloc>(context).add(
    //  FrasesObtenerHora('America/Mexico_City'),
    //);

    return BackdropScaffold(
        backLayerBackgroundColor: Colors.purple,
        appBar: BackdropAppBar(
          title: const Text('Frase del dia'),
          actions: <Widget>[
            BackdropToggleButton(
              icon: AnimatedIcons.list_view,
            )
          ],
        ),
        backLayer: BlocConsumer<FrasesBloc, FrasesState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FrasesCountriesLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FrasesCountriesUpdatedState) {
              return Center();
            }
            return Container();
          },
        ),
        frontLayer: BlocConsumer<FrasesBloc, FrasesState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FrasesLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            return Stack(
              children: [
                Positioned.fill(
                  child: ColorFiltered(
                    colorFilter:
                        ColorFilter.mode(Colors.grey, BlendMode.darken),
                    child: (state is FrasesUpdatedState)
                        ? Image.file(File(state.imagen))
                        : Image.asset('assets/default.jpg'),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '23:14:16',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      ),
                      Text(
                        (state is FrasesUpdatedState)
                            ? state.frase['q'] + '\n' + '- ${state.frase['a']}'
                            : 'Loading...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
