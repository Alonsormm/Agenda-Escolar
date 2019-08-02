import 'package:flutter/material.dart';
import 'package:agenda_escolar/components/boton_calendario.dart';

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
                    Text(
                      "Materia: ",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
