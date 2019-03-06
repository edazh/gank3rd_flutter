class Gank {
  final String desc;
  final String url;
  final String who;
  final String pubTime;

  const Gank(this.desc, this.url, this.who, this.pubTime);

  Gank.fromJson(Map<String, dynamic> json)
      : desc = json['desc'] as String,
        url = json['url'] as String,
        who = json['who'] as String,
        pubTime = json['publishedAt'] as String;
  Map<String, dynamic> toJson() =>
      {'desc': desc, 'url': url, 'who': who, 'publishedAt': pubTime};
}

class Result {
  final bool error;
  final List<Gank> ganks;
  Result.fromJson(Map<String, dynamic> json)
      : ganks = (json['results'] as List)
            .map((item) => Gank.fromJson(item))
            .toList(),
        error = json['error'];

  Map<String, dynamic> toJson() => {'error': error, 'results': ganks};
}
