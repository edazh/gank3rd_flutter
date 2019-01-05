
class Gank {
  final String desc;
  final String url;
  final String who;
  final String pubTime;

  const Gank(this.desc, this.url, this.who, this.pubTime);

   Gank.fromJson(Map<String, dynamic> json)
      : desc = json['desc'],
        url = json['url'],
        who = json['who'],
        pubTime = json['publishedAt'];
  Map<String, dynamic> toJson() =>
      {'desc': desc, 'url': url, 'who': who, 'publishedAt': pubTime};
}
