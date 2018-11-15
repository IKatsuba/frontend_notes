import 'package:flutter/material.dart';
import './filter.dart';
import './news_list.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamController<FilterChangeEvent> _changeController =
      new StreamController<FilterChangeEvent>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/github.png'),
            onPressed: () {
              launch('https://github.com/IKatsuba/frontend_notes');
            },
          )
        ],
        title: Wrap(
          children: <Widget>[
            Text(
              'Frontend',
              style: TextStyle(
                  color: Theme.of(context).textTheme.caption.color,
                  fontWeight: FontWeight.w400),
            ),
            Text('Notes')
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        child: Column(
          children: <Widget>[
            Filter(
              onChange: (event) {
                _changeController.add(event);
              },
            ),
            NewsList(
              changes: _changeController.stream,
            )
          ],
        ),
      ),
    );
  }
}
