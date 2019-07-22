import 'package:agenda_escolar/components/boton_hora.dart';
import 'package:flutter/material.dart';
import 'package:agenda_escolar/utils/database_helper.dart';
import 'package:agenda_escolar/models/materia.dart';
import 'package:agenda_escolar/models/modulo.dart';
import 'package:agenda_escolar/utils/blocs/modulos_materia_bloc.dart';

final keyDialog = GlobalKey<_DialogDiasState>(debugLabel: 'dialogDias');

class AgregarModulosMateria extends StatefulWidget {
  final List<Modulo> modulos;

  AgregarModulosMateria({Key key, this.modulos}):super(key:key);
  @override
  _AgregarModulosMateriaState createState() => _AgregarModulosMateriaState();
}

class _AgregarModulosMateriaState extends State<AgregarModulosMateria> {
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
  final keyInicioGeneral = GlobalKey<BotonHoraState>(debugLabel: 'botonHora1');
  final keyFinalGeneral = GlobalKey<BotonHoraState>(debugLabel: 'botonHora2');
  final keyInicioLunes = GlobalKey<BotonHoraState>(debugLabel: 'botonHora3');
  final keyFinalLunes = GlobalKey<BotonHoraState>(debugLabel: 'botonHora4');
  final keyInicioMartes = GlobalKey<BotonHoraState>(debugLabel: 'botonHora5');
  final keyFinalMartes = GlobalKey<BotonHoraState>(debugLabel: 'botonHora6');
  final keyInicioMiercoles =
      GlobalKey<BotonHoraState>(debugLabel: 'botonHora7');
  final keyFinalMiercoles = GlobalKey<BotonHoraState>(debugLabel: 'botonHora8');
  final keyInicioJueves = GlobalKey<BotonHoraState>(debugLabel: 'botonHora9');
  final keyFinalJueves = GlobalKey<BotonHoraState>(debugLabel: 'botonHora10');
  final keyInicioViernes = GlobalKey<BotonHoraState>(debugLabel: 'botonHora11');
  final keyFinalViernes = GlobalKey<BotonHoraState>(debugLabel: 'botonHora12');
  final keyInicioSabado = GlobalKey<BotonHoraState>(debugLabel: 'botonHora13');
  final keyFinalSabado = GlobalKey<BotonHoraState>(debugLabel: 'botonHora14');
  final keyInicioDomingo = GlobalKey<BotonHoraState>(debugLabel: 'botonHora15');
  final keyFinalDomingo = GlobalKey<BotonHoraState>(debugLabel: 'botonHora16');

  List<List<GlobalKey<BotonHoraState>>> keys;

  initState() {
    super.initState();
    keys = [
      [keyInicioLunes, keyFinalLunes],
      [keyInicioMartes, keyFinalMartes],
      [keyInicioMiercoles, keyFinalMiercoles],
      [keyInicioJueves, keyFinalJueves],
      [keyInicioViernes, keyFinalViernes],
      [keyInicioSabado, keyFinalSabado],
      [keyInicioDomingo, keyFinalDomingo]
    ];
    if (widget.modulos != null) {
      List<Modulo> modulos = widget.modulos;
      completarDias(modulos);
      modificarCadena();
    }
  }

  void completarDias(List<Modulo> modulos) {
    List<String> keysDias = dias.keys.toList();
    for (int i = 0; i < modulos.length; i++) {
      int id = modulos[i].idDia;
      print(id);
      setState(() {
        dias[keysDias[id - 1]] = true;
        print(dias[keysDias[id - 1]]);
        //keys[i - i][0].currentState.hora = modulos[i].horaDeInicio;
        //keys[i - i][1].currentState.hora = modulos[i].horaDeInicio;
      });
    }
  }

  List<String> obtenerdiasActivos() {
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

  bool mismaHora = true;

  void obtenerDias() {
    dias = keyDialog.currentState.obtenerDias();
  }

  bool todasFalsas() {
    List<bool> values = dias.values.toList();
    if (values.indexOf(true) == -1) return true;
    return false;
  }

  modificarCadena() {
    if (todasFalsas()) {
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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          botonSeleccionarDias(),
          _horaListTile(),
          _listaHoras(),
        ],
      ),
    );
  }

  Widget _listaHoras() {
    if (mismaHora) {
      return Card(
        color: Colors.lightBlueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 15)),
            Text("Hora"),
            BotonHora(
              key: keyInicioGeneral,
            ),
            Text("Hora"),
            BotonHora(
              key: keyFinalGeneral,
            ),
          ],
        ),
      );
    } else {
      return Wrap(
        children: listaDias(),
      );
    }
  }

  List<Card> listaDias() {
    List<Card> diasRow = List<Card>();
    List<String> diasActivos = obtenerdiasActivos();
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
                  BotonHora(
                    key: keys[i][0],
                  ),
                  Text("Hora"),
                  BotonHora(
                    key: keys[i][1],
                  ),
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

  Widget botonSeleccionarDias() {
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
        modificarCadena();
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
