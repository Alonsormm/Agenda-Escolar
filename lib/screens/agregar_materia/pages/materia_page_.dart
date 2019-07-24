import 'package:agenda_escolar/screens/agregar_materia/partes/materia.dart';
import 'package:agenda_escolar/screens/agregar_materia/partes/modulos.dart';
import 'package:flutter/material.dart';

class MateriaPage extends StatefulWidget {

  MateriaPage({Key key}):super(key:key);

  @override
  MateriaPageState createState() => MateriaPageState();
}

class MateriaPageState extends State<MateriaPage> {
  GlobalKey<MateriaPartState> materiaPartKey = GlobalKey<MateriaPartState>(debugLabel: "materiaPartState");
  GlobalKey <ModulosPartState> modulosPartKey = GlobalKey<ModulosPartState>(debugLabel: "materiaPartState");

  Map<String,bool> dias;


  bool comprobar(){
    if(materiaPartKey.currentState.comprobarDatos() && modulosPartKey.currentState.comprobarDatos()){
      return true;
    }
    return false;
  }

  void conseguirDias(){
    dias = modulosPartKey.currentState.dias;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top : 15),),
        MateriaPart(key:  materiaPartKey,),
        ModulosPart(key:  modulosPartKey,),
      ],
    );
  }
}