import 'package:flutter/material.dart';

class BotonHora extends StatefulWidget {

  final String hora;

  BotonHora({ Key key , this.hora}) : super(key: key);

  @override
  BotonHoraState createState() => BotonHoraState();
}

class BotonHoraState extends State<BotonHora> {
  TimeOfDay controlador;
  TimeOfDay controladorTemp;
  String hora;

  @override
  void initState() {
    super.initState();
    if(widget.hora == null){
      controlador = TimeOfDay(hour: 7, minute: 0);
      hora = controlador.toString().substring(10, 15);
    }
    else{
      controlador = TimeOfDay(hour: int.parse(widget.hora.split(":")[0]) ,minute:int.parse(widget.hora.split(":")[1]) );
      hora = controlador.toString().substring(10, 15);
    }
  }

  void setHora(String hora){
    setState(() {
      controlador = TimeOfDay(hour: int.parse(widget.hora.split(":")[0]) ,minute:int.parse(widget.hora.split(":")[1]) );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(controlador.format(context), style: TextStyle(color: Colors.black)),
      onPressed: () async {
        var picker = await showTimePicker(
          context: context,
          initialTime: controlador,
        );
        if (picker != null && picker != controlador) {
          setState(() {
            controlador = picker;
          });
          hora = controlador.toString().substring(10, 15);
        }
      },
    );
  }
}
