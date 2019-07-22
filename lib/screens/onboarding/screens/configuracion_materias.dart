import 'package:agenda_escolar/models/materia.dart';
import 'package:agenda_escolar/models/modulo.dart';
import 'package:agenda_escolar/screens/nuevos_elementos/agregar_materia.dart';
import 'package:agenda_escolar/utils/blocs/materias_bloc.dart';
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
            onPressed: (){},
          ),
        ],
      ),
      onTap: () async {
        Materia temp = await Navigator.push(
            context, MaterialPageRoute(builder: (context) => AgregarMateria()));
        if(temp == null){
          return;
        }
        bloc.add(temp);
      },
    );
  }

  void _eleminarMateria(Materia materia) {
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
                Navigator.of(context).pop();
                List<Modulo> pureba= [Modulo(id: 0, idDia: 1, horaDeInicio: "10:00", horaDeFinal: "11:30", idLocalizacion: 0, idMateria: materia.id), Modulo(id: 0, idDia: 2, horaDeInicio: "10:00", horaDeFinal: "11:30", idLocalizacion: 0, idMateria: materia.id)];
                Materia temp = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AgregarMateria(
                              temp: materia,
                              modulos: pureba,
                            )));
                if(temp == null){
                  return;
                }
                bloc.update(temp);
              },
            ),
            FlatButton(
              child: new Text("Eliminar"),
              onPressed: () {
                bloc.delete(materia.id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
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
          Padding(
            padding: EdgeInsets.only(top: 100),
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
                      return ListTile(
                        title: Text(item.nombre),
                        leading: CircleColor(
                          color: Color(item.color),
                          circleSize: 30,
                        ),
                        onLongPress: () {
                          _eleminarMateria(item);
                        },
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
