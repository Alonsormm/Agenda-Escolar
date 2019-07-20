import 'package:agenda_escolar/models/materia.dart';
import 'package:agenda_escolar/screens/nuevos_elementos/agregar_materia.dart';
import 'package:agenda_escolar/utils/blocs/materias_bloc.dart';
import 'package:agenda_escolar/utils/database_helper.dart';
import 'package:flutter/material.dart';

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
              //bloc.add(temp);
              bloc.delete(1);
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 80,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: botonMas(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100),
          ),

          Container(
            height: 100,
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
                          onLongPress: () => print(item.id),
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
