import 'package:flutter/material.dart';

class ItemAlarma extends StatelessWidget {
  final int hora;
  final String zhoraria;
  final bool lunes;
  final bool martes;
  final bool miercoles;
  final bool jueves;
  final bool viernes;
  final bool sabado;
  final bool domingo;
  

  ItemAlarma({Key key, 
              this.hora, 
              this.lunes, 
              this.martes, 
              this.miercoles, 
              this.jueves, 
              this.viernes, 
              this.sabado, 
              this.domingo, 
              this.zhoraria}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 50,
      child: Card(
        elevation: 0.0,
        margin: EdgeInsets.all(2.0),
        color: Color(0xFF56509A), //Color lila
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Text(
                  "$hora",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.grey[200]), 
                  textAlign: TextAlign.center,
                ),
              ),
              flex: 5,
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                ),
                child: Text(
                  "$zhoraria",
                  style: TextStyle(
                    color: Colors.black,
                    ),
                ),
              ),
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}