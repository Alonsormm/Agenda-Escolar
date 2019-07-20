import 'package:agenda_escolar/components/boton_calendario.dart';
import 'package:flutter/material.dart';


final keyInicio = GlobalKey<BotonCalendarioState>(debugLabel: 'inicio');
final keyFinal = GlobalKey<BotonCalendarioState>(debugLabel: 'final');

class ConfiguracionJornada extends StatefulWidget {

  final _ConfiguracionJornadaState state = _ConfiguracionJornadaState();

  void guardarDatos(){
    state.guardarDatos();
  }

  @override
  _ConfiguracionJornadaState createState() => _ConfiguracionJornadaState();
}

class _ConfiguracionJornadaState extends State<ConfiguracionJornada> {
  // DateTime inicioJornada = DateTime.now();
  // DateTime finJornada = DateTime.now()

  void guardarDatos(){
    //int duracion = inicio.getFecha().difference(fin.getFecha()).inDays;
    //print(inicio.getFecha());
    //TODO
    print(keyInicio.currentState.controladorTemp.difference(keyFinal.currentState.controladorTemp).inDays);
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
          BotonCalendario(key: keyInicio,),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Text("Seleccione la fecha en la cual finaliza su ciclo escolar"),
          BotonCalendario(key:keyFinal,),
          Text("Seleccione los dias de la semana que va a la escuela"),
          _listaDeDias(),
          Padding(
            padding: EdgeInsets.only(top: 40),
          ),
        ],
      ),
    );
  }

  Widget _listaDeDias() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.only(left: 50, right: 50),
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
