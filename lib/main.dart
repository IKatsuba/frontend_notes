import 'package:flutter/material.dart';
import 'package:frontend_notes/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
          brightness: Brightness.dark, primaryColor: Colors.pink[700]),
      home: MyHomePage()
    );
  }
}
