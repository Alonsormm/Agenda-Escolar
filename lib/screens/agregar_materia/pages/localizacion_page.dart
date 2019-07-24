import 'package:agenda_escolar/screens/agregar_materia/partes/localizacion.dart';
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
