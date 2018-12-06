import '../enums/enums.dart';

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
      category,
      language,
      country}) {
    this.category = Categories(category);
    this.language = Languages(language);
    this.country = Countries(country);
  }

  factory Source.fromJSON(json) => Source(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      url: json['url'],
      category: json['category'],
      language: json['language'],
      country: json['country']);
}
