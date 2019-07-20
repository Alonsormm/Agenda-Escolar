import 'dart:async';

import 'package:agenda_escolar/models/materia.dart';
import 'package:agenda_escolar/utils/database_helper.dart';

class MateriasBloc{
  final _materiasController = StreamController<List<Materia>>.broadcast();

  get materias => _materiasController.stream;

  dispose(){
    _materiasController.close();
  }

  getMaterias() async{
    _materiasController.sink.add(await DBProvider.db.obtenerTodasLasMaterias());
  }

  MateriasBloc(){
    getMaterias();
  }

  delete(int id){
    DBProvider.db.eliminarMateria(id);
    getMaterias();
  }

  add(Materia materia){
    DBProvider.db.nuevaMateria(materia);
    getMaterias();
  } 

}