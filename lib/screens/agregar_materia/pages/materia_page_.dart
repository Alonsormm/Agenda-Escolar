import 'package:agenda_escolar/models/keys_dias_boton_hora.dart';
import 'package:agenda_escolar/models/materia.dart';
import 'package:agenda_escolar/models/modulo.dart';
import 'package:agenda_escolar/screens/agregar_materia/partes/materia_part.dart';
import 'package:agenda_escolar/screens/agregar_materia/partes/modulos_part.dart';
import 'package:flutter/material.dart';

class MateriaPage extends StatefulWidget {
  final Materia editarMateria;
  final List<Modulo> listModulos;

  MateriaPage({Key key, this.editarMateria, this.listModulos})
      : super(key: key);

  @override
  MateriaPageState createState() => MateriaPageState();
}

class MateriaPageState extends State<MateriaPage>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<MateriaPartState> materiaPartKey =
      GlobalKey<MateriaPartState>(debugLabel: "materiaPartState");
  GlobalKey<ModulosPartState> modulosPartKey =
      GlobalKey<ModulosPartState>(debugLabel: "materiaPartState");

  Map<String, bool> dias;

  bool comprobar() {
    if (materiaPartKey.currentState.comprobarDatos() &&
        modulosPartKey.currentState.comprobarDatos()) {
      return true;
    }
    return false;
  }

  void conseguirDias() {
    dias = modulosPartKey.currentState.dias;
  }

  String nombreMateria() {
    return materiaPartKey.currentState.nombreMateria.text;
  }

  int colorMateria() {
    return materiaPartKey.currentState.colorActual.value;
  }

  List<int> obtenerDiasActivos() {
    return modulosPartKey.currentState.obtenerDiasActivosInt();
  }

  List<List<String>> horas() {
    List<int> diasActivos = modulosPartKey.currentState.obtenerDiasActivosInt();
    KeysPorDiaDeBotones keysPorDiaDeBotones =
        modulosPartKey.currentState.keysPorDiaDeBotones;
    List<List<String>> listHoras = List<List<String>>();
    if (modulosPartKey.currentState.mismaHora) {
      for (int i = 0; i < diasActivos.length; i++) {
        String inicio =
            keysPorDiaDeBotones.keysGenerales()[0].currentState.hora;
        String fin = keysPorDiaDeBotones.keysGenerales()[1].currentState.hora;
        listHoras.add([inicio, fin]);
      }
    } else {
      for (int i = 0; i < diasActivos.length; i++) {
        String inicio = keysPorDiaDeBotones
            .keysPorIndice(diasActivos[i] - 1)[0]
            .currentState
            .hora;
        String fin = keysPorDiaDeBotones
            .keysPorIndice(diasActivos[i] - 1)[1]
            .currentState
            .hora;
        listHoras.add([inicio, fin]);
      }
    }
    return listHoras;
  }

  bool mismaHora() {
    return modulosPartKey.currentState.mismaHora;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Color(0xFF1E2C3D),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15),
          ),
          MateriaPart(key: materiaPartKey, materia: widget.editarMateria),
          ModulosPart(
            key: modulosPartKey,
            modulos: widget.listModulos,
            mismaHora: widget.editarMateria != null
                ? widget.editarMateria.mismaHora == 1 ? true : false
                : null,
          ),
        ],
      ),
    );
  }
}
