import 'dart:async';

import 'package:agenda_escolar/utils/database_helper.dart';
import 'package:agenda_escolar/models/modulo.dart';

class ModulosMateriaBloc{
  final _modulosController = StreamController<List<Modulo>>.broadcast();

  get modulo => _modulosController.stream;

  int idMateria;

  dispose(){
    _modulosController.close();
  }


  getModulos() async {
    _modulosController.sink.add(await DBProvider.db.obtenerTodosLosModulosPorMateria(idMateria));
  }

  ModulosMateriaBloc(int idMat){
    idMateria = idMat;
    getModulos();
  }

  delete(int idModulo)async{
    await DBProvider.db.eliminarModulo(idModulo);
    getModulos();
  }

  update(Modulo modulo)async{
    await DBProvider.db.actualizarModulo(modulo);
    getModulos();
  }

  add(Modulo modulo)async{
    await DBProvider.db.nuevaModulo(modulo);
    getModulos();
  }
}