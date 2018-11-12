import 'package:frontend_notes/enums/enums.dart';

class Source {
  String id;
  String name;
  String description;
  String url;
  Categories category;
  Languages language;
  Countries country;

  Source(
      {this.id,
      this.name,
      this.description,
      this.url,
      this.category,
      this.language,
      this.country});
}
