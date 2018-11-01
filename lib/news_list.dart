import 'package:flutter/material.dart';
import 'package:frontend_notes/services/news_api_service.dart';
import 'package:frontend_notes/filter.dart';
import 'package:frontend_notes/news_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsList extends StatefulWidget {
  final Stream<FilterChangeEvent> changes;

  NewsList({Key key, this.changes}) : super(key: key);

  @override
  _NewsListState createState() {
    return _NewsListState();
  }
}

class _NewsListState extends State<NewsList> {
  Stream dataStream;
  List data = [];

  FilterChangeEvent lastEvent;
  int page = 1;
  int pageSize = 10;

  @override
  void initState() {
    super.initState();

    dataStream = widget.changes.asyncExpand((FilterChangeEvent event) {
      lastEvent = event;
      page = 1;
      return Stream.fromFuture(Firestore.instance
          .collection('params')
          .document('newsQuery')
          .get()
          .then((snapshot) => event
            ..q = snapshot.data['q']
            ..domains = snapshot.data['domains']));
    }).asyncExpand((FilterChangeEvent event) => newsApi.everything(
        q: event.q,
        domains: event.domains,
        language: event.language,
        sortBy: event.sortBy,
        page: page,
        pageSize: pageSize));

    dataStream.listen((val) {
      setState(() {
        data = val['articles'];
      });
    });
  }

  void fetch() {
    if (lastEvent == null) return;
    page += 1;

    newsApi
        .everything(
            language: lastEvent.language,
            sortBy: lastEvent.sortBy,
            page: page,
            pageSize: pageSize)
        .listen((res) {
      setState(() {
        data.addAll(res['articles']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final bool isLast = data.length - 1 == index;
        if (isLast) {
          fetch();
        }

        return Card(
            key: Key(index.toString()),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(data[index]['urlToImage']),
                  ),
                  title: Text(
                    data[index]['title'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${data[index]['source']['name']}, ${data[index]['author']}',
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: Text(data[index]['description']),
                ),
                ButtonTheme.bar(
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Text('READ',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            )),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewsPage(url: data[index]['url']),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
    ));
  }
}
