import 'package:arquiteturadesoftware/app/app_widget.dart';
import 'package:arquiteturadesoftware/app/modules/home_controller.dart';
import 'package:arquiteturadesoftware/app/modules/models/post_model.dart';
import 'package:arquiteturadesoftware/app/modules/pages/auth_page.dart';
import 'package:arquiteturadesoftware/app/modules/pages/connecting_page.dart';
import 'package:arquiteturadesoftware/app/modules/pages/createModel_page.dart';
import 'package:arquiteturadesoftware/app/modules/pages/home_page.dart';
import 'package:arquiteturadesoftware/app/modules/repositories/home/home_repository_impl.dart';
import 'package:arquiteturadesoftware/utils/app_routes.dart';
import 'package:arquiteturadesoftware/utils/constants.dart';
import 'package:dart_meteor/dart_meteor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  setUp(() {
    Constants.currentcontroller = HomeController(HomeRepositoryImpl());
  });

  group("Home Page Test", ()  {
    // testWidgets("Login in to Meteor", (tester) async {//
    //   Constants.connection;
    //   await tester.pumpWidget(const MaterialApp(
    //     home: AuthOrHomePage()
    //   ));
    //   expect(find.byType(Container), findsOneWidget);
    //   await tester.pumpAndSettle();
    //
    //   expect(find.text("Senha"), findsOneWidget);
    //   //expect(find.byType(FloatingActionButton), findsOneWidget);
    //   //expect(find.byIcon(Icons.add), findsOneWidget);
    //   //expect(find.byType(CircularProgressIndicator), findsOneWidget);
    // });

    testWidgets("Home Page - Click and load, edit", (tester) async {//
      await tester.pumpWidget(MaterialApp(
          home: HomePage()
      ));
      expect(find.text('Home Page'), findsOneWidget);
      await tester.pumpAndSettle();
      //expect(find.byType(CircularProgressIndicator), findsOneWidget);
      //await tester.pumpAndSettle();
      expect(find.byType(ListTile), findsNWidgets(3));

      await tester.tap(find.byKey(Key('1')));

      await tester.pumpAndSettle();
      expect(find.text("Descrição"), findsOneWidget);
      expect(find.text("Título do post"), findsOneWidget);
      expect(find.text("Publicar"), findsOneWidget);
    });//

    testWidgets("Home Page - Click and load, add", (tester) async {//
      await tester.pumpWidget(MaterialApp(
          home: HomePage(),
          routes: {
            AppRoutes.POST_CREATE: (ctx) => const CreateModelPage(),
          },
      ));
      expect(find.text('Home Page'), findsOneWidget);
      await tester.pumpAndSettle();
      //expect(find.byType(CircularProgressIndicator), findsOneWidget);
      //await tester.pumpAndSettle();
      expect(find.byType(ListTile), findsNWidgets(3));

      await tester.tap(find.byKey(const Key('add')));

      await tester.pumpAndSettle();
      expect(find.text('Criar novo post'), findsOneWidget);
      expect(find.text("Título do post"), findsOneWidget);
      expect(find.text("Publicar"), findsOneWidget);
    });//
  });
}