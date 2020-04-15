import 'package:agenda/menu/menu.dart';
import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController aliasController = TextEditingController();
  bool hVal = false;
  bool mVal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Container(
            color: Color(0xFF042434),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.only(top: 50, bottom: 0, left: 70, right: 70),
                  child: Image.asset('assets/icon.png'),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20, left: 50, right: 50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[TextFormField(
                      autofocus: true,
                      style: TextStyle(color: Colors.white),
                      controller: aliasController,
                      decoration: InputDecoration(
                        hintText: 'Ingresa un alias',
                        hintStyle: TextStyle(color: Colors.white),
                        labelText: 'Alias',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Por favor, ingresa un alias';
                        }
                      },
                    ),
                    /*Container( 
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Hombre", style: TextStyle(color: Colors.white),),
                          Checkbox(
                              activeColor:Colors.yellow,
                              value: hVal,
                              onChanged: (bool value) {
                                  setState(() {
                                      hVal = value;
                                  });
                              },
                          ),
                          Text("Mujer", style: TextStyle(color: Colors.white),),
                          Checkbox(
                            activeColor:Colors.yellow,
                              value: mVal,
                              onChanged: (bool value) {
                                  setState(() {
                                      mVal = value;
                                  });
                              },
                          ),
                      ],
                    )),*/
                      ])
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: MaterialButton(
                    color: Color(0xFFFFFFF8),
                    textColor: Color(0xFF000000),
                    height: 50,
                    minWidth: 200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(color: Colors.blue),
                    ),
                    child: Text(
                      'ENTRAR',
                      style: TextStyle(fontSize: 22),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Menu(alias: aliasController.text,)),
                        );
                      }
                    },
                  ),
                ),
              ],
            )));
  }
}
