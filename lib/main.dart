
import 'package:agenda_escolar/screens/onboarding/onborarding.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
main()async{
  Directory documentsDirectory = await getApplicationDocumentsDirectory();  
  documentsDirectory.delete(recursive: true);
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