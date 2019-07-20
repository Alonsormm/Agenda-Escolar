import 'package:agenda_escolar/models/materia.dart';
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
  void dispose(){
    bloc.dispose();
    super.dispose();
  }


  Widget botonMas(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: ()async{
              Materia temp = await Navigator.push(context, MaterialPageRoute(builder: (context) => AgregarMateria()));
              bloc.add(temp);
            },
          ),
        )
      ],
    );
  }

  void _eleminarMateria(Materia materia) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Seleccione la opcion deseada"),
          actions: <Widget>[
            FlatButton(
              child: new Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text("Modificar"),
              onPressed: () async{
                Navigator.of(context).pop();
                Materia temp = await Navigator.push(context, MaterialPageRoute(builder: (context) => AgregarMateria(temp: materia,)));
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
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 88,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: botonMas(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100),
          ),

          Expanded(
            child: StreamBuilder<List<Materia>>(
              stream: bloc.materias,
              builder: (BuildContext context,AsyncSnapshot<List<Materia>> snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index){
                        Materia item = snapshot.data[index];
                        return ListTile(
                          title: Text(item.nombre),
                          leading: CircleColor(color: Color(item.color),circleSize: 30,),
                          onLongPress: () {_eleminarMateria(item);},
                        );
                      },
                    );
                  }
                  else{
                    return Center(child: CircularProgressIndicator(),);
                  }
              },
            ),
          )
        
        ],
      ),
    );
  }
}
