import 'package:agenda_escolar/models/modulo.dart';
import 'package:flutter/material.dart';
import 'package:agenda_escolar/models/materia.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'dart:math';

class MateriaPart extends StatefulWidget {
  final Materia materia;

  MateriaPart({this.materia, Key key}): super(key:key);

  final MateriaPartState state = MateriaPartState();

  @override
  MateriaPartState createState() => state;
}

class MateriaPartState extends State<MateriaPart> {
  TextEditingController nombreMateria = TextEditingController();
  int id = -1;
  Color colorActual =
      Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
  bool mismaHora = false;

  List<Modulo> modulos;
  @override
  initState() {
    super.initState();
    if (widget.materia != null) {
      colorActual = Color(widget.materia.color);
      nombreMateria.text = widget.materia.nombre;
      mismaHora = widget.materia.mismaHora == 1 ? true : false;
      id = widget.materia.id;
    }
  }

  bool comprobarDatos() {
    if (nombreMateria.text != ""){
      nombreMateria.text = nombreMateria.text.trimRight();
      return true;
      }
    else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Agrega el nombre de la materia"),));
      return false;
    }
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

  Widget _rowNombreMateria() {
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

  Widget _rowColorMateria() {
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
          onTap: (){
            setState(() {
              colorActual = Colors.red;
            });
            _elegirColorDialog();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          _rowNombreMateria(),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          _rowColorMateria(),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
          ),
        ],
      ),
    );
  }
}
