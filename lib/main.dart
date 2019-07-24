import 'package:agenda_escolar/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agenda_escolar/screens/onboarding/onborarding.dart';
import 'package:flutter/material.dart';

main() async {
  runApp(MaterialApp(
    title: "Agenda Escolar",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences preferences;

  Onboarding onboarding =  Onboarding();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> getOnboardingState() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences.getBool("onboarding") == null) {
      preferences.setBool("onboarding", false);
      return false;
    }
    bool onBoarding = preferences.getBool("onboarding");
    return onBoarding;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getOnboardingState(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            return CircularProgressIndicator();
            break;
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            if (snapshot.hasData) {
              bool onBoarding = snapshot.data;
              if (onBoarding) {
                return HomePage();
              } else {
                return onboarding;
              }
            }
            break;
        }
      },
    );
  }
}
