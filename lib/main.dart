import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import './enums/enums.dart';
import './pages/pages.dart';
import './services/services.dart';

import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void main() async {
  await config.init();

  runApp(new FrontendNotesApp());
}

FirebaseAnalytics analytics = FirebaseAnalytics();

class FrontendNotesApp extends StatefulWidget {
  @override
  _FrontendNotesAppState createState() => _FrontendNotesAppState();
}

class _FrontendNotesAppState extends State<FrontendNotesApp> {
  @override
  void initState() {
    super.initState();

    _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Frontend Notes',
      theme: new ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Raleway',
          primaryColor: Colors.pink.shade600,
          scaffoldBackgroundColor: Colors.grey.shade800,
          cardColor: Colors.black12,
          buttonColor: Colors.pink.shade700,
          canvasColor: Colors.grey.shade700,
          accentTextTheme:
              TextTheme(button: TextStyle(color: Colors.pink.shade200)),
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade700)),
          )),
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
