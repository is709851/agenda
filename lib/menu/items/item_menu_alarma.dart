import 'package:flutter/material.dart';

class ItemMenuAlarma extends StatefulWidget {
  final String title;
  final int index;
  final int tiempo;
  

  ItemMenuAlarma({Key key, this.title, this.index, this.tiempo}) : super(key: key);

  @override
  _ItemMenuAlarmaState createState() => _ItemMenuAlarmaState();
}

class _ItemMenuAlarmaState extends State<ItemMenuAlarma> {
  bool act = true;


  @override
  Widget build(BuildContext context) {
     DateTime horas = DateTime.fromMillisecondsSinceEpoch(widget.tiempo, isUtc: false);

    return Container(
       decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF737284).withOpacity(0.2)),
       margin: EdgeInsets.only(top: 10),
       padding: EdgeInsets.only(left: 10),
       child: Row(
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
    );
  }
}