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
          primaryColor: Colors.pink[700],
          fontFamily: 'Raleway'),
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
