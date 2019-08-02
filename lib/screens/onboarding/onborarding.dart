import 'package:agenda_escolar/models/localizacion.dart';
import 'package:agenda_escolar/models/materia.dart';
import 'package:agenda_escolar/models/modulo.dart';
import 'package:agenda_escolar/screens/onboarding/screens/configuracion_jornada.dart';
import 'package:agenda_escolar/screens/onboarding/screens/configuracion_materias.dart';
import 'package:agenda_escolar/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding>
    with AutomaticKeepAliveClientMixin {
  List<Widget> paginas = List<Widget>();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  initState() {
    super.initState();
    paginas = [configuracionJornada, configuracionMaterias];
    AndroidInitializationSettings initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  PageController _controller = PageController(initialPage: 0, keepPage: false);

  int currentIndex = 0;

  ConfiguracionJornada configuracionJornada = ConfiguracionJornada();

  ConfiguracionMaterias configuracionMaterias = ConfiguracionMaterias();

  bool notificaciones = true;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _botonSiguiente() {
    if (currentIndex < paginas.length - 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            child: Text(
              "Siguiente",
              style: TextStyle(color: Colors.white),
            ),
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
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content:
                          Text("Asegurate de que las fechas sean correctas")));
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
            child: Text(
              "Guardar",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setBool("onboard", true);
              preferences.setBool("notificacionesDeClases", notificaciones);
              print("asdas");
              await agendarNotificaciones();
              Navigator.of(context).pushReplacementNamed('/home');
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
            child: Text(
              "Atras",
              style: TextStyle(color: Colors.white),
            ),
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

  @override
  bool get wantKeepAlive => true;

  Future<void> agendarNotificaciones() async {
    List<Modulo> modulos = await DBProvider.db.obtenerTodosLosModulos();
    await flutterLocalNotificationsPlugin.cancelAll();

    //await flutterLocalNotificationsPlugin.showDailyAtTime(0, "title"," body",Time(10,17,0),platformChannelSpecifics, payload: "Hola");
    //debugPrint("holass");
    for (int i = 0; i < modulos.length; i++) {
      var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
          'schedule agenda-escolar',
          'schedule Agenda Escolar',
          'schedule Agenda Escolar');
      var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
      NotificationDetails platformChannelSpecifics = new NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
      int idSalonTemp = modulos[i].idLocalizacion;
      int idMateria = modulos[i].idLocalizacion;
      String horaInicio = modulos[i].horaDeInicio;
      Materia nombreMateria = await DBProvider.db.obtenerMateria(idMateria);
      Localizacion nombreSalon =
          await DBProvider.db.obtenerLocalizacion(idSalonTemp);
      DateTime dateTimeHoraInicio =
          DateTime.parse("1969-07-20 $horaInicio:00Z");
      DateTime dateTimeNotificacion =
          dateTimeHoraInicio.add(Duration(minutes: -15));
      flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        i,
        "Tu clase ${nombreMateria.nombre} empeza en 15 minutos",
        "Salon: ${nombreSalon.salon}",
        Day(modulos[i].idDia+1),
        Time(dateTimeNotificacion.hour, dateTimeNotificacion.minute, 0),
        platformChannelSpecifics,
        payload: nombreMateria.nombre,
      );
      if(modulos[i].idDia == DateTime.now().weekday){
        print(horaInicio);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
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
                    child: Text(
                      "Agenda Escolar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CheckboxListTile(
                  onChanged: (value) {
                    setState(() {
                      notificaciones = value;
                    });
                  },
                  value: notificaciones,
                  activeColor: Colors.black,
                  title: Text("Notificaciones 15 min antes de cada clase: "),
                ),
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
