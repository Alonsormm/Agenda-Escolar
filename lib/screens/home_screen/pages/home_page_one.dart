import 'package:agenda_escolar/screens/home_screen/componentes/materias_del_dia.dart';
import 'package:flutter/material.dart';

class HomePageOne extends StatefulWidget {
  @override
  _HomePageOneState createState() => _HomePageOneState();
}

class _HomePageOneState extends State<HomePageOne> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 15),
          child: Text("Hoy:", style: TextStyle(fontSize: 20),),
        ),
        Container(
          child: MateriasDelDia(dia: DateTime.now().weekday,),
        ),
      ],
    );
  }
}
