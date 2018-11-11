class ArticleSource {
  String id;
  String name;

  ArticleSource({this.id, this.name});

  factory ArticleSource.fromJSON(json) => ArticleSource(id: json['id'], name: json['name'])
;}

class Article {
  ArticleSource source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Article(
      {source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content}){
        this.source = ArticleSource.fromJSON(source);
      }

  factory Article.fromJSON(json) => Article(
      source: json['source'],
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content']);
}
