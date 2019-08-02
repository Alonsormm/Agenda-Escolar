import 'package:agenda_escolar/screens/home_screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agenda_escolar/screens/onboarding/onborarding.dart';
import 'package:flutter/material.dart';

main() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool respuesta = preferences.getBool("onboard");
  Widget _defaultHome = Onboarding();
  if (respuesta != null) {
    _defaultHome = HomePage();
  }
  runApp(MaterialApp(
    title: "Agenda Escolar",
    home: _defaultHome,
    theme: ThemeData.dark(),
    routes: <String, WidgetBuilder>{
      '/onboarding': (_) => new Onboarding(), // Login Page
      '/home': (_) => new HomePage(), // Home Page
    },
  ));
}
