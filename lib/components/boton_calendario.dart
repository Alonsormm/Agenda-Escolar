import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BotonCalendario extends StatefulWidget {

  BotonCalendario({ Key key }) : super(key: key);

  @override
  BotonCalendarioState createState() => BotonCalendarioState();
}

class BotonCalendarioState extends State<BotonCalendario> {
  DateFormat dateFormat = DateFormat("d MMM y");
  DateTime controlador;
  DateTime controladorTemp;

  @override
  void initState() {
    super.initState();
    controlador = DateTime.now();
    controladorTemp = controlador;
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(dateFormat.format(controlador)),
      onPressed: () async {
        DateTime picker = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2010),
          lastDate: DateTime(2030),
        );
        if (picker != null && picker != controlador) {
          controladorTemp = picker;
          setState(() {
            controlador = picker;
          });
        }
      },
    );
  }
}
