import 'dart:async';

import 'package:agenda_escolar/models/materia.dart';
import 'package:agenda_escolar/utils/database.dart';

class MateriasBloc{
  final _materiasController = StreamController<List<Materia>>.broadcast();

  get materias => _materiasController.stream;
  bool _isDisposed = false;

  dispose(){
    _materiasController.close();
  }

  getMaterias() async{
    if(_isDisposed){
      return;
    }
    _materiasController.sink.add(await DBProvider.db.obtenerTodasLasMaterias());
    _isDisposed = true;
  }

  MateriasBloc(){
    getMaterias();
  }

  delete(int id)async{
    await DBProvider.db.eliminarMateria(id);
    getMaterias();
  }

  update(Materia materia)async{
    await DBProvider.db.actualizarMateria(materia);
    getMaterias();
  }

  add(Materia materia)async{
    await DBProvider.db.nuevaMateria(materia);
    getMaterias();
  } 

}