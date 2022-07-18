import 'package:dart_meteor/dart_meteor.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../components/auth_form.dart';
import 'connecting_page.dart';
import 'home_page.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DdpConnectionStatus>(
        stream: Constants.connection.status(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data!.connected) {
              return StreamBuilder<Map<String, dynamic>?>(
                stream: Constants.connection.user(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return HomePage();
                  }
                  return const AuthPage();
                },
              );
            }
            return ConnectingPage();
          }
          return Container();
        });
  }
}

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).secondaryHeaderColor,
                  // Color.fromRGBO(215, 117, 255, 0.5),
                  // Color.fromRGBO(255, 188, 117, 0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthForm(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
