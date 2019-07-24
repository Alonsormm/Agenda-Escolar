import 'package:agenda_escolar/models/materia.dart';
import 'package:agenda_escolar/models/modulo.dart';
import 'package:agenda_escolar/screens/agregar_materia/pages/localizacion_page.dart';
import 'package:agenda_escolar/screens/agregar_materia/pages/materia_page_.dart';
import 'package:agenda_escolar/utils/database.dart';
import 'package:flutter/material.dart';

class AgregarMateriaController extends StatefulWidget {
  final Materia materia;
  final List<Modulo> listModulo;

  AgregarMateriaController({this.materia, this.listModulo});

  @override
  _AgregarMateriaControllerState createState() =>
      _AgregarMateriaControllerState();
}

class _AgregarMateriaControllerState extends State<AgregarMateriaController> {
  int _currentPage = 0;
  PageController pageController;

  GlobalKey<MateriaPageState> materiaPageKey =
      GlobalKey<MateriaPageState>(debugLabel: "materiaPageKey");
  GlobalKey<LocalizacionPageState> localizacionPageKey =
      GlobalKey<LocalizacionPageState>(debugLabel: "localizacionPageKey");

  List<Widget> pages;

  @override
  initState() {
    pages = [
      MateriaPage(
        key: materiaPageKey,
        editarMateria: widget.materia,
        listModulos: widget.listModulo,
      ),
    ];
    super.initState();
    pageController = PageController(initialPage: _currentPage, keepPage: true);
  }

  Future<Materia> guardarDatos() async {
    List<List<String>> listaHoras = materiaPageKey.currentState.horas();
    List<int> listIdLocalizaciones =
        localizacionPageKey.currentState.listIdLocalizaciones();
    List<int> listDiasActivos =
        materiaPageKey.currentState.obtenerDiasActivos();
    if (listIdLocalizaciones.length == 1) {
      for (int i = 1; i < listDiasActivos.length; i++) {
        listIdLocalizaciones.add(listIdLocalizaciones[0]);
      }
    }

    String nombreMateria = materiaPageKey.currentState.nombreMateria();
    int colorMateria = materiaPageKey.currentState.colorMateria();
    int mismaHora = materiaPageKey.currentState.mismaHora() ? 1 : 0;
    int mismoSalon = localizacionPageKey.currentState.mismoSalon() ? 1 : 0;
    int id;
    if (widget.materia == null) {
      id = await DBProvider.db.obtenerIdMaxMateria();
    } else {
      id = widget.materia.id;
    }
    Materia nuevaMateria = Materia(
        id: id,
        color: colorMateria,
        mismaHora: mismaHora,
        mismoSalon: mismoSalon,
        nombre: nombreMateria);

    if (widget.materia != null) {
      await DBProvider.db.eliminarModulosPorMateria(nuevaMateria);
    }

    for (int i = 0; i < listDiasActivos.length; i++) {
      Modulo nuevoModuloTemp = Modulo(
          idDia: listDiasActivos[i],
          idLocalizacion: listIdLocalizaciones[i],
          idMateria: id,
          horaDeInicio: listaHoras[i][0],
          horaDeFinal: listaHoras[i][1]);
      await DBProvider.db.nuevaModulo(nuevoModuloTemp);
    }
    return nuevaMateria;
  }

  //Boton de navegacion
  void _siguiente() async {
    if (_currentPage == 1) {
      if (await localizacionPageKey.currentState.comprobar()) {
        Materia nuevaMateria = await guardarDatos();
        Navigator.of(context).pop(nuevaMateria);
      }
    } else {
      if (materiaPageKey.currentState.comprobar()) {
        List<int> listIdLocalizaciones = List<int>();
        bool salonNoNull = false;
        bool mismoSalon = false;
        if (widget.materia != null) {
          List<Modulo> listModulos = widget.listModulo;
          for (int i = 0; i < listModulos.length; i++) {
            listIdLocalizaciones.add(listModulos[i].idLocalizacion);
          }
          mismoSalon = widget.materia.mismoSalon == 1 ? true : false;
          salonNoNull = true;
        }
        materiaPageKey.currentState.conseguirDias();
        pages.add(LocalizacionPage(
          key: localizacionPageKey,
          dias: materiaPageKey.currentState.dias,
          mismoSalon: salonNoNull ? mismoSalon : null,
          listIdLocalizaciones:
              listIdLocalizaciones.length != 0 ? listIdLocalizaciones : null,
        ));
        setState(() {
          _currentPage++;
        });
        await pageController.animateToPage(_currentPage,
            curve: Curves.easeInOutQuart,
            duration: Duration(milliseconds: 400));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentPage == 0) {
          return true;
        } else {
          await pageController.animateToPage(_currentPage,
              curve: Curves.easeInOutQuart,
              duration: Duration(milliseconds: 400));
          setState(() {
            _currentPage--;
          });
          pages.removeLast();
          return false;
        }
      },
      child: Scaffold(
        body: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: pages.length,
          itemBuilder: (BuildContext context, int index) {
            return pages[index];
          },
          controller: pageController,
        ),
        floatingActionButton: FloatingActionButton(
          child:
              _currentPage == 0 ? Icon(Icons.arrow_forward) : Icon(Icons.check),
          onPressed: _siguiente,
        ),
      ),
    );
  }
}
