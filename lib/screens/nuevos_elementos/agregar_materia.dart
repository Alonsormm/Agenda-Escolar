import 'package:flutter/material.dart';
import 'package:agenda_escolar/models/materia.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'dart:math';

class AgregarMateria extends StatefulWidget {
  final Materia temp;

  AgregarMateria({this.temp});

  final _AgregarMateriaState state = _AgregarMateriaState();

  @override
  _AgregarMateriaState createState() => state;
}

class _AgregarMateriaState extends State<AgregarMateria> {
  TextEditingController nombreMateria = TextEditingController();
  int id = -1;
  Color colorActual = Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
  @override
  initState(){
    super.initState();
    if(widget.temp != null){
      colorActual = Color(widget.temp.color);
      nombreMateria.text = widget.temp.nombre;
      id = widget.temp.id;
    }
  }

  bool comprobar(){
    if(nombreMateria.text != "")
      return true;
    else{
      nombreMateria.text = nombreMateria.text.trimRight();
      return false;
    }
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
                    Materia temp;
                    if(id != -1){
                      temp = Materia(id: id, nombre: nombreMateria.text, color: colorActual.value);
                    }
                    else{
                      temp = Materia(id: -1, nombre: nombreMateria.text, color: colorActual.value);
                    }
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

  Widget _botonCancelar() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              
              FlatButton(
                child: Text("Cancelar"),
                onPressed: (){ 
                  Navigator.pop(context,null);
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
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 100),
                ),
                rowNombreMateria(),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                rowColorMateria(),
              ],
            ),
            _botonGuardar(),
            _botonCancelar(),
          ],
        ),
      ),
    );
  }
}
