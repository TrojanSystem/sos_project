class TransactionModel {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  TransactionModel({
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
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content, // 'checked': checked
    };
  }

  static TransactionModel fromMap(Map<String, dynamic> map) {
    return TransactionModel(
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

  static List<TransactionModel> recipesFromSnapshot(List snapshot) {
    return snapshot.map((e) => TransactionModel.fromMap(e)).toList();
  }
}
