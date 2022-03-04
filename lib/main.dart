import 'package:flutter/material.dart';
import 'package:practica_1/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
            iconColor: Colors.purple, fillColor: Colors.purple),
        textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.purple,
            selectionColor: Colors.purple,
            selectionHandleColor: Colors.purple),
        appBarTheme: const AppBarTheme(color: Colors.purple),
      ),
      home: HomePage(),
    );
  }
}
