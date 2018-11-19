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
  NewsListState createState() => NewsListState();
}

class NewsListState extends State<NewsList> with TickerProviderStateMixin {
  Stream<ArticleResponse> dataStream;
  List<Article> data = [];
  AnimationController controller;
  Animation<Offset> animation;
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

    dataStream.listen((val) async {
      await controller.reverse();
      setState(() {
        data = val.articles;
        controller.forward();
      });
    });

    controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    final Animation curve =
        CurvedAnimation(parent: controller, curve: Cubic(.62, .28, .23, .99));
    animation = new Tween<Offset>(
      begin: const Offset(0.0, 3.0),
      end: Offset.zero,
    ).animate(curve);
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
      setState(() async {
        data.addAll(res.articles);
      });
    });
  }

  Future refresh() async {
    return newsApi
        .everything(
            q: lastEvent.q,
            domains: lastEvent.domains,
            language: lastEvent.language,
            sortBy: lastEvent.sortBy,
            page: 1,
            pageSize: pageSize * page)
        .last
        .then((res) async {
      await controller.reverse();
      setState(() {
        data = res.articles;
        controller.forward();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
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

      return SlideTransition(
          position: animation,
          child: FnCard(child: NewsCadr(data[index]), isFirst: index == 0));
    }, childCount: data.length));
  }
}
