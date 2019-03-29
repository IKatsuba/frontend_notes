import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_api/news_api.dart';
import 'package:rxdart/rxdart.dart';

import 'config.dart';

final newsApi =
    NewsApiService(remoteConfig.getNewsApiKey(), remoteConfig.getNewsApiUrl());

class FilterChangeEvent {
  Languages language;
  SortBy sortBy;
  int page;

  FilterChangeEvent({this.language, this.sortBy, this.page = 1});
}

class _NewsService {
  final NewsApiService _api = NewsApiService(
      remoteConfig.getNewsApiKey(), remoteConfig.getNewsApiUrl());
  FilterChangeEvent lastEvent;

  Future<List<Article>> changeFilter(FilterChangeEvent event) async {
    lastEvent = event;
    final DocumentSnapshot snapshot = await Firestore.instance
        .collection('params')
        .document('newsQuery')
        .get();

    return _api
        .everything(
            q: snapshot.data['q'],
            domains: snapshot.data['domains'],
            language: event.language,
            sortBy: event.sortBy,
            page: 1,
            pageSize: 10 * event.page)
        .map((res) => res.articles)
        .first;
  }

  Future<List<Article>> refresh() async {
    if (lastEvent == null) {
      return <Article>[];
    }

    return changeFilter(lastEvent..page = 1);
  }

  Future<List<Article>> nextPage() async {
    if (lastEvent == null) {
      return <Article>[];
    }

    return changeFilter(lastEvent..page += 1);
  }
}

class NewsService {
  final PublishSubject<List<Article>> _articles =
      PublishSubject<List<Article>>();

  Stream<List<Article>> get articles => _articles.stream;

  final _NewsService _news = _NewsService();

  changeFilter(FilterChangeEvent event) async {
    _articles.sink.add(await _news.changeFilter(event));
  }

  nextPage() async {
    _articles.sink.add(await _news.nextPage());
  }

  refresh() async {
    _articles.sink.add(await _news.refresh());
  }

  dispose() {
    _articles.close();
  }
}

final newsService = NewsService();
