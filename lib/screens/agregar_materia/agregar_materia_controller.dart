import 'package:agenda_escolar/models/materia.dart';
import 'package:agenda_escolar/models/modulo.dart';
import 'package:agenda_escolar/screens/agregar_materia/pages/localizacion_page.dart';
import 'package:agenda_escolar/screens/agregar_materia/pages/materia_page_.dart';
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
  GlobalKey<MateriaPageState> localizacionPageKey =
      GlobalKey<MateriaPageState>(debugLabel: "localizacionPageKey");

  List<Widget> pages;

  @override
  initState() {
    pages = [
      MateriaPage(
        key: materiaPageKey,
      ),
    ];
    super.initState();
    pageController = PageController(initialPage: _currentPage, keepPage: false);
  }

  //Botones de navegacion

  void _siguiente() {
    if (materiaPageKey.currentState.comprobar()) {
      print("hola");
      pages.add(LocalizacionPage(
        key: localizacionPageKey,
        dias: materiaPageKey.currentState.dias,
      ));
      setState(() {
        _currentPage++;
      });
      pageController.animateToPage(_currentPage, curve: Curves.bounceIn, duration: Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentPage == 0) {
          return true;
        } else {
          setState(() {
            _currentPage--;
          });
          pageController.jumpToPage(_currentPage);          
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
          child: _currentPage == 0 ? Icon(Icons.arrow_forward) : Icon(Icons.check),
          onPressed: _siguiente,
        ),
      ),
    );
  }
}
