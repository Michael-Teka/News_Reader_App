class Article {
  final String title;
  final String url;
  final String? urlToImage;
  final String source;

  Article({
    required this.title,
    required this.url,
    required this.urlToImage,
    required this.source,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No Title',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'],
      source: json['source']['name'] ?? 'Unknown',
    );
  }
}
