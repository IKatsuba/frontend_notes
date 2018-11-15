import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamController<FilterChangeEvent> _changeController =
      new StreamController<FilterChangeEvent>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: AppDrawer(),
      appBar: new AppBar(
        actions: <Widget>[
          GithubButton()
        ],
        title: AppTitle(),
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
