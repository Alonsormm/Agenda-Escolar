import 'package:agenda_escolar/models/materia.dart';
import 'package:agenda_escolar/models/modulo.dart';
import 'package:agenda_escolar/screens/home_screen/pages/home_page_one.dart';
import 'package:agenda_escolar/screens/home_screen/pages/home_page_two.dart';
import 'package:agenda_escolar/screens/agregar_tarea/agregar_tarea.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  List<Modulo> modulos;
  List<Materia> materias;
  Color backgroundClock = Color(0xFF00FFF7);
  Color backgroundCalendar = Color(0xFF1E2C3D);
  Color iconColorSelected = Colors.black;
  Color iconColorNotSelected = Colors.white;
  Color iconClock = Colors.black;
  Color iconCalendar = Colors.white;
  int pageIndex = 0;

  List<Widget> pages = [HomePageOne(), HomePageTwo()];
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  void pageChange(int index) async {
    if (index == 1) {
      setState(() {
        iconClock = iconColorNotSelected;
      });
      pageController.animateToPage(1,
          curve: Curves.decelerate, duration: Duration(milliseconds: 200));
      setState(() {
        pageIndex = 1;
        iconCalendar = iconColorSelected;
        backgroundCalendar = Color(0xFF00FFF7);
        backgroundClock = Color(0xFF1E2C3D);
      });
    }
    if (index == 0) {
      setState(() {
        iconCalendar = iconColorNotSelected;
      });
      pageController.animateToPage(0,
          curve: Curves.decelerate, duration: Duration(milliseconds: 200));
      setState(() {
        pageIndex = 0;
        iconClock = iconColorSelected;
        backgroundCalendar = Color(0xFF1E2C3D);
        backgroundClock = Color(0xFF00FFF7);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Agenda escolar",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: Color(0xFF1E2C3D),
      ),
      body: Container(
        child: PageView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: pages.length,
          itemBuilder: (BuildContext context, int index) {
            return pages[index];
          },
          controller: pageController,
          onPageChanged: pageChange,
          pageSnapping: true,
        ),
        color: Color(0xFF1E2C3D),
      ),
      drawer: Drawer(
        elevation: 16,
        child: Container(
          color: Color(0xFF2A3A4D),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return AgregarTarea();
          }));
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Color(0xFF00FFF7),
        elevation: 2,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Card(
          color: Color(0xFF12243B),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
              ),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                color: backgroundClock,
                child: IconButton(
                  onPressed: () => pageChange(0),
                  icon: Icon(
                    Icons.access_time,
                    color: iconClock,
                  ),
                  color: Colors.white,
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 15.0, right: 15.0)),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                color: backgroundCalendar,
                child: IconButton(
                  onPressed: () => pageChange(1),
                  icon: Icon(
                    Icons.calendar_today,
                    color: iconCalendar,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
              ),
            ],
          ),
        ),
        color: Color(0xFF1E2C3D),
      ),
    );
  }
}
