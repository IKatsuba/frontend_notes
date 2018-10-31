import 'package:frontend_notes/enums/response_statuses.dart';
import 'package:frontend_notes/models/article.dart';
import 'package:frontend_notes/models/base_response.dart';

class ArticleResponse extends BaseResponse {
  int totalResults;
  List<Article> articles;

  ArticleResponse(
      {this.totalResults,
      this.articles,
      String code,
      String message,
      ResponseStatuses status})
      : super(code: code, message: message, status: status);
}
