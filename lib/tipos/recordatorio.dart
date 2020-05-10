import 'package:flutter/cupertino.dart';

class Recordatorio {
  final String titulo;
  final String descripcion;
  final bool lun;
  final bool mar;
  final bool mie;
  final bool jue;
  final bool vie;
  final bool sab;
  final bool dom;
  DateTime hora;
  String cada;
  String mhmd;
  
  

  Recordatorio(
      {@required this.titulo,
      @required this.descripcion,
      this.lun,
      this.mar,
      this.mie,
      this.jue,
      this.vie,
      this.sab,
      this.dom,
      this.hora,});
}
