import 'package:frontend_notes/enums/enums.dart';

class SourcesPayload {
  Categories category;
  Languages language;
  Countries country;
  String apiKey;

  SourcesPayload({this.category, this.language, this.country, this.apiKey});
}
