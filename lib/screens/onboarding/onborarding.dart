import 'package:agenda_escolar/screens/onboarding/screens/configuracion_jornada.dart';
import 'package:agenda_escolar/screens/onboarding/screens/configuracion_materias.dart';
import 'package:agenda_escolar/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> with AutomaticKeepAliveClientMixin{
  List<Widget> paginas = List<Widget>();
  @override
  initState() {
    super.initState();
    paginas = [configuracionJornada, configuracionMaterias];
  }

  PageController _controller = PageController(initialPage: 0, keepPage: true);

  int currentIndex = 0;

  ConfiguracionJornada configuracionJornada = ConfiguracionJornada();

  ConfiguracionMaterias configuracionMaterias = ConfiguracionMaterias();

  Widget _botonSiguiente() {
    if (currentIndex < paginas.length - 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            child: Text("Siguiente"),
            onPressed: () async {
              if (_controller.page == 0) {
                await DBProvider.db.eliminarJornada(0);
                if (await configuracionJornada.guardarDatos()) {
                  _controller.animateToPage(1,
                      curve: Curves.easeInOutQuart,
                      duration: Duration(milliseconds: 200));
                  setState(() {
                    currentIndex = 1;
                  });
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Asegurate de que las fechas sean correctas"),
                  ));
                }
              }
            },
          )
        ],
      );
    } else if (currentIndex == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            child: Text("Guardar",),
            onPressed: () async {
              SharedPreferences preferences = await SharedPreferences.getInstance();
              await preferences.setBool("onboarding", true);
            },
          )
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _botonAtras() {
    if (currentIndex > 0)
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FlatButton(
            child: Text("Atras"),
            onPressed: () async {
              if (_controller.page == 1) {
                await configuracionJornada.eliminarDatos();
                _controller.animateToPage(0,
                    curve: Curves.easeInOutQuart,
                    duration: Duration(milliseconds: 200));
                setState(() {
                  currentIndex = 0;
                });
              }
            },
          )
        ],
      );
    else {
      return Container();
    }
  }

  @override bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            itemCount: paginas.length,
            itemBuilder: (context, index) {
              return paginas[index];
            },
            controller: _controller,
            physics: NeverScrollableScrollPhysics(),
          ),
          Container(
            width: double.infinity,
            height: 70,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text("Agenda Escolar"),
                  )
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    _botonSiguiente(),
                    _botonAtras(),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
