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
      color: Color(0xFF00FFF7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Text(dateFormat.format(controlador), style: TextStyle(color: Colors.black),),
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
