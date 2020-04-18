import 'package:agenda/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:agenda/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

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
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Un errror")),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Color(0xFF042434),
            body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: 50, bottom: 0, left: 70, right: 70),
                      child: Image.asset('assets/icon.png'),
                    ),
                    Container(
                      width: 300,
                      padding: EdgeInsets.only(bottom: 20, left: 50, right: 50),
                      child: Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            TextFormField(
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
                          ])),
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
                              MaterialPageRoute(
                                  builder: (context) => Menu(
                                        alias: aliasController.text,
                                      )),
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      height: 50,
                      width: 200,
                      child: MaterialButton(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.google,
                              color: Colors.grey[200],
                            ),
                            Expanded(
                              child: Text(
                                "Google",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey[200]),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          BlocProvider.of<AuthenticationBloc>(context)
                              .add(LoginWithGoogle());
                        },
                      ),
                    ),
                  ],
                )));
  }
}
