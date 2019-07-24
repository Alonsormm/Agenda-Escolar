import 'package:agenda_escolar/components/boton_hora.dart';
import 'package:agenda_escolar/models/keys_dias_boton_hora.dart';
import 'package:flutter/material.dart';
import 'package:agenda_escolar/models/modulo.dart';

final keyDialog = GlobalKey<_DialogDiasState>(debugLabel: 'dialogDias');

class ModulosPart extends StatefulWidget {
  final List<Modulo> modulos;
  final bool mismaHora;
  ModulosPart({Key key, this.modulos, this.mismaHora}) : super(key: key);
  @override
  ModulosPartState createState() => ModulosPartState();
}

class ModulosPartState extends State<ModulosPart> {
  String _diasSelecciondos = "Seleccionar Dias";
  Map<String, bool> dias = {
    "Lunes": false,
    "Martes": false,
    "Miercoles": false,
    "Jueves": false,
    "Viernes": false,
    "Sabado": false,
    "Domingo": false
  };

  List<List<BotonHora>> listBotonHora = List<List<BotonHora>>();
  List<BotonHora> botonesGenerales = List<BotonHora>();
  bool mismaHora = true;
  KeysPorDiaDeBotones keysPorDiaDeBotones;

  bool comprobarDatos() {
    bool valor = false;
    List<bool> values = dias.values.toList();
    for (int i = 0; i < values.length; i++) {
      if (values[i]) valor = true;
    }

    if (!valor) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Asegurate de introducir los dias de clase"),
      ));
      return false;
    }

    if (mismaHora) {
      TimeOfDay inicio =
          keysPorDiaDeBotones.keysGenerales()[0].currentState.controlador;
      TimeOfDay fin =
          keysPorDiaDeBotones.keysGenerales()[1].currentState.controlador;
      double inicioDouble = inicio.hour + inicio.minute / 60;
      double finDouble = fin.hour + inicio.minute / 60;
      if (finDouble <= inicioDouble) {
        valor = false;
      }
    } else {
      List<int> diasActivosTemp = obtenerDiasActivosInt();
      for (int i = 0; i < diasActivosTemp.length; i++) {
        TimeOfDay inicio = keysPorDiaDeBotones
            .keysPorIndice(diasActivosTemp[i] - 1)[0]
            .currentState
            .controlador;
        TimeOfDay fin = keysPorDiaDeBotones
            .keysPorIndice(diasActivosTemp[i] - 1)[1]
            .currentState
            .controlador;
        double inicioDouble = inicio.hour + inicio.minute / 60;
        double finDouble = fin.hour + inicio.minute / 60;
        if (finDouble <= inicioDouble) {
          valor = false;
        }
      }
    }

    if (!valor) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Asegurate de introducir bien la hora"),
      ));
    }

    return valor;
  }

  initState() {
    super.initState();
    keysPorDiaDeBotones = KeysPorDiaDeBotones();
    if (widget.modulos != null) {
      List<Modulo> modulos = widget.modulos;
      mismaHora = widget.mismaHora;
      _completarDiasDeModulos(modulos);
      _modificarCadenaDeBoton();
      _crearBotonesHora(modulos);
    } else {
      botonesGenerales = [
        BotonHora(key: keysPorDiaDeBotones.keysGenerales()[0]),
        BotonHora(key: keysPorDiaDeBotones.keysGenerales()[1])
      ];
      for (int i = 0; i < 7; i++) {
        listBotonHora.add([
          BotonHora(key: keysPorDiaDeBotones.keysPorIndice(i)[0]),
          BotonHora(key: keysPorDiaDeBotones.keysPorIndice(i)[1]),
        ]);
      }
    }
  }

  void _completarDiasDeModulos(List<Modulo> modulos) {
    List<String> keysDias = dias.keys.toList();
    for (int i = 0; i < modulos.length; i++) {
      int id = modulos[i].idDia;
      setState(() {
        dias[keysDias[id - 1]] = true;
      });
    }
  }

  void _crearBotonesHora(List<Modulo> modulos) {
    List<int> ids = List<int>();
    for (int i = 0; i < modulos.length; i++) {
      print(modulos[i].idDia);
      ids.add(modulos[i].idDia);
    }
    print(modulos[0].horaDeInicio);
    botonesGenerales.add(BotonHora(
      key: keysPorDiaDeBotones.keysGenerales()[0],
      hora: modulos[0].horaDeInicio,
    ));
    botonesGenerales.add(BotonHora(
        key: keysPorDiaDeBotones.keysGenerales()[1],
        hora: modulos[0].horaDeFinal));
    int indiceModulos = 0;
    for (int i = 0; i < 7; i++) {
      if (ids.indexOf(i + 1) == -1) {
        listBotonHora.add([
          BotonHora(key: keysPorDiaDeBotones.keysTodosLosDias()[i][0]),
          BotonHora(key: keysPorDiaDeBotones.keysTodosLosDias()[i][1])
        ]);
      } else {
        listBotonHora.add([
          BotonHora(
              key: keysPorDiaDeBotones.keysTodosLosDias()[i][0],
              hora: modulos[indiceModulos].horaDeInicio),
          BotonHora(
              key: keysPorDiaDeBotones.keysTodosLosDias()[i][1],
              hora: modulos[indiceModulos].horaDeFinal)
        ]);
        indiceModulos++;
      }
    }
  }

  List<String> obtenerDiasActivos() {
    if (dias == null) {
      return [];
    }
    List<String> diasActivos = List<String>();
    List<String> keys = dias.keys.toList();
    for (int i = 0; i < keys.length; i++) {
      if (dias[keys[i]]) {
        diasActivos.add(keys[i]);
      }
    }
    return diasActivos;
  }

  void obtenerDias() {
    dias = keyDialog.currentState.obtenerDias();
  }

  bool _todasFalsas() {
    List<bool> values = dias.values.toList();
    if (values.indexOf(true) == -1) return true;
    return false;
  }

  _modificarCadenaDeBoton() {
    if (_todasFalsas()) {
      setState(() {
        _diasSelecciondos = "Seleccionar Dias";
      });
      return;
    }
    List<String> keys = dias.keys.toList();
    _diasSelecciondos = "";
    for (int i = 0; i < keys.length; i++) {
      if (dias[keys[i]]) {
        setState(() {
          _diasSelecciondos += keys[i] + " ";
        });
      }
    }
  }

  List<int> obtenerDiasActivosInt() {
    List<int> resultado = List<int>();
    List<bool> values = dias.values.toList();
    for (int i = 0; i < values.length; i++) {
      if (values[i]) {
        resultado.add(i + 1);
      }
    }
    return resultado;
  }

  Widget _listaHoras() {
    if (mismaHora) {
      return Card(
        color: Colors.lightBlueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 15)),
            Text("De "),
            botonesGenerales[0],
            //botonesGenerales[0],
            Text("a"),
            //botonesGenerales[1],
            botonesGenerales[1],
          ],
        ),
      );
    } else {
      return Wrap(
        children: _listaConfiguracionDias(),
      );
    }
  }

  List<Card> _listaConfiguracionDias() {
    List<Card> diasRow = List<Card>();
    List<String> diasActivos = obtenerDiasActivos();
    List<int> diasActivosInt = obtenerDiasActivosInt();
    for (int i = 0; i < diasActivos.length; i++) {
      Card temp = Card(
        color: Colors.lightBlueAccent,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(diasActivos[i] + " "),
              Padding(padding: EdgeInsets.only(right: 15)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Hora"),
                  listBotonHora[diasActivosInt[i] - 1][0],
                  Text("Hora"),
                  listBotonHora[diasActivosInt[i] - 1][1],
                ],
              )
            ],
          ),
        ),
      );
      diasRow.add(temp);
    }
    return diasRow;
  }

  Widget _horaListTile() {
    return CheckboxListTile(
      dense: true,
      controlAffinity: ListTileControlAffinity.platform,
      title: Text("¿Todas sus clases son a la misma hora?"),
      value: mismaHora,
      onChanged: (value) {
        setState(() {
          mismaHora = value;
        });
      },
    );
  }

  Widget _botonSeleccionarDias() {
    return FlatButton(
      color: Colors.amberAccent,
      child: Text(
        _diasSelecciondos,
        overflow: TextOverflow.clip,
        textAlign: TextAlign.center,
      ),
      onPressed: () async {
        await _elegirDiaDialog(dias);
        obtenerDias();
        _modificarCadenaDeBoton();
      },
    );
  }

  Future<void> _elegirDiaDialog(Map<String, bool> d) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        _DialogDias dialog = _DialogDias(
          key: keyDialog,
          dias: d,
        );
        return dialog;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          child: Column(
            children: <Widget>[
              _botonSeleccionarDias(),
              _horaListTile(),
              _listaHoras(),
            ],
          ),
        ),
      ],
    );
  }
}

class _DialogDias extends StatefulWidget {
  final Map<String, bool> dias;
  _DialogDias({Key key, this.dias}) : super(key: key);

  @override
  _DialogDiasState createState() => _DialogDiasState();
}

class _DialogDiasState extends State<_DialogDias> {
  Map<String, bool> dias;

  Map<String, bool> obtenerDias() {
    return dias;
  }

  initState() {
    super.initState();
    dias = widget.dias;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Seleccione los dias"),
      content: _listaDias(),
      actions: <Widget>[
        FlatButton(
          child: Text("Ok"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _listaDias() {
    return Wrap(
      children: dias.keys.map((String dia) {
        return CheckboxListTile(
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(dia),
          value: dias[dia],
          activeColor: Colors.black,
          onChanged: (bool value) {
            setState(() {
              dias[dia] = value;
            });
          },
        );
      }).toList(),
    );
  }
}
