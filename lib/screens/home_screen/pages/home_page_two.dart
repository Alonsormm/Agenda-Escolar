import 'package:agenda_escolar/models/modulo.dart';
import 'package:agenda_escolar/screens/home_screen/componentes/calendario.dart';
import 'package:agenda_escolar/screens/home_screen/componentes/materias_del_dia.dart';
import 'package:agenda_escolar/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePageTwo extends StatefulWidget {
  @override
  _HomePageTwoState createState() => _HomePageTwoState();
}

class _HomePageTwoState extends State<HomePageTwo>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<Widget> materiasDeDias = List<Widget>();

  Future<List<bool>> modulosDelDia() async {
    List<bool> modulos = List<bool>();
    for (int i = 1; i < 8; i++) {
      List<Modulo> temp = await DBProvider.db.obtenerTodosLosModulosPorDia(i);
      if(temp.isNotEmpty && i != DateTime.now().weekday){
        modulos.add(true);
      }
      else{
        modulos.add(false);
      }
    }
    return modulos;
  }

  Column cardsDelDia(int dia) {
    Map<int, String> mapDias = {
      1: "Lunes",
      2: "Martes",
      3: "Miercoles",
      4: "Jueves",
      5: "Viernes",
      6: "Sabado",
      7: "Domingo",
    };

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 20),
          child: Text(
            mapDias[dia],
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          child: MateriasDelDia(dia: dia),
        ),
      ],
    );
  }

  void generarLista(List<bool> modulos){
    materiasDeDias.clear();
    materiasDeDias.add(Calendario());
    for(int i = 0; i < modulos.length; i++){
      if(modulos[i]){
        materiasDeDias.add(cardsDelDia(i+1));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: modulosDelDia(),
      builder:
          (BuildContext context, AsyncSnapshot<List<bool>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Container();
            break;
          case ConnectionState.waiting:
            return Container();
            break;
          case ConnectionState.active:
            return Container();
            break;
          case ConnectionState.done:
            generarLista(snapshot.data);
            return ListView.builder(
              itemCount: materiasDeDias.length,
              itemBuilder: (context,index){
                return materiasDeDias[index];
              },
            );
            break;
          default:
            return Container();
            break;
        }
      },
    );
  }
}
