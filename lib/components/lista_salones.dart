import 'package:agenda_escolar/models/localizacion.dart';
import 'package:agenda_escolar/utils/blocs/localizacion_bloc.dart';
import 'package:agenda_escolar/utils/database.dart';
import 'package:flutter/material.dart';

class ListaSalones extends StatefulWidget {
  final bool multiple;
  ListaSalones({Key key,this.multiple}) : super(key: key);
  @override
  ListaSalonesState createState() => ListaSalonesState();
}

class ListaSalonesState extends State<ListaSalones> {
  LocalizacionesBloc bloc = LocalizacionesBloc();
  int radioValue = 0;
  int ultimo = -1;

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  final keyDialog =
      GlobalKey<_DialogLocalizacionState>(debugLabel: "dialogLocalizacion2");

  @override
  void initState() {
    super.initState();
  }

  Future<void> _showDialogNuevaLocalizacion() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogLocalizacion(
            key: keyDialog,
          );
        });
    if (keyDialog.currentState.hecho ||
        keyDialog.currentState.salon.text != "") {
      Localizacion temp =
          Localizacion(salon: keyDialog.currentState.salon.text);
      bloc.add(temp);
      setState(() {
        radioValue = ultimo + 1;
      });
    }
  }

  Future<void> _showDialogEditarLocalizacion(Localizacion localizacion) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogLocalizacion(
            key: keyDialog,
            localizacion: localizacion,
          );
        });
    if (keyDialog.currentState.hecho &&
        keyDialog.currentState.salon.text != "") {
      Localizacion temp = Localizacion(
          id: localizacion.id, salon: keyDialog.currentState.salon.text);
      bloc.update(temp);
    }
    if (keyDialog.currentState.eliminar) {
      bloc.delete(localizacion.id);
      List<Localizacion> listTemp =
          await DBProvider.db.obtenerTodasLasLocalizaciones();
      if (listTemp.isEmpty) {
        ultimo = -1;
        radioValue = -1;
      }else{
        radioValue = radioValue-1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          StreamBuilder<List<Localizacion>>(
            stream: bloc.localizacion,
            builder: (BuildContext context,
                AsyncSnapshot<List<Localizacion>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Localizacion temp = snapshot.data[index];
                    ultimo = index;
                    return Card(
                      child: ListTile(
                        title: Text(temp.salon),
                        leading: Radio(
                          value: index,
                          groupValue: radioValue,
                          onChanged: (int value) async {
                            setState(() {
                              radioValue = value;
                            });
                          },
                        ),
                        onLongPress: () async {
                          await _showDialogEditarLocalizacion(temp);
                        },
                        onTap: () {
                          setState(() {
                            radioValue = index;
                          });
                        },
                      ),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text("Agregar Salón"),
                onPressed: () async {
                  await _showDialogNuevaLocalizacion();
                },
                color: Colors.amberAccent,
              ),
              widget.multiple ?  IconButton(
                icon: Icon(Icons.cached),
                onPressed: () async {
                  await bloc.delete(10000);
                },
              ) : Container(),
            ],
          ),
        ],
      ),
    );
  }
}

class DialogLocalizacion extends StatefulWidget {
  final Localizacion localizacion;

  DialogLocalizacion({Key key, this.localizacion}) : super(key: key);

  @override
  _DialogLocalizacionState createState() => _DialogLocalizacionState();
}

class _DialogLocalizacionState extends State<DialogLocalizacion> {
  TextEditingController salon = TextEditingController();
  bool modificar = false;
  bool hecho = false;
  bool eliminar = false;

  @override
  void initState() {
    super.initState();
    if (widget.localizacion != null) {
      modificar = true;
      salon.text = widget.localizacion.salon;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: <Widget>[
          Text("Salon: "),
          Padding(
            padding: EdgeInsets.only(right: 10),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Escriba aqui el salón", border: InputBorder.none),
              controller: salon,
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancelar"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        modificar
            ? FlatButton(
                child: Text("Eliminar"),
                onPressed: () {
                  eliminar = true;
                  Navigator.of(context).pop();
                },
              )
            : Container(),
        FlatButton(
          child: Text("Aceptar"),
          onPressed: () {
            setState(() {
              hecho = true;
            });
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
