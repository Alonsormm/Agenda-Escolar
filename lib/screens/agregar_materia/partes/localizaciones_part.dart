import 'package:agenda_escolar/components/lista_salones.dart';
import 'package:agenda_escolar/utils/blocs/localizacion_bloc.dart';
import 'package:flutter/material.dart';

class LocalizacionPart extends StatefulWidget {
  final Map<String, bool> dias;
  final bool mismoSalon;
  final List<int> listIdLocalizaciones;
  LocalizacionPart(
      {Key key, this.dias, this.mismoSalon, this.listIdLocalizaciones})
      : super(key: key);

  @override
  LocalizacionPartState createState() => LocalizacionPartState();
}

class LocalizacionPartState extends State<LocalizacionPart> {
  final bloc = LocalizacionesBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  bool mismoSalon = true;
  GlobalKey<ListaSalonesState> keyListaSalones;
  Map<String, bool> dias;

  List<int> diasActivos;

  final keyListaSalonesLunes =
      GlobalKey<ListaSalonesState>(debugLabel: "listaSalonesLunes");
  final keyListaSalonesMartes =
      GlobalKey<ListaSalonesState>(debugLabel: "listaSalonesMartes");
  final keyListaSalonesMiercoles =
      GlobalKey<ListaSalonesState>(debugLabel: "listaSalonesMiercoles");
  final keyListaSalonesJueves =
      GlobalKey<ListaSalonesState>(debugLabel: "listaSalonesJueves");
  final keyListaSalonesViernes =
      GlobalKey<ListaSalonesState>(debugLabel: "listaSalonesViernes");
  final keyListaSalonesSabado =
      GlobalKey<ListaSalonesState>(debugLabel: "listaSalonesSabado");
  final keyListaSalonesDomingo =
      GlobalKey<ListaSalonesState>(debugLabel: "listaSalonesDoming");

  List<GlobalKey<ListaSalonesState>> keysListaSalonesDias =
      List<GlobalKey<ListaSalonesState>>();

  List<ListaSalones> listSalonesDias = List<ListaSalones>();
  ListaSalones listaSalonesGeneral;

  initState() {
    super.initState();
    keysListaSalonesDias = [
      keyListaSalonesLunes,
      keyListaSalonesMartes,
      keyListaSalonesMiercoles,
      keyListaSalonesJueves,
      keyListaSalonesViernes,
      keyListaSalonesSabado,
      keyListaSalonesDomingo
    ];

    listSalonesDias = [
      ListaSalones(
        key: keyListaSalonesLunes,
        multiple: true,
      ),
      ListaSalones(
        key: keyListaSalonesMartes,
        multiple: true,
      ),
      ListaSalones(
        key: keyListaSalonesMiercoles,
        multiple: true,
      ),
      ListaSalones(
        key: keyListaSalonesJueves,
        multiple: true,
      ),
      ListaSalones(
        key: keyListaSalonesViernes,
        multiple: true,
      ),
      ListaSalones(
        key: keyListaSalonesSabado,
        multiple: true,
      ),
      ListaSalones(
        key: keyListaSalonesDomingo,
        multiple: true,
      ),
    ];

    keyListaSalones = GlobalKey<ListaSalonesState>(debugLabel: "listaSalones");

    listaSalonesGeneral = ListaSalones(
      key: keyListaSalones,
      multiple: false,
    );

    if (widget.dias != null) {
      dias = widget.dias;
    }
    if(widget.mismoSalon != null){
      mismoSalon = widget.mismoSalon;
    }
  }

  obtenerValues() {
    if (mismoSalon) {
      return [keyListaSalones.currentState.radioValue + 1];
    }
    List<bool> values = dias.values.toList();
    List<int> diasActivos = List<int>();
    for (int i = 0; i < values.length; i++) {
      if (values[i]) {
        diasActivos.add(i);
      }
    }
    List<int> idLugares = List<int>();
    for (int i = 0; i < diasActivos.length; i++) {
      idLugares.add(
          keysListaSalonesDias[diasActivos[i]].currentState.radioValue + 1);
    }
    return idLugares;
  }

  Widget _mismoSalonTile() {
    return CheckboxListTile(
      dense: true,
      controlAffinity: ListTileControlAffinity.platform,
      title: Text("¿Todas sus clases son en el mismo salón?"),
      value: mismoSalon,
      onChanged: (value) {
        setState(() {
          mismoSalon = value;
        });
      },
    );
  }

  ListView diasSalon() {
    return ListView(
      shrinkWrap: true,
      children: rowPorDia(),
      physics: NeverScrollableScrollPhysics(),
    );
  }

  List<Card> rowPorDia() {
    if (dias == null) {
      return [];
    }
    List<String> keys = dias.keys.toList();
    List<bool> values = dias.values.toList();
    List<Card> resultado = List<Card>();
    for (int i = 0; i < values.length; i++) {
      if (values[i]) {
        Column temporal = Column(children: <Widget>[
          Text(
            keys[i],
            style: (TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          ListaSalones(
            key: keysListaSalonesDias[i],
            multiple: true,
          ),
        ]);
        resultado.add(Card(
          child: temporal,
        ));
      }
    }
    return resultado;
  }

  void _modificarSalones(BuildContext context) {
    if (widget.mismoSalon != null) {
      if (mismoSalon) {
        keyListaSalones.currentState.radioValue =
            widget.listIdLocalizaciones[0] - 1;
      } else {
        List<int> resultado = List<int>();
        List<bool> values = dias.values.toList();
        for (int i = 0; i < values.length; i++) {
          if (values[i]) {
            resultado.add(i);
          }
        }
        for (int i = 0; i < resultado.length; i++) {
          keysListaSalonesDias[resultado[i]].currentState.radioValue = widget.listIdLocalizaciones[i]-1;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _modificarSalones(context));
    return Card(
      child: Column(
        children: <Widget>[
          Text("Elegir salón"),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          mismoSalon ? listaSalonesGeneral : diasSalon(),
          _mismoSalonTile(),
        ],
      ),
    );
  }
}
