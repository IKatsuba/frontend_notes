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

  AnimationController slideController;
  Animation<Offset> slideAnimation;

  AnimationController opacityController;
  Animation<double> opacityAnimation;

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
      await opacityController.forward();
      slideController.reset();
      opacityController.reset();
      setState(() {
        data = val.articles;
        slideController.forward();
      });
    });

    slideController = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);

    slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 3.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: slideController, curve: Cubic(.62, .28, .23, .99)));

    opacityController = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);

    opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0,
    ).animate(CurvedAnimation(
        parent: opacityController, curve: Cubic(.62, .28, .23, .99)));
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
      await opacityController.forward();
      slideController.reset();
      opacityController.reset();
      setState(() {
        data = res.articles;
        slideController.forward();
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

      return FadeTransition(
        opacity: opacityAnimation,
        child: SlideTransition(
            position: slideAnimation,
            child: FnCard(child: NewsCadr(data[index]), isFirst: index == 0)),
      );
    }, childCount: data.length));
  }
}
