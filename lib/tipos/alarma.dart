import 'package:flutter/cupertino.dart';

class Alarma{
  final String titulo;
  final bool lun;
  final bool mar;
  final bool mie;
  final bool jue;
  final bool vie;
  final bool sab;
  final bool dom;
  final bool sonido;
  final int tiempo;
  final bool activada;


  Alarma({this.titulo, this.lun, this.mar, this.mie, this.jue, this.vie, this.sab, this.dom, this.sonido, 
    @required this.tiempo, this.activada, 
  });
}