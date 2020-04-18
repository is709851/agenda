import 'package:agenda/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:agenda/inicio.dart';
import 'package:agenda/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()async {
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc()..add(VerifyAuthenticatedUser()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticatedSuccessfully) return Menu();
          if (state is UnAuthenticated) return Inicio();
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}

