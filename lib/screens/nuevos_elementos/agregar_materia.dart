import 'package:flutter/material.dart';
import 'package:agenda_escolar/models/materia.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class AgregarMateria extends StatefulWidget {
  final Materia temp;

  AgregarMateria({this.temp});

  final _AgregarMateriaState state = _AgregarMateriaState();

  @override
  _AgregarMateriaState createState() => state;
}

class _AgregarMateriaState extends State<AgregarMateria> {
  TextEditingController nombreMateria = TextEditingController();

  Color colorActual = Colors.red;

  bool comprobar(){
    if(nombreMateria.text != "")
      return true;
    return false;
  }

  Widget _botonGuardar() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              
              FlatButton(
                child: Text("Guardar"),
                onPressed: (){
                  if(comprobar()){
                    Materia temp = Materia(id: 0, nombre: nombreMateria.text, color: colorActual.value);
                    Navigator.pop(context,temp);
                  }
                },
              )
            ],
          )
        ],
      ),
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
      appBar: AppBar(
        title: Text("Materia"),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                rowNombreMateria(),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                rowColorMateria(),
              ],
            ),
            _botonGuardar(),
          ],
        ),
      ),
    );
  }
}
