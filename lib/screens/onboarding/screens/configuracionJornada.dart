import 'package:agenda_escolar/components/boton_calendario.dart';
import 'package:agenda_escolar/models/Jornada.dart';
import 'package:agenda_escolar/utils/database_helper.dart';
import 'package:flutter/material.dart';

class ConfiguracionJornada extends StatefulWidget {

  final _ConfiguracionJornadaState state = _ConfiguracionJornadaState();

  List<DateTime>obtenerFechar(){
    return state.obtenerFechas();
  }

  void guardarDatos(){
    state.guardarDatos();
  }

  @override
  _ConfiguracionJornadaState createState() => _ConfiguracionJornadaState();
}

class _ConfiguracionJornadaState extends State<ConfiguracionJornada> {
  // DateTime inicioJornada = DateTime.now();
  // DateTime finJornada = DateTime.now();

  BotonCalendario inicio = BotonCalendario(controlador: DateTime.now(),);
  BotonCalendario fin = BotonCalendario(controlador: DateTime.now(),);

  List<DateTime> obtenerFechas(){
    return [inicio.getFecha(),fin.getFecha()];
  }

  void guardarDatos(){
    int duracion = inicio.getFecha().difference(fin.getFecha()).inDays;
    print(duracion);
  }

  Map<String, bool> dias = {
    "Lunes": true,
    "Martes": true,
    "Miercoles": true,
    "Jueves": true,
    "Viernes": true,
    "Sabado": false,
    "Domingo": false
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 100),
          ),
          Text("Seleccione la fecha en la cual inicia su ciclo escolar"),
          inicio,
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Text("Seleccione la fecha en la cual finaliza su ciclo escolar"),
          fin,
          Text("Seleccione los dias de la semana que va a la escuela"),
          _listaDeDias(),
        ],
      ),
    );
  }

  Widget _listaDeDias() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.only(left: 50, right: 50),
        physics: NeverScrollableScrollPhysics(),
        children: dias.keys.map((String dia) {
          return CheckboxListTile(
            title: Text(dia),
            value: dias[dia],
            activeColor: Colors.black,
            onChanged: (bool value) {
              setState(() {
                dias[dia] = value;
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
