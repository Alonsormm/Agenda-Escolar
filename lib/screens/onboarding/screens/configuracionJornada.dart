import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConfiguracionJornada extends StatefulWidget {
  @override
  _ConfiguracionJornadaState createState() => _ConfiguracionJornadaState();
}

class _ConfiguracionJornadaState extends State<ConfiguracionJornada> {
  final format = DateFormat("yyyy-MM-dd");
  DateTime inicioDeJornada = DateTime.now();
  DateTime finalDeJornada = DateTime.now();
  Map <String,bool> dias = {
    "Lunes":true,
    "Martes":true,
    "Miercoles" : true,
    "Jueves" : true,
    "Viernes" : true,
    "Sabado" : false,
    "Domingo" : false
  };
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 100),
          ),
          Text("Seleccione la fecha en la cual inicia su ciclo escolar"),
          FlatButton(
            child: Text(format.format(inicioDeJornada)),
            onPressed: () async{
              DateTime pickerInicio = await showDatePicker(
                context: context,
                initialDate: inicioDeJornada,
                firstDate: DateTime(2000),
                lastDate: DateTime(2030),
              );
              if(pickerInicio!=null && pickerInicio!= inicioDeJornada){
                setState(() {
                  inicioDeJornada=pickerInicio;
                });
              }
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Text("Seleccione la fecha en la cual finaliza su ciclo escolar"),
          FlatButton(
            child: Text(format.format(finalDeJornada)),
            onPressed: () async{
              DateTime pickerFinal = await showDatePicker(
                context: context,
                initialDate: finalDeJornada,
                firstDate: DateTime(2000),
                lastDate: DateTime(2030),
              );
              if(pickerFinal!=null && pickerFinal!= inicioDeJornada){
                setState(() {
                  finalDeJornada=pickerFinal;
                });
              }
            },
          ),
          Text("Seleccione los dias de la semana que va a la escuela"),
          Expanded(  
            child: ListView(
              padding: EdgeInsets.only(left: 50, right: 50),
              physics: NeverScrollableScrollPhysics(),
              children: dias.keys.map((String dia){
                return CheckboxListTile(
                  title: Text(dia),
                  value: dias[dia],
                  onChanged: (bool value){
                    setState(() {
                      dias[dia] = value;
                    });
                  },
                );
              }).toList(),
              ),
          )
        ],
    );
  }
}
