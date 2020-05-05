import 'package:flutter/material.dart';

class ItemAlarma extends StatefulWidget {
  final String title;
  final int index;
  final bool lun;
  final bool mar;
  final bool mie;
  final bool jue;
  final bool vie;
  final bool sab;
  final bool dom;
  final int tiempo;
  final bool activada;


  ItemAlarma(
      {Key key,
      this.title,
      this.index,
      this.lun,
      this.mar,
      this.mie,
      this.jue,
      this.vie,
      this.sab,
      this.dom,
      this.tiempo, this.activada})
      : super(key: key);

  @override
  _ItemAlarmaState createState() => _ItemAlarmaState();
}

class _ItemAlarmaState extends State<ItemAlarma> {
  bool importante = false;

  bool lun = false;
  bool mar = false;
  bool mie = false;
  bool jue = false;
  bool vie = false;
  bool sab = false;
  bool dom = false;
  bool act = true;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime horas = DateTime.fromMillisecondsSinceEpoch(widget.tiempo, isUtc: false);


    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF737284).withOpacity(0.4)),
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 10, top: 10),
      height: 140,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Expanded(child: 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                        Container(
                          child: Text(horas.hour.toString(),
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        Container(
                          child: Text(
                            ':',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        Container(
                          child: Text(horas.minute.toString() ?? '',
                          style: TextStyle(fontSize: 40),),
                        ),
                        SizedBox(width: 20,),
                         Container(
                          child: Text(widget.title ?? '',
                          style: TextStyle(fontSize: 12),),
                        ),
                      ]), 
                      flex: 1,
               ),
               Container(
                 child: Switch(
                   value: act,
                   onChanged: (vale){
                     setState(() {
                       act = vale;
                     });
                   },
                 ),
               )                   
                  
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              textDirection: TextDirection.ltr,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
               
                checkbox("L", widget.lun),
                checkbox("M", widget.mar),
                checkbox("Mi", widget.mie),
                checkbox("J", widget.jue),
                checkbox("V", widget.vie),
                checkbox("S", widget.sab),
                checkbox("D", widget.dom)
              ]),
        ],
      ),
    );
  }

  Widget checkbox(String titulo, bool value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(titulo),
        Checkbox(
          value: value,
          onChanged: (_) {
            setState(() {
              switch (titulo) {
                case 'L':
                  lun = widget.lun;
                  break;
                case 'M':
                  mar = widget.mar;
                  break;
                case 'Mi':
                  mie = widget.mie;
                  break;
                case 'J':
                  jue = widget.jue;
                  break;
                case 'V':
                  vie = widget.vie;
                  break;
                case 'S':
                  sab = widget.sab;
                  break;
                case 'D':
                  dom = widget.dom;
                  break;
              }
            });
          },
        )
      ],
    );
  }
}
