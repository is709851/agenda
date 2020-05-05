import 'package:agenda/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:agenda/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:android_alarm_manager/android_alarm_manager.dart';

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController aliasController = TextEditingController();

  @override
  void main() async{
    await AndroidAlarmManager.initialize();
    await AndroidAlarmManager.periodic(Duration(minutes: 1), 0, callback);
  }

void callback(){
  print("I am in the isolate");
}

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
          resizeToAvoidBottomPadding: false,
            backgroundColor: Color(0xFFffd545).withOpacity(0.9),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.only(top: 50, bottom: 0, left: 70, right: 70),
                  child: Image.asset('assets/icon2.png'),
                ),
                Container(
                  width: 300,
                  padding: EdgeInsets.only(bottom: 20, left: 50, right: 50),
                  child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        TextFormField(
                          autofocus: true,
                          controller: aliasController,
                          decoration: InputDecoration(
                            hintText: 'Ingresa un alias',
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
                      ])),
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

                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: MaterialButton(
                    color: Color(0xFFFFFFF8),
                    textColor: Color(0xFF000000),
                    height: 50,
                    minWidth: 200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      
                      side: BorderSide(color: Color(0xFF6D5B1D)),
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
                                    //name: aliasController.text,
                                  )),
                        );
                      }
                    },
                  ),
                ),
              ],
            )));
  }
}
