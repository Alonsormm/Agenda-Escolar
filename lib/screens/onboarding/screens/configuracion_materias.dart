import 'package:agenda_escolar/models/materia.dart';
import 'package:agenda_escolar/models/modulo.dart';
import 'package:agenda_escolar/screens/agregar_materia/agregar_materia_controller.dart';
import 'package:agenda_escolar/utils/blocs/materias_bloc.dart';
import 'package:agenda_escolar/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class ConfiguracionMaterias extends StatefulWidget {
  @override
  _ConfiguracionMateriasState createState() => _ConfiguracionMateriasState();
}

class _ConfiguracionMateriasState extends State<ConfiguracionMaterias> {
  List<Materia> materias = List<Materia>();

  final bloc = MateriasBloc();
  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  Widget botonMas() {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          Text("Nueva materia"),
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
            ),
            onPressed: null,
          ),
        ],
      ),
      onTap: () async {
        Materia temp = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AgregarMateriaController()));
        if (temp == null) {
          return;
        }
        bloc.add(temp);
      },
    );
  }

  void _modificarMateria(Materia materia) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Selecciona la opcion deseada"),
          actions: <Widget>[
            FlatButton(
              child: new Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text("Modificar"),
              onPressed: () async {
                List<Modulo> listModulos = await DBProvider.db
                    .obtenerTodosLosModulosPorMateria(materia.id);
                Navigator.of(context).pop();
                Materia temp = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AgregarMateriaController(materia: materia, listModulo: listModulos,)));
                if (temp == null) {
                  return;
                }
                bloc.update(temp);
              },
            ),
            FlatButton(
              child: new Text("Eliminar"),
              onPressed: () async {
                bloc.delete(materia.id);
                await DBProvider.db.eliminarModulosPorMateria(materia);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget modulosTexto(List<Modulo> listModulo) {
    List<String> semana = [
      "Lunes",
      "Martes",
      "Miercoles",
      "Jueves",
      "Viernes",
      "Sabado",
      "Domingo"
    ];
    String cadena = "";
    for (int i = 0; i < listModulo.length; i++) {
      cadena += semana[listModulo[i].idDia - 1] +
          ": " +
          listModulo[i].horaDeInicio +
          "-" +
          listModulo[i].horaDeFinal +
          " ";
    }
    return Text(cadena);
  }

  Widget modulosSubtitle(Materia item) {
    return FutureBuilder(
      future: DBProvider.db.obtenerTodosLosModulosPorMateria(item.id),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return CircularProgressIndicator();
            break;
          case ConnectionState.waiting:
            return CircularProgressIndicator();
            break;
          case ConnectionState.active:
            return CircularProgressIndicator();
            break;
          case ConnectionState.done:
            return modulosTexto(snapshot.data);
            break;
          default:
            return Container();
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 70),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              botonMas(),
              Padding(
                padding: EdgeInsets.only(right: 25),
              )
            ],
          ),
          Expanded(
            child: StreamBuilder<List<Materia>>(
              stream: bloc.materias,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Materia>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Materia item = snapshot.data[index];
                      return Card(
                        child: ListTile(
                          title: Text(item.nombre),
                          subtitle: modulosSubtitle(item),
                          leading: CircleColor(
                            color: Color(item.color),
                            circleSize: 30,
                          ),
                          onLongPress: () {
                            _modificarMateria(item);
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
