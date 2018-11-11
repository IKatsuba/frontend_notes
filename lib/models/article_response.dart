import 'package:frontend_notes/enums/response_statuses.dart';
import 'package:frontend_notes/models/article.dart';
import 'package:frontend_notes/models/base_response.dart';

class ArticleResponse extends BaseResponse {
  int totalResults;
  List<Article> articles;
  ResponseStatuses status;

  factory ArticleResponse.fromJSON(json) => ArticleResponse(
      totalResults: json['totalResults'],
      articles: json['articles'],
      code: json['code'],
      message: json['message'],
      status: json['status']);

  ArticleResponse(
      {this.totalResults,
      List articles,
      String code,
      String message,
      String status})
      : super(code: code, message: message) {
    this.articles = articles.map<Article>((val) => Article.fromJSON(val)).toList();
    this.status = ResponseStatuses(status);
  }
}
