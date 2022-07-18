import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/app_routes.dart';
import 'modules/pages/auth_page.dart';
import 'modules/pages/createModel_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: tema
          .copyWith(
              primaryColor: Colors.purple,
              secondaryHeaderColor: Colors.amber,
              errorColor: Colors.red,
              appBarTheme: AppBarTheme(
                  titleTextStyle: TextStyle(
                      fontFamily: 'Open-Sans',
                      fontWeight: FontWeight.bold,
                      fontSize: 20)))
          .copyWith(),
      //home: HomePage(),
      routes: {
        AppRoutes.AUTH_OR_HOME: (ctx) => const AuthOrHomePage(),
        AppRoutes.POST_CREATE: (ctx) => const CreateModelPage(),
      },
    );
  }
}
