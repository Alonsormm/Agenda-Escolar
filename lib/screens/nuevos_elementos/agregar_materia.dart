import 'package:flutter/material.dart';
import 'package:agenda_escolar/models/materia.dart';

class AgregarMateria extends StatefulWidget {

  final Materia temp;

  AgregarMateria({this.temp});

  final _AgregarMateriaState state = _AgregarMateriaState();


  @override
  _AgregarMateriaState createState() => state;
}

class _AgregarMateriaState extends State<AgregarMateria> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Materia"),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}