import 'package:flutter/material.dart';
import 'views/planetas_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Planetas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TelaInicial(),
    );
  }
}