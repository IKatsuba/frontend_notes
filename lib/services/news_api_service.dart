import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend_notes/enums/enums.dart';
import 'package:frontend_notes/constants.dart';
import '../models/models.dart';
import './config.dart';

class _NewsApiService {
  String apiKey;
  String apiUrl;

  _NewsApiService(this.apiKey, this.apiUrl);

  Stream _fetch(String url, {Map<String, String> body}) async* {
    final String queies = List.from((body ?? {}).entries)
        .where((val) => val.value != null)
        .map((val) => '${val.key}=${val.value}')
        .join('&');

    final response = await http.get(Uri.encodeFull('$apiUrl/$url?$queies'),
        headers: {'X-Api-Key': apiKey});
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

  Stream<ArticleResponse> everything(
      {String q,
      List<String> sources,
      List domains,
      List<String> excludeDomains,
      String from,
      String to,
      Languages language,
      SortBy sortBy,
      int pageSize,
      int page,
      String apiKey}) {
    return _fetch('everything', body: {
      'q': q,
      'sources': sources?.join(','),
      'domains': domains?.join(','),
      'excludeDomains': excludeDomains?.join(','),
      'from': from,
      'to': to,
      'language': language.value,
      'sortBy': sortBy.value,
      'pageSize': pageSize?.toString(),
      'page': page?.toString(),
      'apiKey': apiKey
    }).map((res) => ArticleResponse.fromJSON(res));
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

final newsApi =
    new _NewsApiService(config.getNewsApiKey(), API_URL);
