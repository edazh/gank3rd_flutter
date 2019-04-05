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

/*
 *  干货类型
 */
enum GankType {
  // 福利
  weal,
  android,
  ios,
  // 休息视频
  video,
  // 拓展资源
  resource,
  // 前端
  frontend
}
