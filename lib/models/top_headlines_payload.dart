import 'package:frontend_notes/enums/categories.dart';
import 'package:frontend_notes/enums/countries.dart';

class TopHeadlinesPayload {
  Countries country;
  Categories category;
  List<String> sources;
  String q;
  int pageSize;
  int page;
  String apiKey;

  TopHeadlinesPayload(
      {this.country,
      this.category,
      this.sources,
      this.q,
      this.pageSize,
      this.page,
      this.apiKey});
}
