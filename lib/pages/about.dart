import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart' show rootBundle;

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FnBar(
          title: Wrap(
            children: <Widget>[Text('About '), FnTitle()],
          ),
          actions: <Widget>[GithubButton()],
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<String>(
                future: rootBundle.loadString('README.md'),
                initialData: '',
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return MarkdownBody(
                    data: snapshot.data,
                  );
                },
              ),
            ),
          ],
        ));
  }
}
