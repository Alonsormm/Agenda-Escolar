import 'package:agenda_escolar/models/materia.dart';
import 'package:agenda_escolar/models/modulo.dart';
import 'package:agenda_escolar/screens/home_screen/componentes/materias_del_dia.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Modulo> modulos;
  List<Materia> materias;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Agenda escolar",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: Color(0xFF1E2C3D),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              child: MateriasDelDia(),
            ),
          ],
        ),
        color: Color(0xFF1E2C3D),
      ),
      drawer: Drawer(
        elevation: 16,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Color(0xFF00FFF7),
        elevation: 2,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.access_time,
              color: Colors.white,
            ),
            Icon(
              Icons.calendar_today,
              color: Colors.white,
            ),
          ],
        ),
        color: Color(0xFF1E2C3D),
      ),
    );
  }
}
