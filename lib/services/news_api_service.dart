import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend_notes/enums/countries.dart';
import 'package:frontend_notes/enums/categories.dart';
import 'package:frontend_notes/enums/languages.dart';
import 'package:frontend_notes/enums/sort_by.dart';
import 'package:frontend_notes/constants.dart';

class _NewsApiService {
  String apiKey;
  String apiUrl;

  _NewsApiService(this.apiKey, this.apiUrl);

  Stream _fetch(String url, {Map<String, String> body}) async* {
    final String queies = List.from((body ?? {}).entries)
        .where((val) => val.value != null)
        .map((val) => '${val.key}=${val.value}')
        .join('&');

    final response =
        await http.get('$apiUrl/$url?$queies', headers: {'X-Api-Key': apiKey});

    yield json.decode(response.body);
  }

  Stream topHeadlines(
      {Countries country,
      Categories category,
      List<String> sources,
      String q,
      int pageSize,
      int page,
      String apiKey}) {
    return _fetch('top-headlines', body: {
      'country': country.value,
      'category': category.value,
      'sources': sources?.join(','),
      'q': q,
      'pageSize': pageSize?.toString(),
      'page': page?.toString(),
      'apiKey': apiKey
    });
  }

  Stream everything(
      {String q,
      List<String> sources,
      List<String> domains,
      List<String> excludeDomains,
      String from,
      String to,
      Languages language,
      SortBy sortBy,
      int pageSize,
      int page,
      String apiKey}) {
    return _fetch('everything', body: {
      // 'q': q,
      'q': "(javascript OR (android AND flutter) OR (ios AND flutter) OR typescript OR css OR scss OR nodejs OR node.js OR angular OR react OR npm OR browsers OR браузеры OR web OR фронтенд OR frontend OR NOT ('java' OR 'разработка игр' OR e-commerce OR iptelefon))",
      'sources': sources?.join(','),
      // 'domains': domains?.join(','),
      'domains': 'habr.com',
      'excludeDomains': domains?.join(','),
      'from': from,
      'to': to,
      'language': language.value,
      'sortBy': sortBy.value,
      'pageSize': pageSize?.toString(),
      'page': page?.toString(),
      'apiKey': apiKey
    });
  }

  sources(
      {Categories category,
      Languages language,
      Countries country,
      String apiKey}) {
    return _fetch('sources', body: {
      'category': category?.value,
      'language': language?.value,
      'country': country?.value,
      'apiKey': apiKey
    });
  }
}

final newsApi = new _NewsApiService('022242c86959436495a04d00b0635a24', API_URL);