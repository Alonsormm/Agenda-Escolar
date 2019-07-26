import 'package:flutter/material.dart';

abstract class BaseTheme{
  Color primary;
  Color background;
  Color accent;
  Color card;
  Color actionBar;


  Color text;
  Color text60;
}

class DarkTheme extends BaseTheme{
  Color primary = Color(0x1E2C3D);
  Color background = Color(0x1E2C3D);
  Color accent = Color(0x00FFF7);
  Color card = Color(0x2A3A4D);
  Color actionBar = Color(0x1E2C3D).withOpacity(0.6);
  Color text = Colors.white;
  Color text60 = Colors.white60;
}