import 'package:agenda_escolar/components/boton_calendario.dart';
import 'package:agenda_escolar/models/jornada.dart';
import 'package:agenda_escolar/utils/database.dart';
import 'package:flutter/material.dart';


final keyInicio = GlobalKey<BotonCalendarioState>(debugLabel: 'inicio');
final keyFinal = GlobalKey<BotonCalendarioState>(debugLabel: 'final');

class ConfiguracionJornada extends StatefulWidget {

  final _ConfiguracionJornadaState state = _ConfiguracionJornadaState();

  Future<bool> guardarDatos()async{
    return state.guardarDatos();
  }

  Future<void> eliminarDatos()async{
    state.borrarDatos();
  }

  @override
  _ConfiguracionJornadaState createState() => _ConfiguracionJornadaState();
}

class _ConfiguracionJornadaState extends State<ConfiguracionJornada> with AutomaticKeepAliveClientMixin{

  Future<bool> guardarDatos()async {
    int duracion = keyFinal.currentState.controladorTemp.difference(keyInicio.currentState.controladorTemp).inDays + 1;
    if(duracion-1 > 0){
      Jornada temp = Jornada(id: 0, duracion: duracion);
      await DBProvider.db.nuevaJornada(temp);
      return true;
    }
    else{
      return false;
    }
  }

  Future<void> borrarDatos()async{
    await DBProvider.db.eliminarJornada(0);
    for(int i = 0; i < 7; i++){
      DBProvider.db.eliminarDia(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Seleccione la fecha en la cual inicia su ciclo escolar"),
          BotonCalendario(key: keyInicio,),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Text("Seleccione la fecha en la cual finaliza su ciclo escolar"),
          BotonCalendario(key:keyFinal,),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}
