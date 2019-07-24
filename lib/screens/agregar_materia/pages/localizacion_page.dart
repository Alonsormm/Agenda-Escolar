import 'package:agenda_escolar/models/localizacion.dart';
import 'package:agenda_escolar/screens/agregar_materia/partes/localizaciones.dart';
import 'package:agenda_escolar/utils/database.dart';
import 'package:flutter/material.dart';

class LocalizacionPage extends StatefulWidget {
  final Map<String, bool> dias;
  LocalizacionPage({Key key, this.dias}) : super(key: key);

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
      return true;
    }
  }

  List<int> listIdLocalizaciones(){
    print(localizacionPartKey.currentState.obtenerValues());
    return localizacionPartKey.currentState.obtenerValues();
  }



  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        LocalizacionPart(
          key: localizacionPartKey,
          dias: widget.dias,
        )
      ],
    );
  }
}
