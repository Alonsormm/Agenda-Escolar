import 'package:agenda_escolar/components/boton_hora.dart';
import 'package:flutter/material.dart';
class KeysPorDiaDeBotones{
  GlobalKey<BotonHoraState> _keyInicioGeneral; 
  GlobalKey<BotonHoraState> _keyFinalGeneral;
  GlobalKey<BotonHoraState> _keyInicioLunes;
  GlobalKey<BotonHoraState> _keyFinalLunes;
  GlobalKey<BotonHoraState> _keyInicioMartes;
  GlobalKey<BotonHoraState> _keyFinalMartes;
  GlobalKey<BotonHoraState> _keyInicioMiercoles;
  GlobalKey<BotonHoraState> _keyFinalMiercoles;
  GlobalKey<BotonHoraState> _keyInicioJueves;
  GlobalKey<BotonHoraState> _keyFinalJueves;
  GlobalKey<BotonHoraState> _keyInicioViernes;
  GlobalKey<BotonHoraState> _keyFinalViernes;
  GlobalKey<BotonHoraState> _keyInicioSabado;
  GlobalKey<BotonHoraState> _keyFinalSabado;
  GlobalKey<BotonHoraState> _keyInicioDomingo;
  GlobalKey<BotonHoraState> _keyFinalDomingo;

  List<List<GlobalKey<BotonHoraState>>> _keys;


  KeysPorDiaDeBotones(){

  _keyInicioGeneral = GlobalKey<BotonHoraState>(debugLabel: 'botonHora1');
  _keyFinalGeneral = GlobalKey<BotonHoraState>(debugLabel: 'botonHora2');
  _keyInicioLunes = GlobalKey<BotonHoraState>(debugLabel: 'botonHora3');
  _keyFinalLunes = GlobalKey<BotonHoraState>(debugLabel: 'botonHora4');
  _keyInicioMartes = GlobalKey<BotonHoraState>(debugLabel: 'botonHora5');
  _keyFinalMartes = GlobalKey<BotonHoraState>(debugLabel: 'botonHora6');
  _keyInicioMiercoles =
      GlobalKey<BotonHoraState>(debugLabel: 'botonHora7');
  _keyFinalMiercoles = GlobalKey<BotonHoraState>(debugLabel: 'botonHora8');
  _keyInicioJueves = GlobalKey<BotonHoraState>(debugLabel: 'botonHora9');
  _keyFinalJueves = GlobalKey<BotonHoraState>(debugLabel: 'botonHora10');
  _keyInicioViernes = GlobalKey<BotonHoraState>(debugLabel: 'botonHora11');
  _keyFinalViernes = GlobalKey<BotonHoraState>(debugLabel: 'botonHora12');
  _keyInicioSabado = GlobalKey<BotonHoraState>(debugLabel: 'botonHora13');
  _keyFinalSabado = GlobalKey<BotonHoraState>(debugLabel: 'botonHora14');
  _keyInicioDomingo = GlobalKey<BotonHoraState>(debugLabel: 'botonHora15');
  _keyFinalDomingo = GlobalKey<BotonHoraState>(debugLabel: 'botonHora16');

    _keys = [
      [_keyInicioLunes, _keyFinalLunes],
      [_keyInicioMartes, _keyFinalMartes],
      [_keyInicioMiercoles, _keyFinalMiercoles],
      [_keyInicioJueves, _keyFinalJueves],
      [_keyInicioViernes, _keyFinalViernes],
      [_keyInicioSabado, _keyFinalSabado],
      [_keyInicioDomingo, _keyFinalDomingo]
    ];
  }

  List<GlobalKey<BotonHoraState>> keysGenerales(){
    return [_keyInicioGeneral, _keyFinalGeneral];
  }

  List<List<GlobalKey<BotonHoraState>>>keysTodosLosDias(){
    return _keys;
  }

  List<GlobalKey<BotonHoraState>> keysPorIndice(int indice){
    return _keys[indice];
  }

}