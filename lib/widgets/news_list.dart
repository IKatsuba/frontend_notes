import 'package:flutter/material.dart';
import '../services/services.dart';
import './filter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/models.dart';
import './fn_card.dart';
import './news_card.dart';

class NewsList extends StatefulWidget {
  final Stream<FilterChangeEvent> changes;

  NewsList({Key key, this.changes}) : super(key: key);

  @override
  _NewsListState createState() {
    return _NewsListState();
  }
}

class _NewsListState extends State<NewsList> {
  Stream<ArticleResponse> dataStream;
  List<Article> data = [];

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
        data = val.articles;
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
        data.addAll(res.articles);
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
        data = res.articles;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        final bool isLast = data.length - 1 == index;
        if (isLast) {
          fetch();

          return Column(
            children: <Widget>[
              FnCard(
                child: NewsCadr(data[index]),
                key: Key(index.toString()),
                isLast: isLast,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: CircularProgressIndicator(),
              )
            ],
          );
        }

        return FnCard(
          child: NewsCadr(data[index]),
          key: Key(index.toString()),
          isFirst: index == 0,
        );
      }, childCount: data.length)),
    );
  }
}
