import 'package:flutter/material.dart';
import 'package:frontend_notes/services/news_api_service.dart';
import 'package:frontend_notes/filter.dart';
import 'package:frontend_notes/news_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share/share.dart';

class NewsList extends StatefulWidget {
  final Stream<FilterChangeEvent> changes;

  NewsList({Key key, this.changes}) : super(key: key);

  @override
  _NewsListState createState() {
    return _NewsListState();
  }
}

class NewsCard extends StatelessWidget {
  final Map data;

  NewsCard({Key key, this.data}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(data['urlToImage']),
                    ),
                    title: Text(
                      data['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      '${data['source']['name']}, ${data['author']}',
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                    child: Text(data['description']),
                  ),
                  ButtonTheme.bar(
                    child: ButtonBar(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.share,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            Share.share('${data['title']} ${data['url']}');
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.book,
                              color: Theme.of(context).primaryColor),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NewsPage(url: data['url']),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ));
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
        q: lastEvent.q,
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
            q: lastEvent.q,
            domains: lastEvent.domains,
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

  Future _refresh() async {
    return newsApi
        .everything(
            q: lastEvent.q,
            domains: lastEvent.domains,
            language: lastEvent.language,
            sortBy: lastEvent.sortBy,
            page: 1,
            pageSize: pageSize * page)
        .last
        .then((res) {
      setState(() {
        data = res['articles'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final bool isLast = data.length - 1 == index;
          if (isLast) {
            fetch();

            return Column(
              children: <Widget>[
                NewsCard(data: data[index], key: Key(index.toString()),),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: CircularProgressIndicator(),
                )
              ],
            );
          }

          return NewsCard(data: data[index], key: Key(index.toString()),);
        },
      ),
    ));
  }
}
