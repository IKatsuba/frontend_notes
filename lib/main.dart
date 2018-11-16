import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import './enums/enums.dart';
import './pages/pages.dart';

void main() => runApp(new MyApp());

FirebaseAnalytics analytics = FirebaseAnalytics();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Raleway',
        primaryColor: Colors.pink.shade600,
        scaffoldBackgroundColor: Colors.grey.shade800,
        cardColor: Colors.black12,
        buttonColor: Colors.pink.shade700,
        canvasColor: Colors.grey.shade700,
        accentTextTheme: TextTheme(
          button: TextStyle(
            color: Colors.pink.shade200
          )
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade700)
          ),
        )
      ),
      routes: {
        Routes.Home: (context) => HomePage(),
        Routes.About: (context) => AboutPage()
      },
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
    );
  }
}
