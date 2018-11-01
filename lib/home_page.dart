import 'package:flutter/material.dart';
import 'package:frontend_notes/filter.dart';
import 'package:frontend_notes/news_list.dart';
import 'dart:async';

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
