import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'PlayPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
              theme: ThemeData(fontFamily: 'NewFont'), home: Splash());
        } else {
          return MaterialApp(
            theme: ThemeData(fontFamily: 'NewFont'),
            routes: {
              '/play': (BuildContext context) => PlayPage(),//いったんこっちを最初に表示してみる
              '/home': (BuildContext context) => HomePage(), //初期画面をこっちにしたい
            },

            home: HomePage(),
          );
        }
      },
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.apartment_outlined,
          size: MediaQuery.of(context).size.width * 0.785,
        ),
      ),
    );
  }
}