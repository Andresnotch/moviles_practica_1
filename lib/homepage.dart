import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
      backLayer: Center(),
      frontLayer: Stack(
        children: [
          FadeInImage(
              placeholder: AssetImage('assets/default.jpg'),
              image: AssetImage('assets/default.jpg')),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('hola'),
                Text('hola2'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
