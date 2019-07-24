import 'package:agenda_escolar/models/localizacion.dart';
import 'package:agenda_escolar/screens/agregar_materia/partes/localizaciones_part.dart';
import 'package:agenda_escolar/utils/database.dart';
import 'package:flutter/material.dart';

class LocalizacionPage extends StatefulWidget {
  final Map<String, bool> dias;
  final bool mismoSalon;
  final List<int> listIdLocalizaciones;
  LocalizacionPage({Key key, this.dias, this.mismoSalon, this.listIdLocalizaciones}) : super(key: key);

  @override
  LocalizacionPageState createState() => LocalizacionPageState();
}

class LocalizacionPageState extends State<LocalizacionPage> {
  GlobalKey<LocalizacionPartState> localizacionPartKey =
      GlobalKey<LocalizacionPartState>(debugLabel: "localizacionPartKey");

  @override
  void initState() {
    super.initState();
  }

  Future<bool> comprobar()async{
    List<Localizacion> listLocalizaciones = await  DBProvider.db.obtenerTodasLasLocalizaciones(); 
    if(listLocalizaciones.isEmpty){
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Introduce un salon"),));
      return false;
    }
    else{
      List<Localizacion> listLocalizaciones = await  DBProvider.db.obtenerTodasLasLocalizaciones();      
      List<int> values = localizacionPartKey.currentState.obtenerValues();
      print(listLocalizaciones.length);
      for(int i = 0 ;  i < values.length; i++){
        if(values[i] == 0 || values[i] > listLocalizaciones.length){
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Asegurate de introducir todos los datos"),));
          return false;          
        }
      }
      return true;
    }
  }

  List<int> listIdLocalizaciones(){
    return localizacionPartKey.currentState.obtenerValues();
  }

  bool mismoSalon(){
    return localizacionPartKey.currentState.mismoSalon;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        LocalizacionPart(
          key: localizacionPartKey,
          dias: widget.dias,
          mismoSalon: widget.mismoSalon,
          listIdLocalizaciones: widget.listIdLocalizaciones,
        )
      ],
    );
  }
}
