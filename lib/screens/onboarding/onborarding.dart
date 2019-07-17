import 'package:agenda_escolar/screens/onboarding/screens/configuracionJornada.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List<Widget> paginas = [ConfiguracionJornada()];

    return Stack(
      children: <Widget>[
        PageView.builder(
          itemCount: paginas.length,
          itemBuilder: (context, index) {
            return paginas[index];
          },
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
                    "Agenda Escolar"
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
