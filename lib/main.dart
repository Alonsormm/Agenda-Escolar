import 'dart:developer';

import 'package:agenda_escolar/models/materia.dart';
import 'package:agenda_escolar/models/profesor.dart';
import 'package:agenda_escolar/screens/onboarding/onborarding.dart';
import 'package:agenda_escolar/utils/database_helper.dart';
import 'package:flutter/material.dart';
main()async{
  //Profesor profesor = Profesor(id: 1,nombre: "Alfonso", informacionDeContacto: "correo");
  //DBProvider.db.nuevoProfesor(profesor);
  runApp(MaterialApp(
      title: "Agenda Escolar",
      home: Home(),
    ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Onboarding(),
    );
  }
}