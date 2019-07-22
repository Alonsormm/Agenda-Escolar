import 'package:agenda_escolar/components/boton_hora.dart';
import 'package:agenda_escolar/screens/nuevos_elementos/agregar_localizacion.dart';
import 'package:agenda_escolar/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:agenda_escolar/models/modulo.dart';

final keyDialog = GlobalKey<_DialogDiasState>(debugLabel: 'dialogDias');

class AgregarModulosMateria extends StatefulWidget {
  final List<Modulo> modulos;

  AgregarModulosMateria({Key key, this.modulos}) : super(key: key);
  @override
  AgregarModulosMateriaState createState() => AgregarModulosMateriaState();
}

class AgregarModulosMateriaState extends State<AgregarModulosMateria> {
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

  List<List<BotonHora>> listBotonHora = List<List<BotonHora>>();

  final keyLocalizacion =
      GlobalKey<AgregarLocalizacionState>(debugLabel: " hola");

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
      crearBotonesHora(modulos);
    } else {
      listBotonHora = [
        [
          BotonHora(
            key: keys[0][0],
          ),
          BotonHora(
            key: keys[0][1],
          )
        ],
        [
          BotonHora(
            key: keys[1][0],
          ),
          BotonHora(
            key: keys[1][1],
          )
        ],
        [
          BotonHora(
            key: keys[2][0],
          ),
          BotonHora(
            key: keys[2][1],
          )
        ],
        [
          BotonHora(
            key: keys[3][0],
          ),
          BotonHora(
            key: keys[3][1],
          )
        ],
        [
          BotonHora(
            key: keys[4][0],
          ),
          BotonHora(
            key: keys[4][1],
          )
        ],
        [
          BotonHora(
            key: keys[5][0],
          ),
          BotonHora(
            key: keys[5][1],
          )
        ],
        [
          BotonHora(
            key: keys[6][0],
          ),
          BotonHora(
            key: keys[6][1],
          )
        ],
      ];
    }
  }

  obtenerValue() {
    return keyLocalizacion.currentState.obtenerValues();
  }

  void completarDias(List<Modulo> modulos) {
    List<String> keysDias = dias.keys.toList();
    for (int i = 0; i < modulos.length; i++) {
      int id = modulos[i].idDia;
      setState(() {
        dias[keysDias[id - 1]] = true;
      });
    }
  }

  guardarModulo(List<int> idLocalizaciones, int idMateria) async {
    List<bool> valuesActivos = dias.values.toList();
    List<int> idDiasActivos = List<int>();
    for (int i = 0; i < valuesActivos.length; i++) {
      if (valuesActivos[i]) {
        idDiasActivos.add(i + 1);
      }
    }
    if (mismaHora) {
      if (idLocalizaciones.length == 1) {

        for (int i = 0; i < idDiasActivos.length; i++) {
          Modulo moduloTemp = Modulo(
              idDia: idDiasActivos[i],
              idMateria: idMateria,
              idLocalizacion: idLocalizaciones[0],
              horaDeInicio: keyInicioGeneral.currentState.hora,
              horaDeFinal: keyFinalGeneral.currentState.hora);
          await DBProvider.db.nuevaModulo(moduloTemp);
        }
      } else {

        for (int i = 0; i < idDiasActivos.length; i++) {
          await DBProvider.db.nuevaModulo(Modulo(
              idDia: idDiasActivos[i],
              idMateria: idMateria,
              idLocalizacion: idLocalizaciones[i],
              horaDeInicio: keyInicioGeneral.currentState.hora,
              horaDeFinal: keyFinalGeneral.currentState.hora));
        }
      }
    } else {
      if (idLocalizaciones.length == 1) {

        for (int i = 0; i < idDiasActivos.length; i++) {
          await DBProvider.db.nuevaModulo(Modulo(
              idDia: idDiasActivos[i],
              idMateria: idMateria,
              idLocalizacion: idLocalizaciones[0],
              horaDeInicio: keys[i][0].currentState.hora,
              horaDeFinal: keys[i][1].currentState.hora));
        }
      } else {

        for (int i = 0; i < idDiasActivos.length; i++) {
          await DBProvider.db.nuevaModulo(Modulo(
              idDia: idDiasActivos[i],
              idMateria: idMateria,
              idLocalizacion: idLocalizaciones[i],
              horaDeInicio: keys[i][0].currentState.hora,
              horaDeFinal: keys[i][1].currentState.hora));
        }
      }
    }
  }

  void crearBotonesHora(List<Modulo> modulos) {
    List<int> ids = List<int>();
    for (int i = 0; i < modulos.length; i++) {
      ids.add(modulos[0].idDia);
    }
    for (int i = 0; i < 7; i++) {
      if (ids.indexOf(i + 1) == -1) {
        listBotonHora
            .add([BotonHora(key: keys[i][0]), BotonHora(key: keys[i][1])]);
      } else {
        listBotonHora.add([
          BotonHora(key: keys[i][0], hora: modulos[i].horaDeInicio),
          BotonHora(key: keys[i][1], hora: modulos[i].horaDeFinal)
        ]);
      }
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

  List<int> diasActivos() {
    List<int> resultado = List<int>();
    List<bool> values = dias.values;
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
                  listBotonHora[i][0],
                  Text("Hora"),
                  listBotonHora[i][1],
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
        keyLocalizacion.currentState.dias = dias;
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
              botonSeleccionarDias(),
              _horaListTile(),
              _listaHoras(),
            ],
          ),
        ),
        AgregarLocalizacion(
          key: keyLocalizacion,
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
