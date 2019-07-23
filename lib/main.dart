
import 'package:agenda_escolar/screens/onboarding/onborarding.dart';
import 'package:flutter/material.dart';
main()async{
  
  runApp(MaterialApp(
      title: "Agenda Escolar",
      home: Home(),
    ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Onboarding(),
    );
  }
}