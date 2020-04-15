import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormAlarmas extends StatefulWidget {
  FormAlarmas({Key key}) : super(key: key);

  @override
  _FormAlarmasState createState() => _FormAlarmasState();
}

class _FormAlarmasState extends State<FormAlarmas> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController tituloController = new TextEditingController();
  FocusNode _textFocus = new FocusNode();
  String title;
  bool isSwitched =false;

  var date = new DateTime.now();

  @override
  void initState(){
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Center(
              child: Text('Nueva Alarma'),
            ),
            backgroundColor: Color(0xFF042434),
          ),
          body: Container(
            padding: EdgeInsets.only(top: 40),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    
                Container(
                    height: 200,
                    width: 50,
                    child: Center(
                      child:TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: TextStyle(fontSize: 72),
                        inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                        ],
                    ),),
                  ),
                  Text(':', style: TextStyle(fontSize: 72),),
                  Container(
                    height: 200,
                    width: 100,
                    child: Center(
                      child:TextField(
                        keyboardType: TextInputType.datetime,
                        maxLength: 2,
                        style: TextStyle(fontSize: 72),
                        inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                        ],
                    ),),
                  ),
                  ],),
                  
                  Container(
                    margin: EdgeInsets.only(bottom: 20, left: 30, right: 30),
                    child:TextField(
                      controller: tituloController,
                      decoration: InputDecoration(
                        hintText: 'Título',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
              ),
              Container(
                child: null,
              ),
              Container(
                margin: EdgeInsets.only(top: 50, bottom: 10),
                child: Text('Repetir', style: TextStyle(fontSize: 16),),
              ),
              
              Container(
                padding: EdgeInsets.only(right: 30, bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      width: 0,
                      child:  RaisedButton(
                        child: Text("D"), onPressed: () {}, splashColor: Colors.blue,
                      ),
                    ),
                    Container(
                      width: 0,
                      child:  FlatButton(
                        child: Text("L"), onPressed: () {},
                      ),
                    ),
                    Container(
                      width: 0,
                      child:  FlatButton(
                        child: Text("M"), onPressed: () {},
                      ),
                    ),
                    Container(
                      width: 0,
                      child:  FlatButton(
                        child: Text("M"), onPressed: () {},
                      ),
                    ),
                    Container(
                      width: 0,
                      child:  FlatButton(
                        child: Text("J"), onPressed: () {},
                      ),
                    ),
                    Container(
                      width: 0,
                      child:  FlatButton(
                        child: Text("V"), onPressed: () {},
                      ),
                    ),
                    Container(
                      width: 0,
                      child:  FlatButton(
                        child: Text("S"), onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text('Sonido: ', style: TextStyle(fontSize: 16),),
              ),
              Switch(
                    value: isSwitched,
                    onChanged: (value) {
              setState(() {
                isSwitched = value;
                print(isSwitched);
              });},
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 80),
                width: 450,
                height: 60,
                decoration: BoxDecoration(color: Color(0xFF075061)),
                child: MaterialButton(
                  onPressed: null,
                  child: Text(
                    'GUARDAR',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}