import 'package:frontend_notes/enums/languages.dart';
import 'package:frontend_notes/enums/sort_by.dart';

class EverythingPayload {
  String q;
  List<String> sources;
  List<String> domains;
  List<String> excludeDomains;
  String from;
  String to;
  Languages language;
  SortBy sortBy;
  int pageSize;
  int page;
  int apiKey;

  EverythingPayload(
      {this.q,
      this.sources,
      this.domains,
      this.excludeDomains,
      this.from,
      this.to,
      this.language,
      this.sortBy,
      this.pageSize,
      this.page,
      this.apiKey});
}
