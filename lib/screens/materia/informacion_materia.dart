import 'package:flutter/material.dart';

class InformacionMateria extends StatelessWidget {
  final String tagColor;
  final Color color;
  final String tagNombre;
  final String nombre;

  InformacionMateria({this.tagColor, this.color, this.tagNombre, this.nombre});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1E2C3D),
        title: Text(
          nombre,
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[Icon(Icons.cake)],
      ),
      backgroundColor: Color(0xFF1E2C3D),
     
    );
  }
}
