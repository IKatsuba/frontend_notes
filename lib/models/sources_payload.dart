import 'package:frontend_notes/enums/categories.dart';
import 'package:frontend_notes/enums/countries.dart';
import 'package:frontend_notes/enums/languages.dart';

class SourcesPayload {
  Categories category;
  Languages language;
  Countries country;
  String apiKey;

  SourcesPayload({this.category, this.language, this.country, this.apiKey});
}
