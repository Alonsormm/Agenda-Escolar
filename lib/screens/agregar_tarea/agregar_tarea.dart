import 'package:agenda_escolar/models/materia.dart';
import 'package:agenda_escolar/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:agenda_escolar/components/boton_calendario.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class AgregarTarea extends StatefulWidget {
  @override
  _AgregarTareaState createState() => _AgregarTareaState();
}

class _AgregarTareaState extends State<AgregarTarea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Agregar tarea",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: Color(0xFF1E2C3D),
      ),
      body: ListView(
        children: <Widget>[
          _InformacionTarea(),
          _InformacionEntrega(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {},
      ),
      backgroundColor: Color(0xFF1E2C3D),
    );
  }
}

class _InformacionTarea extends StatefulWidget {
  @override
  __InformacionTareaState createState() => __InformacionTareaState();
}

class __InformacionTareaState extends State<_InformacionTarea> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 10,
        color: Color(0xFF2A3A4D),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        "Titulo:",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Flexible(
                        child: TextField(
                      decoration: InputDecoration(),
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Tipo:",
                      style: TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                    ),
                    OutlineButton(
                      color: Color(0xFF1E2C3D),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: <Widget>[
                          Text("Tarea"),
                          Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Text(
                  "Descripcion:",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                height: 130,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Color(0xFF1E2C3D),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Escriba descripcion aqui",
                      ),
                      maxLines: null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InformacionEntrega extends StatefulWidget {
  @override
  __InformacionEntregaState createState() => __InformacionEntregaState();
}

class __InformacionEntregaState extends State<_InformacionEntrega> {
  MateriaPopUp materia;

  Widget botonMateria() {
    return FutureBuilder(
      future: DBProvider.db.obtenerTodasLasMaterias(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
            List<PopupMenuItem<MateriaPopUp>> listPopup = List<PopupMenuItem<MateriaPopUp>>();
            List<Materia> listMateria = snapshot.data;


            for (int i = 0; i < listMateria.length; i++) {
              MateriaPopUp materiaPopUp = MateriaPopUp(materia: listMateria[i],);

              if(i == 0){
                materia = materiaPopUp;
              }

              listPopup.add(PopupMenuItem(
                value: materiaPopUp,
                child: materiaPopUp,
              ));
            }

            return Expanded(
              child: Card(
                color: Color(0xFF1E2C3D),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: PopupMenuButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: materia,
                  ),
                  itemBuilder: (context) {
                    return listPopup;
                  },
                  onSelected: (row){
                    setState(() {
                     materia = row;
                    });
                  },
                ),
              ),
            );
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 10,
        color: Color(0xFF2A3A4D),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Materia: ",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                    ),
                    botonMateria(),
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class MateriaPopUp extends StatelessWidget {

  Materia materia;
  MateriaPopUp({@required this.materia});

  @override
  Widget build(BuildContext context) {
    return Row(
                  children: <Widget>[
                    CircleColor(
                      color: Color(materia.color),
                      circleSize: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                    ),
                    Container(
                        width: 200,
                        child: Text(
                          materia.nombre,
                          overflow: TextOverflow.clip,
                        )),
                  ],
                );
  }
}