import 'package:agenda_escolar/models/localizacion.dart';
import 'package:agenda_escolar/models/materia.dart';
import 'package:agenda_escolar/models/modulo.dart';
import 'package:agenda_escolar/screens/materia/informacion_materia.dart';
import 'package:agenda_escolar/utils/database.dart';
import 'package:flutter/material.dart';

class MateriasDelDia extends StatefulWidget {

  final int dia;

  MateriasDelDia({@required this.dia});

  @override
  MateriasDelDiaState createState() => MateriasDelDiaState();
}

class MateriasDelDiaState extends State<MateriasDelDia> {
  List<Modulo> modulos;
  List<Materia> materias;
  List<Localizacion> salones;
  ScrollController scrollController = ScrollController();

  Future<bool> _obtenerMateriasDelDia() async {
    modulos = await _obtenerModulosDeHoy();
    materias = List<Materia>();
    for (int i = 0; i < modulos.length; i++) {
      materias.add(await DBProvider.db.obtenerMateria(modulos[i].idMateria));
    }
    modulos = _ordenarModulos(modulos);
    materias = _ordenarMateriasPorModulos(modulos, materias);
    salones = await _obtenerSalonesDeHoy(modulos);
    return true;
  }

  Future<List<Modulo>> _obtenerModulosDeHoy() async {
    //int idDia = DateTime.now().weekday;
    int idDia = widget.dia;
    List<Modulo> modulos =
        await DBProvider.db.obtenerTodosLosModulosPorDia(idDia);
    return modulos;
  }

  List<Materia> _ordenarMateriasPorModulos(
      List<Modulo> modulos, List<Materia> materiasTemp) {
    List<Materia> materiasOrdenadas = List<Materia>();
    for (int i = 0; i < modulos.length; i++) {
      for (int j = 0; j < materiasTemp.length; j++) {
        if (modulos[i].idMateria == materiasTemp[j].id) {
          materiasOrdenadas.add(materiasTemp[j]);
          break;
        }
      }
    }
    return materiasOrdenadas;
  }

  List<Modulo> _ordenarModulos(List<Modulo> modulos) {
    List<Modulo> modulosOrdenados = List<Modulo>();
    int tam = modulos.length;
    for (int i = 0; i < tam; i++) {
      String minimo = modulos[0].horaDeInicio;
      int indiceMin = 0;
      for (int i = 1; i < modulos.length; i++) {
        if (modulos[i].horaDeInicio.compareTo(minimo) < 0) {
          minimo = modulos[i].horaDeInicio;
          indiceMin = i;
        }
      }
      modulosOrdenados.add(modulos[indiceMin]);
      modulos.removeAt(indiceMin);
    }
    return modulosOrdenados;
  }

  Future<List<Localizacion>> _obtenerSalonesDeHoy(List<Modulo> modulos) async {
    List<Localizacion> localizaciones = List<Localizacion>();
    for (int i = 0; i < modulos.length; i++) {
      Localizacion temp =
          await DBProvider.db.obtenerLocalizacion(modulos[i].idLocalizacion);
      localizaciones.add(temp);
    }
    return localizaciones;
  }

  int moduloActual(List<Modulo> modulos) {
    double horaActual = TimeOfDay.now().hour.toDouble();
    double minutoActual = TimeOfDay.now().minute.toDouble();
    double horaActualCompleta = horaActual + minutoActual / 60;
    for (int i = 0; i < modulos.length; i++) {
      List<String> timeInicio = modulos[i].horaDeInicio.split(':');
      double horaInicio = double.parse(timeInicio[0]);
      double minutoInicio = double.parse(timeInicio[1]);
      double horaInicioCompleta = horaInicio + minutoInicio / 60;
      List<String> timeFinal = modulos[i].horaDeFinal.split(':');
      double horaFinal = double.parse(timeFinal[0]);
      double minutoFinal = double.parse(timeFinal[1]);
      double horaFinalCompleta = horaFinal + minutoFinal / 60;
      if (horaActualCompleta >= horaInicioCompleta &&
          horaActual < horaFinalCompleta) {
        return i;
      }
    }
    return 0;
  }


  Widget _cardMateriasDeHoy() {
    return ListView.builder(
      itemCount: materias.length,
      scrollDirection: Axis.horizontal,
      controller: scrollController,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return InformacionMateria(
                tagColor: "color" + index.toString() + "dia" + widget.dia.toString(),
                color: Color(materias[index].color),
                tagNombre: "nombre" + index.toString(),
                nombre: materias[index].nombre,
              );
            }));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Container(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Color(0xFF2A3A4D),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0),
                      child: Card(
                        color: Color(materias[index].color),
                        child: SizedBox(
                          width: 10,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            width: 220,
                            child: Text(
                              materias[index].nombre,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              modulos[index].horaDeInicio +
                                  "-" +
                                  modulos[index].horaDeFinal +
                                  " ",
                              style: TextStyle(color: Colors.white60),
                            ),
                            Text(
                              "Salon: " + salones[index].salon,
                              style: TextStyle(color: Colors.white60),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _obtenerMateriasDelDia(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Container();
            break;
          case ConnectionState.waiting:
            return Container();
            break;
          case ConnectionState.active:
            return Container();
            break;
          case ConnectionState.done:
            return Container(height: 125, child: _cardMateriasDeHoy());
            break;
        }
        return Container();
      },
    );
  }
}
