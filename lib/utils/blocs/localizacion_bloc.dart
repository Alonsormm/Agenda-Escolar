import 'dart:async';


import 'package:agenda_escolar/utils/database_helper.dart';
import 'package:agenda_escolar/models/localizacion.dart';

class LocalizacionesBloc{
  final _localizacionController = StreamController<List<Localizacion>>.broadcast();

  get localizacion => _localizacionController.stream;

  dispose(){
    _localizacionController.close();
  }

  getLocalizaciones()async{
    _localizacionController.sink.add(await DBProvider.db.obtenerTodasLasLocalizaciones());
  }

  LocalizacionesBloc(){
    getLocalizaciones();
  }

  delete(int id)async{
    await DBProvider.db.eliminarLocalizacion(id);
    getLocalizaciones();
  }

  update(Localizacion localizacion)async{
    await DBProvider.db.actualizarLocalizacion(localizacion);
    getLocalizaciones();
  }

  add(Localizacion localizacion)async{
    await DBProvider.db.nuevaLocalizacion(localizacion);
    getLocalizaciones();
  } 
}