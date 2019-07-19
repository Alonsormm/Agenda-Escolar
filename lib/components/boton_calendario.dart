import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BotonCalendario extends StatefulWidget {

  BotonCalendario({this.controlador});
  final DateTime controlador;

  final _BotonCalendarioState state = _BotonCalendarioState();

  DateTime getFecha(){
    return state.getFecha();
  }

  @override
  _BotonCalendarioState createState(){
    return state;
  }
}

class _BotonCalendarioState extends State<BotonCalendario> {
  DateFormat dateFormat = DateFormat("d MMM y");

  DateTime controlador;
  DateTime controladorTemp;

  @override
  void initState() {
    super.initState();
    controlador = widget.controlador;
    controladorTemp = controlador;
  }

  DateTime getFecha(){
    return controladorTemp;
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
