import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsPage extends StatefulWidget {
final String url;

  NewsPage({Key key, this.url}) : super(key: key);

  @override
  _NewsPageState createState() => new _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
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
    );
  }
}
