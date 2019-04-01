import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:frontend_notes/widgets/widgets.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: MaxWidth(
          child: FnBar(
            title: Wrap(
              children: <Widget>[
                Text('About '),
                FnTitle(),
              ],
            ),
            actions: <Widget>[
              GithubButton(),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: MaxWidth(
        child: ListView(
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
        ),
      ),
    );
  }
}
