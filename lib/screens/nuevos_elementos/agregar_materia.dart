import 'package:agenda_escolar/models/modulo.dart';
import 'package:agenda_escolar/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:agenda_escolar/models/materia.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'agregar_modulos_materia.dart';
import 'dart:math';

class AgregarMateria extends StatefulWidget {
  final Materia materia;
  final List<Modulo> modulos;


  AgregarMateria({this.materia, this.modulos});

  final AgregarMateriaState state = AgregarMateriaState();

  @override
  AgregarMateriaState createState() => state;
}

class AgregarMateriaState extends State<AgregarMateria> {
  TextEditingController nombreMateria = TextEditingController();
  int id = -1;
  Color colorActual =
      Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
  final GlobalKey<AgregarModulosMateriaState> keyModulos = GlobalKey<AgregarModulosMateriaState>(debugLabel: 'modulosMateria');
  bool mismaHora = false;

  List<Modulo> modulos;
  @override
  initState() {
    super.initState();
    if (widget.materia != null) {
      colorActual = Color(widget.materia.color);
      nombreMateria.text = widget.materia.nombre;
      mismaHora = widget.materia.mismaHora == 1 ? true: false;
      id = widget.materia.id;
      modulos = widget.modulos;
    }
  }

  bool comprobar() {
    if (nombreMateria.text != "")
      return true;
    else {
      nombreMateria.text = nombreMateria.text.trimRight();
      return false;
    }
  }

  Widget _botonGuardar() {
    return FlatButton(
      child: Text("Guardar"),
      onPressed: () async {
        if (comprobar()) {
          Materia tempMateria;
          int mismaHora = keyModulos.currentState.mismaHora ? 1 : 0;
          int mismoSalon = keyModulos.currentState.keyLocalizacion.currentState.mismoSalon ? 1 : 0;
          print(mismoSalon);
          if (id != -1) {
            tempMateria = Materia(
                id: id, nombre: nombreMateria.text, color: colorActual.value, mismaHora: mismaHora,mismoSalon: mismoSalon);
          } else {
            List<int> idLugares = keyModulos.currentState.obtenerValue();
            int idMateria = await DBProvider.db.obtenerIdMaxMateria();
            keyModulos.currentState.guardarModulo(idLugares, idMateria);
            tempMateria = Materia(
                id: id, nombre: nombreMateria.text, color: colorActual.value, mismaHora: mismaHora,mismoSalon: mismoSalon);
          }
          Navigator.pop(context, tempMateria);
        }
      },
    );
  }

  Widget _botonCancelar() {
    return FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.pop(context, null);
      },
    );
  }

  void _elegirColorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Elije el color de tu preferencia"),
          content: MaterialColorPicker(
            onColorChange: (Color color) {
              setState(() {
                colorActual = color;
              });
            },
            selectedColor: colorActual,
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget rowNombreMateria() {
    return Row(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(
          left: 15,
        )),
        Text("Nombre de la materia: "),
        Padding(
            padding: EdgeInsets.only(
          left: 10,
        )),
        Expanded(
          child: TextField(
            textCapitalization: TextCapitalization.sentences,
            controller: nombreMateria,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Nombre de la materia",
            ),
          ),
        )
      ],
    );
  }

  Widget rowColorMateria() {
    return Row(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(
          left: 15,
        )),
        Text("Color de la materia: "),
        Padding(
            padding: EdgeInsets.only(
          left: 30,
        )),
        InkWell(
          child: CircleColor(
            color: colorActual,
            circleSize: 50,
          ),
          onTap: () {
            _elegirColorDialog();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    rowNombreMateria(),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    rowColorMateria(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                    ),
                  ],
                ),
              ),
              AgregarModulosMateria(key: keyModulos,modulos: modulos,mismaHora: mismaHora,),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _botonCancelar(),
                    _botonGuardar(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
