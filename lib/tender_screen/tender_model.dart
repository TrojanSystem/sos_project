class TenderNewsModel {
  Map source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  TenderNewsModel({
    this.source,
    this.title,
    this.content,
    this.author,
    this.description,
    this.publishedAt,
    this.url,
    this.urlToImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'source': source,
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content, // 'checked': checked
    };
  }

  static TenderNewsModel fromMap(Map<String, dynamic> map) {
    return TenderNewsModel(
        source: map['source'],
        author: map['author'],
        title: map['title'],
        description: map['description'],
        url: map['url'],
        urlToImage: map['urlToImage'],
        publishedAt: map['publishedAt'],
        content: map['content']

        // checked: map['checked'],
        );
  }

  static List<TenderNewsModel> recipesFromSnapshot(List snapshot) {
    return snapshot.map((e) => TenderNewsModel.fromMap(e)).toList();
  }
}
